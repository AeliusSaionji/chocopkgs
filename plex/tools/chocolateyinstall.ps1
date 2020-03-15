# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.6.3.1009-57cf57c8/windows/Plex-1.6.3.1009-57cf57c8-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = 'e187fa658aec86b12c8b906f65fcd03383f14735f2356ee5cec2e57ef1c45e23'
  checksumType64 = 'sha256'  
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
