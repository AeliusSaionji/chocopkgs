$packageName = 'wsltty'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$url64 = "https://github.com/mintty/wsltty/releases/download/${version}/wsltty-${version}-install.exe"
$checksum64 = '{{Checksumx64}}'
$checksumType64 = 'SHA512'

Install-ChocolateyZipPackage $packageName -UnzipLocation $toolsdir -Url64bit $url64 `
-Checksum64 $checksum64 -ChecksumType64 $checksumType64 

New-Item -Path $toolsdir -Name bin -ItemType Directory
Move-Item "$toolsdir\cygwin1.dll"               -Destination "$toolsdir\bin"
Move-Item "$toolsdir\cygwin-console-helper.exe" -Destination "$toolsdir\bin"
Move-Item "$toolsdir\mintty.exe"                -Destination "$toolsdir\bin"
Move-Item "$toolsdir\wslbridge.exe"             -Destination "$toolsdir\bin"
Move-Item "$toolsdir\wslbridge-backend"         -Destination "$toolsdir\bin"
Move-Item "$toolsdir\zoo.exe"                   -Destination "$toolsdir\bin"
