$packageName = 'nvidia-display-driver'
$version = '{{PackageVersion}}'
$fileType = 'exe'
$silentArgs = '-s -noreboot'
$unpackFile = "${ENV:TEMP}\nvidiadriver.zip"
$unpackDir = "${ENV:TEMP}\nvidiadriver"
$instDir = New-Item -Path "${ENV:TEMP}\nvidiainstall" -ItemType Directory
$file = "$instDir\setup.exe"
$url   = "http://us.download.nvidia.com/Windows/{{PackageVersion}}/{{PackageVersion}}-desktop-win10-32bit-international-whql.exe"
$url64 = "http://us.download.nvidia.com/Windows/{{PackageVersion}}/{{PackageVersion}}-desktop-win10-64bit-international-whql.exe"
$checksum   = '0d5a0504686c746a0ea4d5991eb44b90c2dcf8a2dedb0c6d92c66e17d66b44640b611eb0a9ba9ce8551457cf3dabef235fab285c6eebb1be8ef42076e079e5d2'
$checksum64 = '6da8be24473ced2bf3f64d2da220a9ba79a130741aded40418521384adad28151461276d9edf9801d8e8ae3551a5ca8662ed49201235912128d4cf5f941711d9'
$checksumType = 'SHA512'

If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
	$url   = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-32bit-international-whql.exe"
	$url64 = "http://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql.exe"
	$checksum   = 'e1dc9b104e77646aa8f1d6dff1ab33b0c4b145014f3e0a6ecac921030f8a4ba9225ddbbdac152dc159194a97df3971b561c2ecb5321f7bc7faaefd4e8695a7b6'
	$checksum64 = '7782a6009b4372e35ad3a806a7bfce9ecdc9d6be444458b97cbc283677b6f98aba3c2b367431f3ce96caa93b50caa37baef1da4f3c2086ada1879bab0674d833'
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
