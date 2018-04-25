Set-Location "$env:USERPROFILE\chocopkgs"
$au_root = "$env:USERPROFILE\chocopkgs"
$Options = [ordered]@{
	Push = $true
}

Update-AUPackages -Options $Options
