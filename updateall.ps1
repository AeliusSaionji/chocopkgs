Set-Location 'H:\GitHub\chocopkgs'
$au_root = 'H:\GitHub\chocopkgs'
$Options = [ordered]@{
	Push = $true
}

Update-AUPackages -Options $Options
