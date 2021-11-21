$commProgs = [environment]::getfolderpath('CommonPrograms')
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item -Path "$commProgs\PixivUtil2.lnk","$userProgs\PixivUtil2.lnk" -ea 0
Uninstall-BinFile -Name "PixivUtil2"
