Import-Module au

$releases = 'https://www.nvidia.com/Download/processFind.aspx?psid=95&pfid=694&osid=19&lid=1&whql=&lang=en-us'

function global:au_SearchReplace {
	@{
		".\tools\chocolateyInstall.ps1" = @{
			"(?i)(^\s*url64\s*=\s*)('.*')"                             = "`$1'$($Latest.URL1064)'"
			"(?i)(^\s*checksumType64\s*=\s*)('.*')"                    = "`$1'$($Latest.ChecksumType64)'"
			"(?i)(^\s*checksum64\s*=\s*)('.*')"                        = "`$1'$($Latest.Checksum1064)'"
			"(?i)(^\s*[$]packageArgs\['url64'\]\s*=\s*)('.*')"         = "`$1'$($Latest.URL7864)'"
			"(?i)(^\s*[$]packageArgs\['checksum64'\]\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum7864)'"
			"(?i)(^\s*[$]packageArgsDCHURL\s*=\s*)('.*')"              = "`$1'$($Latest.URLDCH)'"
			"(?i)(^\s*[$]packageArgsDCHChecksum\s*=\s*)('.*')"         = "`$1'$($Latest.ChecksumDCH)'"
		}
		".\geforce-game-ready-driver.nuspec" = @{
		"(?i)(^\s*<releaseNotes>)(.*)" = "`${1}https://us.download.nvidia.com/Windows/$($Latest.Version)/$($Latest.Version)-win10-win8-win7-release-notes.pdf</releaseNotes>"
		}
	}
}

function global:au_BeforeUpdate {
	$Latest.ChecksumType64 = "sha256"
	$Latest.Checksum1064 = Get-RemoteChecksum -Url $Latest.URL1064
	$Latest.Checksum7864 = Get-RemoteChecksum -Url $Latest.URL7864
	$Latest.ChecksumDCH  = Get-RemoteChecksum -Url $Latest.URLDCH
	# export checksums for use with other package
	sc ..\knownChecksums "$Latest.Checksum1064`n$Latest.Checksum7864`n$Latest.ChecksumDCH"
}

function global:au_GetLatest {
	# check for presence of exported checksums from other package
	if (Test-Path ..\knownChecksums) {
		# overwrite function with known checksums
		function global:au_BeforeUpdate {
			$knownChecksums = gc ..\knownChecksums
			$Latest.ChecksumType64 = "sha256"
			$Latest.Checksum1064 = $knownChecksums[0]
			$Latest.Checksum7864 = $knownChecksums[1]
			$Latest.ChecksumDCH  = $knownChecksums[2]
			rm ..\knownChecksums
		}
	}
	$download_page = (iwr $releases -UseBasicParsing).Content.Split("`n") | Select-String "class=""gridItem"">\d+\.\d+</td>" | Select-Object -First 1
	$Matches = $null
	$download_page -match "\d+\.\d+"
	$version = $Matches[0]
	$url1064 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win10-64bit-international-whql.exe"
	$url7864 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql.exe"
	$urlDCH  = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win10-64bit-international-dch-whql.exe"
	# Unfortunately I can't think of a clean way to detect -rp just once. The code below releases a new version every time an update is checked for...
	# if (iwr -Method Head "https://us.download.nvidia.com/Windows/$version/$version-desktop-win10-64bit-international-whql-rp.exe") {
	# 	$url1064 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win10-64bit-international-whql-rp.exe"
	# 	$url7864 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql-rp.exe"
	# 	$version = $Matches[0] + ".0.$(Get-Date -Format yyyyMMdd)"
	# }
	return @{
		Version = $version
		URL1064 = $url1064
		URL7864 = $url7864
		URLDCH  = $urlDCH
	}
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor none
}
