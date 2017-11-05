$packageName = 'Ditto.install'
$version = '3.21.185.0'
$version2 = $version.Replace(".","_")
$url = "https://sourceforge.net/projects/ditto-cp/files/Ditto/$version/DittoSetup_$version2.exe/download"
$url64 = "https://sourceforge.net/projects/ditto-cp/files/Ditto/$version/DittoSetup_64bit_$version2.exe/download"
$installerType = 'exe'
$silentArgs = '/sp- /silent /norestart'
$checksum = 'F00D4E895110881CB79BA893939A1A0FF05AE9F6404EED2EC9A1792F9921D09F'
$checksum64 = 'E7ED94A1426F5905CFE7B00B58E7C0E89CE7ACBF8A9B92FA0AA8A0567182F081'
$checksumType = 'SHA256'

# The installer doesn't properly kill ditto
Get-Process | Where { $_.name -eq 'ditto' } | Stop-Process
Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

