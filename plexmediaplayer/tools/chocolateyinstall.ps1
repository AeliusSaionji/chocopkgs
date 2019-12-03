# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.46.0.1031-6dc7c723/PlexMediaPlayer-2.46.0.1031-6dc7c723-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = 'e37a56f3f4bdeadbd5e5a43bab241e6613278dfcef50091ca120fe479b6d95fd'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
Write-Host 'plexmediaplayer is being replaced by a newer client simply called plex. Looking for the newer client? choco install plex'
