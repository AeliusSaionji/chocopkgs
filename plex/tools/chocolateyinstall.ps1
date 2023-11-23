# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.82.2.4024-64f483f6/windows/Plex-1.82.2.4024-64f483f6-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = 'b2f2965a250187505d41b0680d40e4b954213339'
  checksumType64 = 'sha1'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
Get-Process | Where { $_.name -eq 'Plex' } | Stop-Process
