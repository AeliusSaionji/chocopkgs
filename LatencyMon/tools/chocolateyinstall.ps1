$packageName = 'LatencyMon'
$fileType = 'EXE'
$silentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'http://www.resplendence.com/download/LatencyMon.exe'
$checksum = '64e6f99f84300615d244e94eabe644bdea41289d9c850e4a9b862af070a641f50b71699402903a8608c1eb118c8731d7f039d003488191848f3d49106e6ee706'
$checksumType = 'sha512'

Install-ChocolateyPackage -PackageName $packageName -FileType $fileType -SilentArgs $silentArgs -Url $url -Checksum $checksum -ChecksumType $checksumType
