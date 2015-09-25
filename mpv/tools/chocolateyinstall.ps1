$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'mpv' # arbitrary name for the package, used in messages
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://mpv.srsfckn.biz/mpv-i686-20150923.7z' # download url
$url64 = 'http://mpv.srsfckn.biz/mpv-x86_64-20150923.7z' # 64bit URL here or remove - if installer is both, use $url

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
Get-ChocolateyWebFile $packageName "$toolsDir\mpv-install.zip" 'https://github.com/rossy/mpv-install/archive/master.zip'
Get-ChocolateyUnzip "$toolsDir\mpv-install.zip" $toolsDir
Move-Item -Path "$toolsDir\mpv-install-master\*" -Destination $toolsDir
Remove-Item -Path "$toolsDir\mpv-install-master"
# This failed to launch the process as admin, leaving it here until chocolaty is fixed
#Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-install.bat" 'cmd.exe' -validExitCodes $validExitCodes
Start-Process cmd.exe -ArgumentList "/C $toolsDir\mpv-install.bat" -Verb Runas
# Shim doesn't work with mpv as expected, so I'm doing away with it
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.exe $toolsdir\mpv.exe"
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.com $toolsdir\mpv.com"
