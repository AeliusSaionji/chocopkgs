Stop-Process -Name ditto  -ErrorAction SilentlyContinue
if (Test-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Ditto_is1) {
	cmd /c (Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Ditto_is1).QuietUninstallstring
}
elseif (Test-Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Ditto_is1) {
	cmd /c (Get-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Ditto_is1).QuietUninstallstring
}
else {
    Write-Error "Cannot find uninstall script"
}
