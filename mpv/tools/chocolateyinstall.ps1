$ErrorActionPreference = 'Stop';

$packageName = 'mpv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://mpv.srsfckn.biz/mpv-i686-20150923.7z'
$url64 = 'http://mpv.srsfckn.biz/mpv-x86_64-20150923.7z'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
Get-ChocolateyWebFile $packageName "$toolsDir\mpv-install.zip" 'https://github.com/rossy/mpv-install/archive/master.zip'
Get-ChocolateyUnzip "$toolsDir\mpv-install.zip" $toolsDir
Move-Item -Path "$toolsDir\mpv-install-master\*" -Destination $toolsDir
Remove-Item -Path "$toolsDir\mpv-install-master"
# This failed to launch the process as admin, commenting out until chocolaty is fixed
#Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-install.bat" 'cmd.exe' -validExitCodes $validExitCodes
Start-Process cmd.exe -ArgumentList "/C $toolsDir\mpv-install.bat" -Verb Runas
# Shim not necessary for mpv (also mpv.com isn't shimmed), replacing with hardlinks
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.exe $toolsdir\mpv.exe"
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.com $toolsdir\mpv.com"
