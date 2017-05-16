$packageName = 'nvidia-display-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$unpackFile = "${ENV:TEMP}\nvidiadriver.zip"
$unpackDir = "${ENV:TEMP}\nvidiadriver"
$instDir = New-Item -Path "${ENV:TEMP}\nvidiainstall" -ItemType Directory
$file = "$instDir\setup.exe"
$url   = 'https://us.download.nvidia.com/Windows/382.05/382.05-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/382.05/382.05-desktop-win10-64bit-international-whql.exe'
$checksum   = '0d0a58e7f7bcd163a850ff54f6b5c94ecee3871225568f2da1dc911e2f71561a'
$checksum64 = 'a1bbae7aba440bce85f793528a1ce3352b4d34244d1c53606b58c30c99169c57'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/382.05/382.05-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/382.05/382.05-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '672d9f8f9c54d0accfb91a61f1a55685b23a598372ea568e0a6b75290d375e38'
	$checksum64 = '1A059C83E8980CAE434DD6FE5C38F163CB58EA4CF6CA4A851C38281BD0DEB55C2FBC3C43A5A723270F4A1B99B038FE0DCF3CBC0A65E7C468BC3A24229F1173E2'
}

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

# Clean up
Remove-Item "$instDir" -Recurse -Force
