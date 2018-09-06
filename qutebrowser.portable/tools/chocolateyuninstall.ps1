$ErrorActionPreference = 'Stop'
$commProgs = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item -Path "$commProgs\Advanced Renamer.lnk","$userProgs\Advanced Renamer.lnk" -ea 0
