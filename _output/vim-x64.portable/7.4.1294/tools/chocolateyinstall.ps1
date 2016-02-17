$packageName = 'vim-x64.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim74"
$url = "http://tuxproject.de/projects/vim/complete-x64.7z"

Install-ChocolateyZipPackage $packageName $url $destDir
