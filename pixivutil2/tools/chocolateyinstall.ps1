$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation   = Get-Item $toolsDir\*_x32.zip
# $file64Location = Get-Item $toolsDir\*_x64.zip
$destination = "$(Get-ToolsLocation)\PixivUtil2"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $destination
  file          = $fileLocation
  # file64        = $file64Location
  shortcutFilePath = "$ProgsFolder\PixivUtil2.lnk"
  targetPath       = "$destination\PixivUtil2.exe"
  WorkingDirectory = "$destination\"
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut @packageArgs
Install-BinFile -Name "PixivUtil2" -Path "$destination\PixivUtil2.exe" -UseStart
Remove-Item $packageArgs.file   -Force -ea 0
# Remove-Item $packageArgs.file64 -Force -ea 0
