$packageName = 'vim-x64.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim74"
Write-Output "Rebooting explorer to release a handle"
Get-Process | Where { $_.name -eq 'explorer'      } | Stop-Process -Force
Get-Process | Where { $_.name -eq 'FreeCommander' } | Stop-Process -Force
Start-ChocolateyProcessAsAdmin "-nsis" "$destDir\uninstal.exe" -validExitCodes '0'
