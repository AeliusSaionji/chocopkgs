$packageName = 'vim-x64'
$registryUninstallerKeyName = 'Vim 7.4'
$shouldUninstall = $true

$machine_key   = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"

$file = $machine_key `
    | ?{ Test-Path $_ } `
    | Get-ItemProperty `
    | Select-Object -ExpandProperty UninstallString

if ($file -eq $null -or $file -eq '') {
    Write-Host "$packageName has already been uninstalled by other means."
    $shouldUninstall = $false
}

$installerType = 'EXE' 
$silentArgs = '/S'
$validExitCodes = @(0)

#if (!(Test-Path $file)) {
#    Write-Host "$packageName has already been uninstalled by other means."
#    $shouldUninstall = $false
#}


if ($shouldUninstall) {
 Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
}
