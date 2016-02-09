$packageName = 'vim-x64.portable'
Write-Output "Rebooting explorer to release a handle"
Get-Process | Where { $_.name -eq 'explorer'      } | Stop-Process -Force
Get-Process | Where { $_.name -eq 'FreeCommander' } | Stop-Process -Force
