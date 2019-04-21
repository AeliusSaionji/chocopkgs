$ErrorActionPreference = 'Stop'
$commProgs = Join-Path ([environment]::getfolderpath('CommonApplicationData')) "Microsoft\Windows\Start Menu\Programs"
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item -Path "$commProgs\PicoTorrent.lnk","$userProgs\PicoTorrent.lnk" -ea 0
Uninstall-BinFile -Name "PicoTorrent"
