$packageName = 'LatencyMon'
$fileType = 'EXE'
$silentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'http://www.resplendence.com/download/LatencyMon.exe'
$checksum = 'ad014cb1b2fb7da4c9b55683309cebb043108ae96c87589a46a29c55b27cd01a'
$checksumType = 'SHA256'

Install-ChocolateyPackage -PackageName $packageName -FileType $fileType -SilentArgs $silentArgs -Url $url `
-Checksum $checksum -ChecksumType $checksumType
