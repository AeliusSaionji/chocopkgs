if ((Get-Item $PWD | Select-Object -ExpandProperty Name) -eq 'chocopkgs') {
	gci *.zip,*.7z,*.exe,*.nupkg -Recurse | Remove-Item
} else {
	echo 'Run me from the fold chocopkgs'
}