$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

$packageArgs = @{
	packageName      = 'advanced-renamer.portable'
	file64           = Get-Item "$toolsDir\*x64.zip"
	destination      = "$toolsDir"
	shortcutFilePath = "$ProgsFolder\Advanced Renamer.lnk"
	targetPath       = "$toolsDir\ARen.exe"
}

Get-ChocolateyUnzip @packageArgs
Install-ChocolateyShortcut @packageArgs

Remove-Item $packageArgs.file64 -Force -ea 0
