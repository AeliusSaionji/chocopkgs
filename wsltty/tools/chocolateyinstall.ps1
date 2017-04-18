$packageName = 'wsltty'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$url64 = "https://github.com/mintty/wsltty/releases/download/${version}/wsltty-${version}-install.exe"
$checksum64 = '{{Checksumx64}}'
$checksumType64 = 'SHA512'

Install-ChocolateyZipPackage $packageName -UnzipLocation $toolsdir -Url64bit $url64 `
-Checksum64 $checksum64 -ChecksumType64 $checksumType64 

# Replicate the installer folder structure
New-Item -Path $toolsdir -Name lang -ItemType Directory
Move-Item "$toolsdir\cygwin1.dll"               -Destination "$toolsdir\bin"
Move-Item "$toolsdir\cygwin-console-helper.exe" -Destination "$toolsdir\bin"
Move-Item "$toolsdir\mintty.exe"                -Destination "$toolsdir\bin"
Move-Item "$toolsdir\wslbridge.exe"             -Destination "$toolsdir\bin"
Move-Item "$toolsdir\wslbridge-backend"         -Destination "$toolsdir\bin"
Move-Item "$toolsdir\zoo.exe"                   -Destination "$toolsdir\bin"
Move-Item "$toolsdir\po.zoo"                    -Destination "$toolsdir\lang"

# Extract language files
Start-Process -FilePath "$toolsdir\bin\zoo.exe" -ArgumentList "x po" -WorkingDirectory "$toolsdir\lang"

# Alter batch files to refer to chocolatey install location
(Get-Content "$toolsdir\wsl.bat")   | ForEach-Object {$_ -replace "\%LOCALAPPDATA\%\\wsltty", "%ChocolateyInstall%\lib\wsltty\tools"} | Set-Content "$toolsdir\wsl.bat"
(Get-Content "$toolsdir\wsl~.bat")  | ForEach-Object {$_ -replace "\%LOCALAPPDATA\%\\wsltty", "%ChocolateyInstall%\lib\wsltty\tools"} | Set-Content "$toolsdir\wsl~.bat"
(Get-Content "$toolsdir\wsl-l.bat") | ForEach-Object {$_ -replace "\%LOCALAPPDATA\%\\wsltty", "%ChocolateyInstall%\lib\wsltty\tools"} | Set-Content "$toolsdir\wsl-l.bat"

# Alter batch files to point at a valid config location
(Get-Content "$toolsdir\wsl.bat")   | ForEach-Object {$_ -replace "--wsl", "--wsl --config ""%LOCALAPPDATA%\wsltty\config"""} | Set-Content "$toolsdir\wsl.bat"
(Get-Content "$toolsdir\wsl~.bat")  | ForEach-Object {$_ -replace "--wsl", "--wsl --config ""%LOCALAPPDATA%\wsltty\config"""} | Set-Content "$toolsdir\wsl~.bat"
(Get-Content "$toolsdir\wsl-l.bat") | ForEach-Object {$_ -replace "--wsl", "--wsl --config ""%LOCALAPPDATA%\wsltty\config"""} | Set-Content "$toolsdir\wsl-l.bat"

# Prepend the creation of the config dir and the junction of the language files into the batch files
$dirs = Get-Content "$toolsdir\create-dirs.bat"

$wsl  = $dirs + (Get-Content "$toolsdir\wsl.bat")
Set-Content -Path "$toolsdir\wsl.bat" -Value $wsl

$wsl2 = $dirs + (Get-Content "$toolsdir\wsl~.bat")
Set-Content -Path "$toolsdir\wsl~.bat" -Value $wsl2

$wsl3 = $dirs + (Get-Content "$toolsdir\wsl-l.bat")
Set-Content -Path "$toolsdir\wsl-l.bat" -Value $wsl3

# Shim batch files
Install-BinFile -Name 'wsl'   -UseStart -Path "$toolsdir\wsl.bat"
Install-BinFile -Name 'wsl~'  -UseStart -Path "$toolsdir\wsl~.bat"
Install-BinFile -Name 'wsl-l' -UseStart -Path "$toolsdir\wsl-l.bat"
