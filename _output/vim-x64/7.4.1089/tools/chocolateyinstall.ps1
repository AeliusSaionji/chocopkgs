$packageName = 'vim-x64'
$installerType = 'exe'
$silentArgs = '/S'
$version = '7.4.1089'
$url = "https://bintray.com/artifact/download/veegee/generic/vim${version}_x64.exe"
$checksum = '7c8af950581c63d6523e6f2a8cde0f4f20a743bd'
$checksumType = 'SHA1'

if ( Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4" ) {
# An uninstaller that doesn't accept arguments (nor does it even work) will run if this key exists
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4' -ErrorAction SilentlyContinue
# Manually uninstall, it must have tried to run an uninstaller for a reason
Write-Output "Rebooting explorer to release a handle"
Get-Process | Where { $_.name -eq 'explorer'      } | Stop-Process -Force
Get-Process | Where { $_.name -eq 'FreeCommander' } | Stop-Process -Force
Remove-Item -Path "$ENV:ProgramFiles\Vim" -Force -Recurse
}

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -checksum $checksum -checksumType $checksumType

# This is a key presumably created for uninstalling context menu and other integrations
# UninstallString is invalid, other uninstaller handles that stuff just fine.
# This entry is just garbage/clutter and upsets chocolateyuninstall.ps1
Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Vim_x64" -ErrorAction SilentlyContinue
