$packageName = 'vim-x64.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim74"

Start-ChocolateyProcessAsAdmin "-nsis" "$destDir\uninstal.exe" -validExitCodes '0'
