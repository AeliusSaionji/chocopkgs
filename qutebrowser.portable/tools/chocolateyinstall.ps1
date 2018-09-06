$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

$packageArgs = @{
	packageName = 'qutebrowser.portable'
	file64           = gi $toolsDir\*_x64.zip
  destination      = "$toolsDir"
  shortcutFilePath = "$ProgsFolder\qutebrowser.lnk"
	targetPath       = "$toolsDir\qutebrowser.exe"
}

Get-ChocolateyUnzip @packageArgs
Install-ChocolateyShortcut @packageArgs
