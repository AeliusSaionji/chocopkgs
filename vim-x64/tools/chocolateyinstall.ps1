$packageName = 'vim-x64' # arbitrary name for the package, used in messages
$fileFullPath = "$ENV:Temp\vim-x64.exe"
$fileType = 'exe'
$silentArgs = '/S'
$version = '{{PackageVersion}}'
$url = "https://bintray.com/artifact/download/veegee/generic/vim${version}_x64.exe"
$checksum = '{{Checksum}}'
$checksumType = 'SHA1'

# Elevation bug, omitted until further notice
#Install-ChocolateyPackage $packageName $fileType $silentArgs $url -checksum $checksum -checksumType $checksumType
Get-ChocolateyWebFile $packageName $fileFullPath $url -checksum $checksum -checksumType $checksumType
Start-Process -FilePath $fileFullPath -ArgumentList $silentArgs -Verb RunAs
