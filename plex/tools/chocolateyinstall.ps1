# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.4.1.940-574c2fa7/windows/Plex-1.4.1.940-574c2fa7-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = '19F0959F0F7953AE40A3A0039DA85741B2F6381C4C662BCB47222EE11938E6B5'
  checksumType64 = 'sha256'  
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
