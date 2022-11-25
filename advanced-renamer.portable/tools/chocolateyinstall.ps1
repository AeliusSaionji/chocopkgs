$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath   = "$toolsDir\advanced_renamer_portable_x86_3_88_1.zip"
$filePath64 = "$toolsDir\advanced_renamer_portable_3_88_1.zip"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

$packageArgs = @{
	packageName      = 'advanced-renamer.portable'
	file             = "$filePath"
	file64           = "$filePath64"
	destination      = "$toolsDir"
	shortcutFilePath = "$ProgsFolder\Advanced Renamer.lnk"
	targetPath       = "$toolsDir\ARen.exe"
}


Get-ChocolateyUnzip @packageArgs
Install-ChocolateyShortcut @packageArgs

Remove-Item $filePath,$filePath64 -Force -ea 0
