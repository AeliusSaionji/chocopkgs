$packageName = 'vim-tux.install'
$destDir = Join-Path $ENV:ProgramFiles "Vim\vim80"
$url = "https://tuxproject.de/projects/vim/complete-x86.7z"
$url64 = "https://tuxproject.de/projects/vim/complete-x64.7z"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $destDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

Start-ChocolateyProcessAsAdmin "-create-batfiles vim gvim evim view gview vimdiff gvimdiff -install-popup -install-openwith -add-start-menu" "$destDir\install.exe" -validExitCodes '0'
Write-Output "Build provided by TuxProject.de - consider donating to help support their server costs."
