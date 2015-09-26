$packageName = 'HWiNFO'
$shouldUninstall = $true

$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HWiNFO64_is1'
# 32bit version will be here on a 32bit OS
$machine_key32  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HWiNFO32_is1'
# If you installed the 32bit version on a 64bit OS you're doing it wrong
# But I'm covering that eventuality here anyway.
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\HWiNFO32_is1'

$file = @($machine_key, $machine_key32, $machine_key6432) `
    | ?{ Test-Path $_ } `
    | Get-ItemProperty `
    | Select-Object -ExpandProperty UninstallString

if ($file -eq $null -or $file -eq '') {
    Write-Host "$packageName has already been uninstalled by other means."
    $shouldUninstall = $false
}

$installerType = 'EXE' 
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$validExitCodes = @(0)

# I can't explain why this doesn't work, my powershell is not strong
#if (!(Test-Path $file)) {
#    Write-Host "$packageName has already been uninstalled by other means."
#    $shouldUninstall = $false
#}

if ($shouldUninstall) {
 Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
}
