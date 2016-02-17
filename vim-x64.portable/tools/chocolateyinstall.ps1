$packageName = 'vim-x64.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim74"
$url = "http://tuxproject.de/projects/vim/complete-x64.7z"
$url64 = $url

Get-ChildItem "$destDir\*.bat" | %{ Install-BinFile -Name $_.BaseName -Path $_ }
Install-ChocolateyZipPackage $packageName $url $destDir $url64
Start-Process "$destDir\install.exe" -ArgumentList "-add-start-menu" -WorkingDirectory "$destDir" -Wait