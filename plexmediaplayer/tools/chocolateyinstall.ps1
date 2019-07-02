# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.36.0.988-0150ae52/PlexMediaPlayer-2.36.0.988-0150ae52-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = '56541be706ccc8365d4ded0af651d3c89d7727624522d45909e47dca505651e6'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
