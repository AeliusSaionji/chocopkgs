$destination = "$env:ProgramFiles\Sunshine"
Start-Process -FilePath "$destination\uninstall-service.bat" -NoNewWindow
