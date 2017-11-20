$packageName = 'nvidia-display-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$unpackFile = "${ENV:TEMP}\nvidiadriver.zip"
$unpackDir  = "${ENV:TEMP}\nvidiadriver"
$instDir    = "${ENV:TEMP}\nvidiainstall"
$file = "$instDir\setup.exe"
$url   = 'https://us.download.nvidia.com/Windows/388.31/388.31-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/388.31/388.31-desktop-win10-64bit-international-whql.exe'
$checksum   = '0fc79bc49fdd397e67fbc3fd4d6a946432de36a9ab76acdeb09e1aafe6e7c428'
$checksum64 = '1d4ea731fe49cd2070a00d645bdba4118d1f6792e67afb15fac716b3e177ca59'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/388.31/388.31-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/388.31/388.31-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '3bacac7183d74fb4be54b34be81af7d876e1af56f8a2934f438d61adbde678c9'
	$checksum64 = '51ef082e0f016c09dfa6423b6d966f80d8edf1912b27e26e2c261a4106c9627b'
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

