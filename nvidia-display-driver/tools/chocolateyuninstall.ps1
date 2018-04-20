$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = 'geforce-game-ready-driver'
  softwareName  = 'NVIDIA Graphics Driver*'
  fileType      = 'EXE'
  validExitCodes= @(0)
}

$packageArgs['file']       = (Get-UninstallRegistryKey $packageArgs['softwareName']).UninstallString -replace "\s.*$"
$packageArgs['silentArgs'] = (Get-UninstallRegistryKey $packageArgs['softwareName']).UninstallString -replace "^.*?\s" -replace "$"," -silent"

Uninstall-ChocolateyPackage @packageArgs