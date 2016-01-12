$packageName = 'lua51'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://sourceforge.net/projects/luabinaries/files/5.1.5/Tools%20Executables/lua-5.1.5_Win32_bin.zip/download'
$url64      = 'http://sourceforge.net/projects/luabinaries/files/5.1.5/Tools%20Executables/lua-5.1.5_Win64_bin.zip/download'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64

# Remove hardlink before attempting to recreate it
Remove-Item -Path "$ENV:ChocolateyInstall\bin\lua51.dll" -ErrorAction SilentlyContinue
# Get the dll on PATH
Start-Process cmd.exe -ArgumentList "/C MKLINK /H $ENV:ChocolateyInstall\bin\lua51.dll $toolsDir\lua51.dll"
