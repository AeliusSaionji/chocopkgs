$packageName = 'Ditto.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$version2 = $version.Replace(".","_")
$url = "https://sourceforge.net/projects/ditto-cp/files/Ditto/$version/DittoPortable_$version2.zip/download"
$url64 = "https://sourceforge.net/projects/ditto-cp/files/Ditto/$version/DittoPortable_64bit_$version2.zip/download"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

# Kill ditto before updating
Get-Process | Where { $_.name -eq 'ditto' } | Stop-Process

Install-ChocolateyZipPackage $packageName $url $toolsdir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

# Tells ditto to pretend it's installed, settings and database will be stored in the user's profile
# To actually use ditto in portable mode, it would need to be installed to BinRoot
Remove-Item $(Join-Path "$toolsDir" "Ditto\portable")
