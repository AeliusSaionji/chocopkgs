$packageArgs = @{
  PackageName  = 'LatencyMon'
  fileType     = 'EXE'
  SilentArgs   = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url          = 'https://www.resplendence.com/download/LatencyMon.exe'
  checksum     = '7de921e0d395366ac6ca93c2fee06db08d0ef41eae87fe6c11c75ac8dcd870af'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
