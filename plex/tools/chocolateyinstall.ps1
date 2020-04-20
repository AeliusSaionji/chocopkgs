# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.9.0.1188-c009e512/windows/Plex-1.9.0.1188-c009e512-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = '5c3d6506578602e9c1e17415b4f9dbdb91029bb23cd47c6d91f17c41816cdfb6'
  checksumType64 = 'sha256'  
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
