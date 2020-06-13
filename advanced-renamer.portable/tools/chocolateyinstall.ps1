$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\advanced_renamer_portable_x32.zip"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

$packageArgs = @{
	packageName      = 'advanced-renamer.portable'
	file             = "$filePath"
	destination      = "$toolsDir"
	shortcutFilePath = "$ProgsFolder\Advanced Renamer.lnk"
	targetPath       = "$toolsDir\ARen.exe"
}


Get-ChocolateyUnzip @packageArgs
Install-ChocolateyShortcut @packageArgs

Remove-Item -Force -ea 0 $filePath
