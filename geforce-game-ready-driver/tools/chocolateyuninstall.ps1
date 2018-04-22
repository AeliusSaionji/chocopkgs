$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = 'geforce-game-ready-driver'
  softwareName  = 'NVIDIA Graphics Driver*'
  fileType      = 'EXE'
  validExitCodes= @(0)
}

$packageArgs['file']       = (Get-UninstallRegistryKey $packageArgs['softwareName']).UninstallString -replace "\s.*$"
$packageArgs['silentArgs'] = (Get-UninstallRegistryKey $packageArgs['softwareName']).UninstallString -replace "^.*?\s" -replace "$"," -silent"

If ( -not $env:ChocolateyForce) {
  Write-Warning 'Uninstalling this package will forcibly reboot your PC.'
  Write-Warning 'If you wish to proceed, please specify the --force parameter.'
  Write-Error 'Uninstall not called with --force. Aborting.'
}

Uninstall-ChocolateyPackage @packageArgs