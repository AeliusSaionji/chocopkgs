$packageName = 'mpv.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$url = "https://mpv.srsfckn.biz/mpv-i686-$version.7z"
$url64 = "https://mpv.srsfckn.biz/mpv-x86_64-$version.7z"

# Use BITS until https://github.com/chocolatey/choco/pull/459
# Find bitness for download
$FileFullPath = "$ENV:TEMP\chocolatey\mpv.portable\mpv-i686-$version.7z"
if $(Get-ProcessorBits) = '64' {
	$url = $url64
	$FileFullPath = "$ENV:TEMP\chocolatey\mpv.portable\mpv-x86_64-$version.7z"
}
Start-BitsTransfer -Source $url -Destination "$ENV:TEMP\chocolatey\mpv.portable\"
#Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
Get-ChocolateyUnzip -FileFullPath $FileFullPath -Destination $toolsDir -PackageName $packageName

# mpv can't be shimmed, the shim doesn't work with mpv.com
# as of 2016.01.18, there is a dll dependency, so mpv can't be hardlinked to chocolatey\bin
# adding to PATH until chocolatey implements a /usr/lib equivalent
$pathType = 'User'
if ( ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator") ) {
	$pathType = 'Machine'
}
Install-ChocolateyPath $toolsDir $pathType -ErrorAction SilentlyContinue
