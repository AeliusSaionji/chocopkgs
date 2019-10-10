# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.3.1.916-1cb2c34d/windows/Plex-1.3.1.916-1cb2c34d-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = '4d2fec5579b2d0ff9bf62ab872e07cff72f726736b4ca184098387dc56994f32'
  checksumType64 = 'sha256'  
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
