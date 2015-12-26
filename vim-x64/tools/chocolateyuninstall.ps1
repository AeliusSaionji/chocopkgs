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
 # Uninstaller doesn't seem to work properly, so let's clean up after it
 # Explorer handle prevents removal, reboot explorer
 Get-Process | Where { $_.name -eq 'explorer'      } | Stop-Process -Force
 Get-Process | Where { $_.name -eq 'FreeCommander' } | Stop-Process -Force
 # I hope you don't have any documents open in the editor you're upgrading
 Get-Process | Where { $_.name -eq 'vim'           } | Stop-Process -Force
 Get-Process | Where { $_.name -eq 'gvim'          } | Stop-Process -Force
 Remove-Item -Path "$ENV:ProgramFiles\Vim" -Force -Recurse
 Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4' -Force -Recurse
 Remove-Item -Path 'HKLM:\SOFTWARE\Vim' -Force -Recurse
}
