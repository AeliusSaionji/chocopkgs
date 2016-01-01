$packageName = 'mupen64plus'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '{{PackageVersion}}'
$url         = "https://github.com/mupen64plus/mupen64plus-core/releases/download/$version/mupen64plus-bundle-win32-$version.zip"

Install-ChocolateyZipPackage $packageName $url $toolsDir
