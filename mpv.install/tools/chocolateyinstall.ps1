$packageName = 'mpv.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$url = "http://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "http://mpv.srsfckn.biz/mpv-x86_64-$version.7z"

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
# Remove hardlinks before attempting to recreate them
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe" -ErrorAction SilentlyContinue
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com" -ErrorAction SilentlyContinue
# Shim not optimal for mpv (also mpv.com isn't shimmed), replacing with hardlinks
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.exe $toolsDir\mpv.exe"
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.com $toolsDir\mpv.com"

# Until my PR is accepted...
Get-ChocolateyWebFile $packageName "$ENV:Temp\chocolatey\$packageName\mpv-install.zip" 'https://github.com/rossy/mpv-install/archive/master.zip'
Get-ChocolateyUnzip "$ENV:Temp\chocolatey\$packageName\mpv-install.zip" "$ENV:Temp\chocolatey\$packageName"
Copy-Item -Path "$ENV:Temp\chocolatey\$packageName\mpv-install-master\*" -Destination $toolsDir -Force
Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-install.bat /u" 'cmd.exe' -validExitCodes '0'
