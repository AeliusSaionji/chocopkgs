$packageName = 'vim-tux.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim74"
$url = "http://tuxproject.de/projects/vim/complete-x86.7z"
$url64 = "http://tuxproject.de/projects/vim/complete-x64.7z"

Get-ChildItem "$destDir\*.bat" | %{ Install-BinFile -Name $_.BaseName -Path $_ }
Install-ChocolateyZipPackage $packageName $url $destDir $url64
Start-Process "$destDir\install.exe" -ArgumentList "-add-start-menu" -WorkingDirectory "$destDir" -Wait
Write-Output "Build provided by TuxProject.de - consider donating to help support their server costs."
