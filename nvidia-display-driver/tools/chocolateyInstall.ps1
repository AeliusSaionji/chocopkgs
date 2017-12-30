$packageName = 'nvidia-display-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$unpackFile = "${ENV:TEMP}\nvidiadriver.zip"
$unpackDir  = "${ENV:TEMP}\nvidiadriver"
$instDir    = "${ENV:TEMP}\nvidiainstall"
$file = "$instDir\setup.exe"
$url   = 'https://us.download.nvidia.com/Windows/388.59/388.59-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/388.59/388.59-desktop-win10-64bit-international-whql.exe'
$checksum   = '3d8171d3d0cde71f26a0dd78d019685ca42952406fa13e5a637986ccbbd37658'
$checksum64 = '08d5ee127f4e34f14bf03776a6bf93c03cba18dd3134ca8bc72557fe09cb9d02'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/388.59/388.59-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/388.59/388.59-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '0a5b32c1d9499a8280b0efce998aca77567349a96e787a042b5bffe39d1c3288'
	$checksum64 = '1e07422ec2973b717e11bbd5860a675b0922e3ef1ef1c97fd00c6c8cd77856db'
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

