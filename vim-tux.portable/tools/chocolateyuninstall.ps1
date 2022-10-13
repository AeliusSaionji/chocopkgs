$packageName = 'vim-tux.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$versPath = 'vim90'
$destDir = Join-Path $toolsDir $versPath

Get-ChildItem "$destDir\*.bat" | %{ Uninstall-BinFile -Name $_.BaseName -Path $_ }
