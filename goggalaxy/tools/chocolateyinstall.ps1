$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://content-system.gog.com/open_link/download?path=/open/galaxy/client/setup_galaxy_1.2.54.23.exe'
  softwareName  = 'GOG Galaxy*'
  checksum      = '423a465f98350a2c16abe1dfcf56b5fab7e5683f82d96ea055665b5e3316e911'
  checksumType  = 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,1) # Code 1 - Same or newer version already installed. Uninstall before trying to downgrade.
}

Install-ChocolateyPackage @packageArgs
