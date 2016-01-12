Remove-Item -Path "$ENV:ChocolateyInstall\lib\mupen64plus\tools\mupen64plus-qt.exe"
Remove-Item -Path "$ENV:ChocolateyInstall\lib\mupen64plus\tools\README.txt"
$commProgs = [environment]::getfolderpath('CommonPrograms')
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item -Path "$commProgs\Mupen64Plus-Qt.lnk" -ErrorAction SilentlyContinue
Remove-Item -Path "$userProgs\Mupen64Plus-Qt.lnk" -ErrorAction SilentlyContinue
