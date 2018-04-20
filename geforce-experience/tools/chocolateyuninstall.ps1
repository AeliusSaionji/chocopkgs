$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = 'geforce-experience'
  softwareName  = 'NVIDIA Geforce Experience*'
  fileType      = 'EXE'
  validExitCodes= @(0)
}

$packageArgs['file']       = (Get-UninstallRegistryKey 'NVIDIA Geforce Experience*').UninstallString -replace "\s.*$"
$packageArgs['silentArgs'] = (Get-UninstallRegistryKey 'NVIDIA Geforce Experience*').UninstallString -replace "^.*?\s" -replace "$"," -silent"

Uninstall-ChocolateyPackage @packageArgs