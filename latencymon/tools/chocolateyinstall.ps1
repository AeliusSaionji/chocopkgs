$packageArgs = @{
  PackageName = 'LatencyMon'
  fileType = 'EXE'
  SilentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url = 'http://www.resplendence.com/download/LatencyMon.exe'
  checksum = 'e6c8fe0d2b4b03566e40a5e7a4474108f23df2f3709d677f8d925c7d858e5082'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
