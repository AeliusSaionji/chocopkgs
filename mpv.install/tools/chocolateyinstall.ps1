$packageName = 'mpv.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$url = "https://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "https://mpv.srsfckn.biz/mpv-x86_64-$version.7z"
$urlAssoc = 'https://github.com/rossy/mpv-install/archive/master.zip'
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
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
