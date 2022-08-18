# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.52.1.3195-a0c4d5e9/windows/Plex-1.52.1.3195-a0c4d5e9-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = '7e643802b929cf196606f5943f8cc4a4cfaeedc8'
  checksumType64 = 'sha1'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
Get-Process | Where { $_.name -eq 'Plex' } | Stop-Process
