# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.42.0.1013-712b8c6f/PlexMediaPlayer-2.42.0.1013-712b8c6f-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = 'c504f889d2c4e4abf876cbcdb982d4328dcc12abf9bd5858d9f9b6b1b6f851a2'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
Write-Host 'plexmediaplayer is being replaced by a newer client simply called plex. Looking for the newer client? choco install plex'
