$packageArgs = @{
  PackageName = 'LatencyMon'
  fileType = 'EXE'
  SilentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url = 'http://www.resplendence.com/download/LatencyMon.exe'
  checksum = 'a88bcc5b64761371b3023705b29798938bf06f711b61a1c178b55a536e7819c9'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
