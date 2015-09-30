$packageName = 'LatencyMon'
$fileType = 'EXE'
$silentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'http://www.resplendence.com/download/LatencyMon.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
