$packageName = 'vim-x64'
$registryUninstallerKeyName = 'Vim 7.4'
$shouldUninstall = $true
$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

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
#$silentArgs = '/S'
$validExitCodes = @(0)

#if (!(Test-Path $file)) {
#    Write-Host "$packageName has already been uninstalled by other means."
#    $shouldUninstall = $false
#}


if ($shouldUninstall) {
 # Enforce elevation until chocolatey bug is resolved
 Start-Process powershell -ArgumentList "Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -validExitCodes $validExitCodes -File $file" -Verb RunAs
 # Uninstaller doesn't seem to work properly, so let's clean up after it
 # Explorer handle prevents removal, reboot explorer
 Get-Process | Where { $_.name -eq 'explorer' } | Stop-Process
 # I hope you don't have any documents open in the editor you're uninstalling...
 Get-Process | Where { $_.name -eq 'vim'      } | Stop-Process
 Get-Process | Where { $_.name -eq 'gvim'     } | Stop-Process
 Start-Process PowerShell -ArgumentList "-File $scriptPath\housekeeping.ps1" -Verb RunAs
}
