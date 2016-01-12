$packageName = 'LatencyMon'
$registryUninstallerKeyName = 'LatencyMon_is1'
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
$silentArgs = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$validExitCodes = @(0)

#if (!(Test-Path $file)) {
#    Write-Host "$packageName has already been uninstalled by other means."
#    $shouldUninstall = $false
#}

if ($shouldUninstall) {
 Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
}
