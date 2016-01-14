$commProgs = [environment]::getfolderpath('CommonPrograms')
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item "$commProgs\PixivUtil2.lnk"
Remove-Item "$userProgs\PixivUtil2.lnk"
