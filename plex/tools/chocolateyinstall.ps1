# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.2.0.875-b7362913/windows/Plex-1.2.0.875-b7362913-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = 'a40efe64153fdc63e297996da9e03272e2df228acd526e13a58ba18c67d0ddc1'
  checksumType64 = 'sha256'  
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
