$packageName = 'x264vfw'
$fileFullPath = "$ENV:Temp\x264vfw.exe"
$fileType = 'EXE'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/x264vfw/files/latest/download'
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url `
-Checksum $checksum -ChecksumType $checksumType
