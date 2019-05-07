$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://content-system.gog.com/open_link/download?path=/open/galaxy/client/setup_galaxy_1.2.56.15.exe'
  softwareName  = 'GOG Galaxy*'
  checksum      = '1f63315e0e5533c05935f006ce2b13e319cb0c345ba3ed38afa31ec451c62468'
  checksumType  = 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,1) # Code 1 - Same or newer version already installed. Uninstall before trying to downgrade.
}

Install-ChocolateyPackage @packageArgs
