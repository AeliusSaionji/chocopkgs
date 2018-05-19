$packageName = 'vim-tux.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim81"

Get-ChildItem "$destDir\*.bat" | %{ Uninstall-BinFile -Name $_.BaseName -Path $_ }
