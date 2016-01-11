$packageName = 'mpv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '2015.12.11'
$version = $version.Replace(".","")
$url = "http://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "http://mpv.srsfckn.biz/mpv-x86_64-$version.7z"

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
# Remove hardlinks before attempting to recreate them
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe" -ErrorAction SilentlyContinue
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com" -ErrorAction SilentlyContinue
# Shim not optimal for mpv (also mpv.com isn't shimmed), replacing with hardlinks
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.exe $toolsdir\mpv.exe"
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.com $toolsdir\mpv.com"
