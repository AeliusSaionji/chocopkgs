# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.39.0.1005-1b0839a8/PlexMediaPlayer-2.39.0.1005-1b0839a8-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = 'f0add737e28a3a6cfba0d187de1abf1fa2303d3bbc580fc2a7e839d40df8d5a6'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
Write-Output 'plexmediaplayer is being replaced by a newer client simply called plex. Looking for the newer client? choco install plex'
