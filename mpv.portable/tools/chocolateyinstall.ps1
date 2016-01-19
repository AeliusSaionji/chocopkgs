$packageName = 'mpv.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$url = "http://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "http://mpv.srsfckn.biz/mpv-x86_64-$version.7z"

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
# Remove hardlinks created by previous versions of this package
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe" -ErrorAction SilentlyContinue
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com" -ErrorAction SilentlyContinue

# mpv can't be shimmed, the shim doesn't work with mpv.com
# as of 2016.01.18, there is a dll dependency, so mpv can't be hardlinked to chocolatey\bin
# adding to PATH until chocolatey implements a /usr/lib equivalent
$pathType = 'User'
if ( ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator") ) {
	$pathType = 'Machine'
}
Install-ChocolateyPath $toolsDir $pathType -ErrorAction SilentlyContinue
