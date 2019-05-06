$packageArgs = @{
  PackageName = 'LatencyMon'
  fileType = 'EXE'
  SilentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url = 'http://www.resplendence.com/download/LatencyMon.exe'
  checksum = 'eb582cdc4aedbe4626a90f3170040bcac4012d8aa354596b949a0fc6115dc802'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
