$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file64Location = Get-Item "$toolsDir\*_x64.zip"
$destination = "$(Get-ToolsLocation)\One Commander"
$chocoVers = '' # refreshed by update.ps1

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) `
  'Microsoft\Windows\Start Menu\Programs'
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $destination
  file64        = $file64Location
  shortcutFilePath = "$ProgsFolder\One Commander.lnk"
  targetPath       = "$destination\OneCommander.exe"
  WorkingDirectory = "$destination\"
}

If (Get-Process OneCommander) {
  Write-Error "OneCommander is running, please exit and run the update again" -ErrorAction Stop
}

$localVers = (Get-Item "$destination\OneCommander.exe").VersionInfo.FileVersion
If ($chocoVers -ne $localVers) {#No-op if self updater got here first
  Install-ChocolateyZipPackage @packageArgs
  Install-ChocolateyShortcut @packageArgs
  Install-BinFile -Name "onecommander" -Path "$destination\OneCommander.exe" -UseStart
}
Remove-Item $packageArgs.file64 -Force -ea 0
