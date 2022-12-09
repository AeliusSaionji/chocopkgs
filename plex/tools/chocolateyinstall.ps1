# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.59.1.3398-dab42972/windows/Plex-1.59.1.3398-dab42972-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = 'fcb50763780d4261e6719cc7e9a04e9108fcf187'
  checksumType64 = 'sha1'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
Get-Process | Where { $_.name -eq 'Plex' } | Stop-Process
