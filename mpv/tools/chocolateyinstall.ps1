$ErrorActionPreference = 'Stop';

$packageName = 'mpv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$url = "http://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "http://mpv.srsfckn.biz/mpv-x86_64-$version.7z"

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
# Remove hardlinks before attempting to recreate them
If (Test-Path -Path "$ENV:ChocolateyInstall\bin\mpv.exe") {
	Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe"
}
If (Test-Path -Path "$ENV:ChocolateyInstall\bin\mpv.com") {
	Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com"
}
# Shim not necessary for mpv (also mpv.com isn't shimmed), replacing with hardlinks
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.exe $toolsdir\mpv.exe"
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\mpv.com $toolsdir\mpv.com"

$installbat = Read-Host 'Do you wish to register mpv as a video player with the system? (yes/no)'
If ($installbat -eq 'yes') {
	Get-ChocolateyWebFile $packageName "$toolsDir\mpv-install.zip" 'https://cdn.rawgit.com/rossy/mpv-install/archive/master.zip'
	Get-ChocolateyUnzip "$toolsDir\mpv-install.zip" $toolsDir
	Move-Item -Path "$toolsDir\mpv-install-master\*" -Destination $toolsDir -Force
	Remove-Item -Path "$toolsDir\mpv-install-master"
	# This failed to launch the process as admin, commenting out until further notice
	#Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-install.bat" 'cmd.exe' -validExitCodes $validExitCodes
	Start-Process cmd.exe -ArgumentList "/C $toolsDir\mpv-install.bat" -Verb Runas
}
