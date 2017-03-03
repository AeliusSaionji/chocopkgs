$packageName = 'vim-tux.install'
$destDir = Join-Path $ENV:ProgramFiles "Vim"

Start-ChocolateyProcessAsAdmin "-nsis" "$destDir\vim80\uninstal.exe" -validExitCodes '0'
Remove-Item $destDir -Force -Recurse
