$packageName = 'nvidia-display-driver'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$unpackFile = "${ENV:TEMP}\nvidiadriver.zip"
$unpackDir  = "${ENV:TEMP}\nvidiadriver"
$instDir    = "${ENV:TEMP}\nvidiainstall"
$file = "$instDir\setup.exe"
$url   = 'https://us.download.nvidia.com/Windows/388.71/388.71-desktop-win10-32bit-international-whql.exe'
$url64 = 'https://us.download.nvidia.com/Windows/388.71/388.71-desktop-win10-64bit-international-whql.exe'
$checksum   = 'ff4376f57549f3761efff19c74afd246c01628a1eed0f57a84b4cdb73c8b25a5'
$checksum64 = '5675cab5a713efaaedbbd5a6d489d0ddbc06a0edb4ae5e423901180b2dd17f12'
$checksumType = 'sha256'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = 'https://us.download.nvidia.com/Windows/388.71/388.71-desktop-win8-win7-32bit-international-whql.exe'
	$url64 = 'https://us.download.nvidia.com/Windows/388.71/388.71-desktop-win8-win7-64bit-international-whql.exe'
	$checksum   = '6d2833b5a579eef7eb77c9375acb026378093c17ecd118fd4ef28261d55a8887'
	$checksum64 = '9c5ce59b61bc45eda41223e317759fb18ad329e5e8267ca1320d2a01f742a8a8'
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

