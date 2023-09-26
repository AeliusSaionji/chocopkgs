# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'plex'
  fileType       = 'EXE'
  url64          = 'https://downloads.plex.tv/plex-desktop/1.79.1.3984-879339ed/windows/Plex-1.79.1.3984-879339ed-x86_64.exe'
  silentArgs     = '/S'
  softwareName   = 'Plex' 
  checksum64     = 'ed605071b6208ab9a1842b2c2f75bc9a13e2be0f'
  checksumType64 = 'sha1'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
Get-Process | Where { $_.name -eq 'Plex' } | Stop-Process
