$packageName = 'vim-x64.portable'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$fileFullPath = Join-Path "$toolsDir" 'vimInstall.exe'
$version = '{{PackageVersion}}'
$url = "https://bintray.com/artifact/download/veegee/generic/vim${version}_x64.exe"
$checksum = '{{Checksum}}'
$checksumType = 'SHA1'

Get-ChocolateyWebFile $packageName $fileFullPath $url -checksum $checksum -checksumType $checksumType

# Extract using 7z
$outPath = "-o$toolsDir"
7z x $outPath $fileFullPath -aoa
Remove-Item "$fileFullPath"
Remove-Item "$toolsDir\`$TEMP" -Recurse
Remove-Item "$toolsDir\`$PLUGINSDIR" -Recurse
Remove-Item "$toolsDir\vim74\install.exe"
Remove-Item "$toolsDir\vim74\uninstal.exe"
Remove-Item "$toolsDir\vim74\uninstall-gui.exe"
