# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.37.2.996-bea4f9ca/PlexMediaPlayer-2.37.2.996-bea4f9ca-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = '68072c0fdd20693106c922d259f889e84661d982ca2d35ff8591f84a2766368d'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
