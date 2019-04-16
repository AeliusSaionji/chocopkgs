$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation   = Get-Item $toolsDir\*_x32.zip
$file64Location = Get-Item $toolsDir\*_x64.zip
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
  file             = $fileLocation
  file64           = $file64Location
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
