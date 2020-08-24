$packageArgs = @{
  PackageName = 'LatencyMon'
  fileType = 'EXE'
  SilentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url = 'http://www.resplendence.com/download/LatencyMon.exe'
  checksum = 'e7c0125193a42530bc2f9004f67e62562a557399d14154e6a58cab68545ab08e'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
