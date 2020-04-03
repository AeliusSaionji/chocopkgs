$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Hotfix true or false
#$hotfix = 1
# dev would ideally prefer unupdated users not get the update, and 
# users who have the update are the only ones to get the hotfix
#If ( $hotfix ) { exit }

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

$packageArgs = @{
	packageName      = 'ripcord'
	file64           = gi $toolsDir\*_x64.zip
	destination      = "$toolsDir"
	ShortcutFilePath = "$ProgsFolder\Ripcord.lnk"
	TargetPath       = "$toolsDir\Ripcord.exe"
}

Get-ChocolateyUnzip @packageArgs
Install-ChocolateyShortcut @packageArgs
Install-BinFile -Name "Ripcord" -Path "$destination\Ripcord.exe" -UseStart
Remove-Item $packageArgs.file64 -Force -ea 0
