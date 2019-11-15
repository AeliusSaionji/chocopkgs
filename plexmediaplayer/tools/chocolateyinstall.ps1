# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.45.0.1028-45edbf41/PlexMediaPlayer-2.45.0.1028-45edbf41-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = 'd17f64231f5815286eaf43c6adf5ae4d05f02f6d44373a5d407fe8e627167382'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
Write-Host 'plexmediaplayer is being replaced by a newer client simply called plex. Looking for the newer client? choco install plex'
