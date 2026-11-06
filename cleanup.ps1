if ((Get-Item $PWD | Select-Object -ExpandProperty Name) -eq 'chocopkgs') {
	Get-ChildItem *.zip,*.7z,*.exe,*.nupkg -Recurse | Remove-Item
} else {
	Write-Host 'Run me from the fold chocopkgs'
}