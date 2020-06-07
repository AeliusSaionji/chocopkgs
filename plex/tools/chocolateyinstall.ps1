# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.10.0.1208-daa6b641/windows/Plex-1.10.0.1208-daa6b641-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = '5DA767FBE859D78C86B1B2EC151D7A824985ED234EA3A240770E17E26CF07741'
  checksumType64 = 'sha1'  
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
