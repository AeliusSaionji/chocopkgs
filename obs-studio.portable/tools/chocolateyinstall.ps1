$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://github.com/obsproject/obs-studio/releases/download/27.2.4/OBS-Studio-27.2.4-Full-x86.zip'
$url64      = 'https://github.com/obsproject/obs-studio/releases/download/27.2.4/OBS-Studio-27.2.4-Full-x64.zip'
$checksum32 = '51bacea13391874f2902575d2d8ab6e6eb6bd7c90682c7461e7cde15dec99c22'
$checksum64 = 'fae9840096c43a62b410d91985b4b5fdd5b0d6e8d54ef4afe7af47180da8ae21'

$destination = Join-Path "$toolsDir" 'obs-studio'

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}
$bitness = Get-OSArchitectureWidth

$packageArgs = @{
  packageName      = $env:ChocolateyPackageName
  unzipLocation    = $destination
  url           = $url32
  url64bit      = $url64
  checksum      = $checksum32
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  shortcutFilePath = "$ProgsFolder\OBS Studio (${bitness}bit).lnk"
  targetPath       = "$destination\bin\${bitness}bit\obs${bitness}.exe"
  WorkingDirectory = "$destination\bin\${bitness}bit\"
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut @packageArgs
Remove-Item $packageArgs.file   -Force -ea 0
Remove-Item $packageArgs.file64 -Force -ea 0

# shims don't seem to work with obs
$files = Get-Childitem $destination -include *.exe -recurse
foreach ($file in $files) {
  #generate an ignore file
  New-Item "$file.ignore" -type file -force | Out-Null
}

# See https://github.com/obsproject/obs-studio/wiki/Install-Instructions#windows
icacls $destination /grant 'ALL APPLICATION PACKAGES:F' /t /c /q
