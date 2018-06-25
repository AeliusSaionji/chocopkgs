$packageArgs = @{
  PackageName = 'LatencyMon'
  fileType = 'EXE'
  SilentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url = 'http://www.resplendence.com/download/LatencyMon.exe'
  checksum = 'd7bd679030c2c2986c4c88e3935a53fe0acb850e568db274e39c60014b5b6ae1'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
