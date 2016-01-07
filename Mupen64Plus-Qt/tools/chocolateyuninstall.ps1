Remove-Item -Path "$ENV:ChocolateyInstall\lib\mupen64plus\tools\mupen64plus-qt.exe"
Remove-Item -Path "$ENV:ChocolateyInstall\lib\mupen64plus\tools\README.txt"
Remove-Item -Path "$ENV:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Mupen64Plus-Qt.lnk" -ErrorAction SilentlyContinue
Remove-Item -Path "$ENV:APPDATA\Microsoft\Windows\Start Menu\Programs\Mupen64Plus-Qt.lnk" -ErrorAction SilentlyContinue
