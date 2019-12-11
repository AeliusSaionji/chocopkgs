# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.47.0.1035-e74d341b/PlexMediaPlayer-2.47.0.1035-e74d341b-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = '10b484478ee0ed8840a37e1b64bdca279422999570f6cd380f8e6854203e168e'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
Write-Host 'plexmediaplayer is being replaced by a newer client simply called plex. Looking for the newer client? choco install plex'
