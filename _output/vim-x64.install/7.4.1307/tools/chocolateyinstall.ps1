$packageName = 'vim-x64.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim74"
$url = "http://tuxproject.de/projects/vim/complete-x64.7z"
$url64 = $url

# Remove traces of Veege's Build
if ( (Get-ItemProperty -ErrorAction SilentlyContinue 'HKLM:\software\microsoft\windows\currentversion\uninstall\Vim 7.4\').UninstallString -eq "$ENV:ProgramFiles\Vim\vim74\uninstall-gui.exe" ) {
 Write-Output "New build installs to ChocolateyLib. Removing from Program Files."
 Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4' -ErrorAction SilentlyContinue
 Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Vim_x64" -ErrorAction SilentlyContinue
 Write-Output "Rebooting explorer to release a handle"
 Get-Process | Where { $_.name -eq 'explorer'      } | Stop-Process -Force
 Get-Process | Where { $_.name -eq 'FreeCommander' } | Stop-Process -Force
 Remove-Item -Path "$ENV:ProgramFiles\Vim" -Force -Recurse
}

Write-Output "Rebooting explorer to release a handle"
Get-Process | Where { $_.name -eq 'explorer'      } | Stop-Process -Force
Get-Process | Where { $_.name -eq 'FreeCommander' } | Stop-Process -Force

Install-ChocolateyZipPackage $packageName $url $destDir $url64
Start-ChocolateyProcessAsAdmin "-create-batfiles evim view gview vimdiff gvimdiff -install-popup -install-openwith -add-start-menu" "$destDir\install.exe" -validExitCodes '0'
