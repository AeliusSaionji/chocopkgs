$packageName = 'mpv.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '2017.09.13'
$version = $version.Replace(".","")
$url = "https://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "https://mpv.srsfckn.biz/mpv-x86_64-$version.7z"
$urlAssoc = 'https://github.com/rossy/mpv-install/archive/master.zip'
$checksum = '980d5e000972e1108486ea605ebc5498070a9c75c22d9d83b2caca4fd7435e64c2bb4b61ef4c802ea662491f3bd2ff9a8bcec6c1ea75947d436aa2f823002dbc'
$checksum64 = '2002b41827ff3aab4ebb38d0ad3442312405085473e3078babbbecb987775e6d5fef9538092c659288202dc43562813d6d971e4063ad9a40a94787920ee0e4c3'
$checksumType = 'SHA512'

# Enable TLS 1.2 manually. Someone remind me to remove this bit when Chocolatey 0.9.11 is released
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls12'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64

Install-ChocolateyZipPackage "associations" $urlAssoc $toolsDir
Move-Item "$toolsDir\mpv-install-master\*" $toolsDir -Force
Remove-Item "$toolsDir\mpv-install-master"
Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-install.bat /u" 'cmd.exe' -validExitCodes '0'

# mpv can't be shimmed, the shim doesn't work with mpv.com
# as of 2016.01.18, there is a dll dependency, so mpv can't be hardlinked to chocolatey\bin
# adding to PATH until chocolatey implements a /usr/lib equivalent
$pathType = 'User'
If ( Test-ProcessAdminRights ) { $pathType = 'Machine' }
Install-ChocolateyPath $toolsDir $pathType
