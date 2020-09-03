$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://webinstallers.gog.com/download/GOG_Galaxy_2.0.exe'
  softwareName  = 'GOG Galaxy*'
  checksum      = 'fd627d2c37bb5fa3540384fb2923dbfefa1b222d8c34e14f9127c8971efb093e'
  checksumType  = 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,1) # Code 1 - Same or newer version already installed. Uninstall before trying to downgrade.
}

Install-ChocolateyPackage @packageArgs
