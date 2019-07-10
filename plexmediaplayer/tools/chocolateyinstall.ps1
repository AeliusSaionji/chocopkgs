# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.37.1.994-ac3132ba/PlexMediaPlayer-2.37.1.994-ac3132ba-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = '2ffc16a36e152e8e533d3cdaa08103a7b2e637c574ec1ccfbaf30e40511c51c7'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
