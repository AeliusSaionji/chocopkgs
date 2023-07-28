$packageArgs = @{
  PackageName  = 'LatencyMon'
  fileType     = 'EXE'
  SilentArgs   = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url          = 'https://www.resplendence.com/download/LatencyMon.exe'
  checksum     = 'd4e472879954380f5fbc49e2d5be8c5dbd75d5cf8908dd77278472598c6d17af'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
