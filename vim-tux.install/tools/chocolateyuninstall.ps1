$packageName = 'vim-tux.install'
$destDir = Join-Path $ENV:ProgramFiles "Vim"

# Apparently doesn't have a non-interactive mode. Send 'y' to its input
Set-Content -Path "$env:TEMP\vimuninstallinput" -Value 'y'
Start-Process -FilePath "$destDir\vim80\uninstal.exe" -ArgumentList '-nsis' -RedirectStandardInput "$env:TEMP\vimuninstallinput" -Wait
Remove-Item "$env:TEMP\vimuninstallinput"
Remove-Item $destDir -Force -Recurse
