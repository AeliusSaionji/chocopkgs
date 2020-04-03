$ErrorActionPreference = 'Stop'
$commProgs = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item -Path "$commProgs\Ripcord.lnk","$userProgs\Ripcord.lnk" -ea 0
Uninstall-BinFile -Name "Ripcord"
