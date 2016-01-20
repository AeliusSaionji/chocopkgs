$packageName = 'VcXsrv'
$installerType = 'exe'
$silentArgs = '/S'
$version = '1.17.5.1'
$url = "http://sourceforge.net/projects/vcxsrv/files/vcxsrv/${version}/vcxsrv.${version}.installer.exe/download"
$url64 = "http://sourceforge.net/projects/vcxsrv/files/vcxsrv/${version}/vcxsrv-64.${version}.installer.exe/download"

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64
