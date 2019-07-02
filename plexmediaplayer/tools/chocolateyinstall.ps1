# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plexmediaplayer'
  fileType       = 'EXE'
  url64          = ''
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = ''
  checksumType64 = ''  
}

Install-ChocolateyPackage @packageArgs
