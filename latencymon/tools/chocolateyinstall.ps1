$packageArgs = @{
  PackageName  = 'LatencyMon'
  fileType     = 'EXE'
  SilentArgs   = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url          = 'https://www.resplendence.com/download/LatencyMon.exe'
  checksum     = '77E90F0F042F9806639DE25C67FA78948696CB635C8F47C4F11E92CD6162A2AE'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
