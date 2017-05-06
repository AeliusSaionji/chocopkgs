$packageName = 'LatencyMon'
$fileType = 'EXE'
$silentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'http://www.resplendence.com/download/LatencyMon.exe'
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyPackage -PackageName $packageName -FileType $fileType -SilentArgs $silentArgs -Url $url `
-Checksum $checksum -ChecksumType $checksumType
