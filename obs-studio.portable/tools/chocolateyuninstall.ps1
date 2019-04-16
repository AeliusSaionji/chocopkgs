$ErrorActionPreference = 'Stop'
$bitness = Get-OSArchitectureWidth
$commProgs = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item -Path "$commProgs\OBS Studio (${bitness}bit).lnk","$userProgs\OBS Studio (${bitness}bit).lnk" -ea 0
