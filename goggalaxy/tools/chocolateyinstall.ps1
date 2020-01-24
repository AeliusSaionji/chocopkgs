$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://content-system.gog.com/open_link/download?path=/open/galaxy/client/setup_galaxy_1.2.66.64.exe'
  softwareName  = 'GOG Galaxy*'
  checksum      = '1cdae5bf95666f822ecec358b1b48d8af39f0a85e7962bf417574c8814e21f77'
  checksumType  = 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,1) # Code 1 - Same or newer version already installed. Uninstall before trying to downgrade.
}

Install-ChocolateyPackage @packageArgs
