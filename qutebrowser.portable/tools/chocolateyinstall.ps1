$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

# Remove old versions
Get-ChildItem -Directory $toolsDir\qutebrowser* | Remove-Item -Force -ea 0

# Find exe for shortcut
$shortcutEXE = Get-ChildItem -Directory $toolsDir\qutebrowser* | Get-ChildItem -Filter 'qutebrowser.exe'

$packageArgs = @{
	packageName      = 'qutebrowser.portable'
	file64           = gi $toolsDir\*_x64.zip
	destination      = "$toolsDir"
	shortcutFilePath = "$ProgsFolder\qutebrowser.lnk"
	targetPath       = "$shortcutEXE"
}

Get-ChocolateyUnzip @packageArgs
Install-ChocolateyShortcut @packageArgs
Remove-Item $packageArgs.file64 -Force -ea 0
