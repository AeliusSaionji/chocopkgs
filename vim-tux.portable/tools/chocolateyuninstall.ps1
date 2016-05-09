$packageName = 'vim-tux.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim74"

Get-ChildItem "$destDir\*.bat" | %{ Uninstall-BinFile -Name $_.BaseName -Path $_ }
Start-Process "$destDir\uninstal.exe" -ArgumentList "-nsis" -Wait
