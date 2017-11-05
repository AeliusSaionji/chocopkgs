$packageName = 'Ditto.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '3.21.185.0'
$version2 = $version.Replace(".","_")
$url = "https://sourceforge.net/projects/ditto-cp/files/Ditto/$version/DittoPortable_$version2.zip/download"
$url64 = "https://sourceforge.net/projects/ditto-cp/files/Ditto/$version/DittoPortable_64bit_$version2.zip/download"
$checksum = 'F438A687365A4DB7738576CBCEA6DEF65912F420AD5B48E255B85E7A220609E5'
$checksum64 = '2EC0349C93B646093E8B051C1AF56B2D0EB4EC29DECB59F19BAC4455439976A8'
$checksumType = 'SHA256'

# Kill ditto before updating
Get-Process | Where { $_.name -eq 'ditto' } | Stop-Process

Install-ChocolateyZipPackage $packageName $url $toolsdir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

# Tells ditto to pretend it's installed, settings and database will be stored in the user's profile
# To actually use ditto in portable mode, it would need to be installed to BinRoot
Remove-Item $(Join-Path "$toolsDir" "Ditto\portable")
