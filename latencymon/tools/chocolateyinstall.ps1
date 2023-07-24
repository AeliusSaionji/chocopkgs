$packageArgs = @{
  PackageName  = 'LatencyMon'
  fileType     = 'EXE'
  SilentArgs   = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url          = 'https://www.resplendence.com/download/LatencyMon.exe'
  checksum     = 'a80709b42ac42870cf793eff0c855ab8f051c82b479a778f25687dc4df4905c7'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
