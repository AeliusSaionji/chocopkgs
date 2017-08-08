$packageName = 'nvidia-display-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$unpackFile = "${ENV:TEMP}\nvidiadriver.zip"
$unpackDir  = "${ENV:TEMP}\nvidiadriver"
$instDir    = "${ENV:TEMP}\nvidiainstall"
$file = "$instDir\setup.exe"
$url   = 'https://us.download.nvidia.com/Windows/384.94/384.94-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/384.94/384.94-desktop-win10-64bit-international-whql.exe'
$checksum   = '9be45db25c564b4f4f2d049046284ff25030582b312651ce2a32c76f4add0d03'
$checksum64 = 'f9c2d43319ca2c6a31245509416de15f73feb8b18ed1e58da8efb3f7e711bf53'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/384.94/384.94-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/384.94/384.94-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = 'ba71e41cb4799d3a556d0954a7742037eb6c85cd354c0ea3e485f6737dfbb146'
	$checksum64 = '4a0a63092c8308815e4d8d4a0872f0a51b8f8bcd165e6d87004589142a8fd5f1'
}

# Clean up
Remove-Item "$instDir" -Recurse -Force
New-Item -Path "$instDir" -ItemType Directory

# Download driver package as a zip
Get-ChocolateyWebFile $packageName $unpackFile $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 

# Unzip driver package
Get-ChocolateyUnzip $unpackFile $unpackDir

# Inclusive filter
Move-Item "$unpackDir\Display.Driver"  -Destination "$instDir"
Move-Item "$unpackDir\Display.Optimus" -Destination "$instDir"
Move-Item "$unpackDir\NVI2"            -Destination "$instDir"
Move-Item "$unpackDir\PhysX"           -Destination "$instDir"
Move-Item "$unpackDir\EULA.txt"        -Destination "$instDir"
Move-Item "$unpackDir\license.txt"     -Destination "$instDir"
Move-Item "$unpackDir\ListDevices.txt" -Destination "$instDir"
Move-Item "$unpackDir\setup.cfg"       -Destination "$instDir"
Move-Item "$unpackDir\setup.exe"       -Destination "$instDir"
Remove-Item "$unpackDir" -Recurse -Force

# Finally, install
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -ValidExitCodes @(0,1)

