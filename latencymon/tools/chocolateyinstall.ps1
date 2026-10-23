$packageArgs = @{
  PackageName  = 'LatencyMon'
  fileType     = 'EXE'
  SilentArgs   = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url          = 'https://www.resplendence.com/download/LatencyMon.exe'
  checksum     = 'c124342da2a844da0699901476b27226da1d0d30bf8e940c9f847d67d46a1157'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
