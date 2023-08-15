# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.76.2.3951-15712eae/windows/Plex-1.76.2.3951-15712eae-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = 'f624ab0611e359e6ab7fe3164881b319295008ff'
  checksumType64 = 'sha1'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
Get-Process | Where { $_.name -eq 'Plex' } | Stop-Process
