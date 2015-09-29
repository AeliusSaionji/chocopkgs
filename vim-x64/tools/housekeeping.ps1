# Explorer handle prevents removal, reboot explorer
Remove-Item -Path "$ENV:ProgramFiles\Vim" -Force -Recurse
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim 7.4' -Force -Recurse
Remove-Item -Path 'HKLM:\SOFTWARE\Vim' -Force -Recurse
sleep 50