$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '0.5.1'
$url = "https://github.com/The-Compiler/qutebrowser/releases/download/v$version/qutebrowser-$version-windows-standalone-win32.zip"
$url64 = "https://github.com/The-Compiler/qutebrowser/releases/download/v$version/qutebrowser-$version-windows-standalone-amd64.zip"

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
