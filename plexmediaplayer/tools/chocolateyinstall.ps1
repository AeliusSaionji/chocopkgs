# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.38.0.999-e14e4d74/PlexMediaPlayer-2.38.0.999-e14e4d74-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = '0eebfad18ae1a64c294391a0d7958f5164ae01f319c5f55316286dfb9a22c833'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
