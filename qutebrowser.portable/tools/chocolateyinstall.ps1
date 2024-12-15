$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

# Remove old versions
Get-ChildItem -Directory $toolsDir\qutebrowser* | Remove-Item -Force -ea 0

$packageArgs = @{
  packageName = 'qutebrowser.portable'
  file64      = "$toolsdir\qutebrowser-3.4.0-windows-standalone_x64.zip"
  destination = "$toolsDir"
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $packageArgs.file64 -Force -ea 0
