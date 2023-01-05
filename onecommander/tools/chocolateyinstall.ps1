$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file64Location = Get-Item "$toolsDir\*_x64.zip"
$destination = "$(Get-ToolsLocation)\One Commander"
$chocoVers = '3.29.2.1'

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

If ((Get-Process OneCommander -ea 0).Path -like "$destination\OneCommander.exe") {
  Write-Host "OneCommander is running, please exit and run the update again" #More visibility
  Write-Error "OneCommander is running, please exit and run the update again" -ErrorAction Stop
}

$localVers = (Get-Item "$destination\OneCommander.exe" -ea 0).VersionInfo.FileVersion
If ($chocoVers -gt $localVers) {#No-op if self updater got here first
  Install-ChocolateyZipPackage @packageArgs
  Install-ChocolateyShortcut @packageArgs
  Install-BinFile -Name "onecommander" -Path "$destination\OneCommander.exe" -UseStart
} Else {
  Write-Host 'The same version or newer is already installed, perhaps by the self updater. No-Op.'
}

Remove-Item $packageArgs.file64 -Force -ea 0
