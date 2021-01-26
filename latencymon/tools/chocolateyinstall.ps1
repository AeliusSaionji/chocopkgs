$packageArgs = @{
  PackageName = 'LatencyMon'
  fileType = 'EXE'
  SilentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  url = 'http://www.resplendence.com/download/LatencyMon.exe'
  checksum = '77e90f0f042f9806639de25c67fa78948696cb635c8f47c4f11e92cd6162a2ae'
  checksumType = 'SHA256'
}

Install-ChocolateyPackage @packageArgs
