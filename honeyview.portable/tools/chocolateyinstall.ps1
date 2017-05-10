$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\HONEYVIEW-PORTABLE_x32.ZIP"

# Place shortcuts in appropriate location
$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) {
  $ProgsFolder = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
}

$packageArgs = @{
	packageName      = 'honeyview.portable'
	file             = "$filePath"
	destination      = "$toolsDir"
        shortcutFilePath = "$ProgsFolder\Honeyview.lnk"
        targetPath       = "$toolsDir\Honeyview32.exe"
}

Get-ChocolateyUnzip @packageArgs
Install-ChocolateyShortcut @packageArgs

Remove-Item -Force -ea 0 $filePath
