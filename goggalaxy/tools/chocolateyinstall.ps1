$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://content-system.gog.com/open_link/download?path=/open/galaxy/client/setup_galaxy_2.0.14.257.exe'
  softwareName  = 'GOG Galaxy*'
  checksum      = '7e5464ef5274d69f9d5f246d27431bbfc23d326b2bf72d602c3137119062f30c'
  checksumType  = 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,1) # Code 1 - Same or newer version already installed. Uninstall before trying to downgrade.
}

Install-ChocolateyPackage @packageArgs
