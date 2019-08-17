# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.0.0.792-d4adb056/windows/Plex-1.0.0.792-d4adb056-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = 'EADE2911FB39E5EDB1A53AD04312DD8F1386AC98A4EF3B845407176A36AFE16F'
  checksumType64 = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
