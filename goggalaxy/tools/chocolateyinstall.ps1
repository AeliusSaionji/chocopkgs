$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://content-system.gog.com/open_link/download?path=/open/galaxy/client/2.0.64.31/setup_galaxy_2.0.64.31a.exe'
  softwareName  = 'GOG Galaxy*'
  checksum      = 'a1aef5ddc47d1d246478700e44a9c19f'
  checksumType  = 'md5'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,1) # Code 1 - Same or newer version already installed. Uninstall before trying to downgrade.
}

$pp = Get-PackageParameters
  If ($pp['stopprocess'] -eq 'true') {
    Get-Process GalaxyClient -ErrorAction 0 | Stop-Process
}
Install-ChocolateyPackage @packageArgs
