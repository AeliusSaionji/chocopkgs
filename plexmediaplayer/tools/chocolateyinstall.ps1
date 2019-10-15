# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plexmediaplayer/2.44.0.1018-8f77cbb9/PlexMediaPlayer-2.44.0.1018-8f77cbb9-windows-x64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = '24b7878f86b0fe8cf19f490b33b1220945db9c0ab1f5138e2a6d181d63c0ee80'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
Write-Host 'plexmediaplayer is being replaced by a newer client simply called plex. Looking for the newer client? choco install plex'
