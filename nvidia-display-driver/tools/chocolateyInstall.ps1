$packageName = 'nvidia-display-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$unpackFile = "${ENV:TEMP}\nvidiadriver.zip"
$unpackDir  = "${ENV:TEMP}\nvidiadriver"
$instDir    = "${ENV:TEMP}\nvidiainstall"
$file = "$instDir\setup.exe"
$url   = 'https://us.download.nvidia.com/Windows/391.24/391.24-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/391.24/391.24-desktop-win10-64bit-international-whql.exe'
$checksum   = '5d97cf8f4910c67b62de71f546cff34d8344557b9144f6262c85ee4ba1e6242e'
$checksum64 = '6c03c8deb7724b44f71333f06e8799d033a0d658e6d9d0a8841d72a6d4d08640'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/391.24/391.24-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/391.24/391.24-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = 'eab6a65bc57dbdd63b08ec9f601121c92caed70686d7a80a411772f3b4673f51'
	$checksum64 = '50a8b696d7374d11005639daaff189f5f08de66d685b41ad1e3d7342144594ca'
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
$pp = Get-PackageParameters
if ( $pp.NV3DVision ) {
  Move-Item "$unpackDir\NV3DVision"               -Destination "$instDir"
  Move-Item "$unpackDir\NV3DVisionUSB.Driver"     -Destination "$instDir"
}
if ( $pp.HDAudio ) {
  Move-Item "$unpackDir\HDAudio"                  -Destination "$instDir"
}
Remove-Item "$unpackDir" -Recurse -Force

# Finally, install
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file -ValidExitCodes @(0,1)

