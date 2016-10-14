$packageName = 'antimicro.portable'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '{{PackageVersion}}'
$url         = "https://github.com/AntiMicro/antimicro/releases/download/$version/antimicro-$version-portable-win32.zip"

Install-ChocolateyZipPackage $packageName $url $toolsDir
