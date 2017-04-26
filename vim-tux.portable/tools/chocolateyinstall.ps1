$packageName = 'vim-tux.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destDir = Join-Path $toolsDir "vim80"
$url = "https://tuxproject.de/projects/vim/complete-x86.7z"
$url64 = "https://tuxproject.de/projects/vim/complete-x64.7z"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $destDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

Get-ChildItem "$destDir\*.bat" | %{ Install-BinFile -Name $_.BaseName -Path $_ }
Start-Process "$destDir\install.exe" -ArgumentList "-add-start-menu" -WorkingDirectory "$destDir"
Write-Output "Build provided by TuxProject.de - consider donating to help support their server costs."
