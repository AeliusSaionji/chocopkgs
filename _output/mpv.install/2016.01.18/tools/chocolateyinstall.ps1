$packageName = 'mpv.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '2016.01.18'
$version = $version.Replace(".","")
$url = "http://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "http://mpv.srsfckn.biz/mpv-x86_64-$version.7z"
$urlAssoc = 'https://github.com/rossy/mpv-install/archive/master.zip'

# Remove hardlinks created by previous versions of this package
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe" -ErrorAction SilentlyContinue
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com" -ErrorAction SilentlyContinue

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
Install-ChocolateyZipPackage "associations" $urlAssoc $toolsDir
Move-Item "$toolsDir\mpv-install-master\*" $toolsDir -Force
Remove-Item "$toolsDir\mpv-install-master"
Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-install.bat /u" 'cmd.exe' -validExitCodes '0'

# mpv can't be shimmed, the shim doesn't work with mpv.com
# as of 2016.01.18, there is a dll dependency, so mpv can't be hardlinked to chocolatey\bin
# adding to PATH until chocolatey implements a /usr/lib equivalent
$pathToInstall = "$ENV:ChocolateyInstall\lib\$packageName\tools"
$pathType = 'User'
if ( ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator") ) {
	$pathType = 'Machine'
}
Install-ChocolateyPath $pathToInstall $pathType
