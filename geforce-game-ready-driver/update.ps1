﻿Import-Module au

$releases = 'https://www.nvidia.com/Download/processFind.aspx?psid=95&pfid=694&osid=19&lid=1&whql=&lang=en-us'

function global:au_SearchReplace {
	@{
		".\tools\chocolateyInstall.ps1" = @{
			"(?i)(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL1032)'"
			"(?i)(^[$]url64\s*=\s*)('.*')"    = "`$1'$($Latest.URL1064)'"
			"(?i)(^\s+[$]url\s*=\s*)('.*')"   = "`$1'$($Latest.URL7832)'"
			"(?i)(^\s+[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL7864)'"
			"(?i)(^[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
			"(?i)(^[$]checksum\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum1032)'"
			"(?i)(^[$]checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum1064)'"
			"(?i)(^\s+[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum7832)'"
			"(?i)(^\s+[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum7864)'"
		}
		".\geforce-game-ready-driver.nuspec" = @{
		"(?i)(^\s*<releaseNotes>)(.*)" = "`${1}http://us.download.nvidia.com/Windows/$($Latest.Version)/$($Latest.Version)-win10-win8-win7-desktop-release-notes.pdf</releaseNotes>"
		}

		"..\nvidia-display-driver\tools\chocolateyInstall.ps1" = @{
			"(?i)(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL1032)'"
			"(?i)(^[$]url64\s*=\s*)('.*')"    = "`$1'$($Latest.URL1064)'"
			"(?i)(^\s+[$]url\s*=\s*)('.*')"   = "`$1'$($Latest.URL7832)'"
			"(?i)(^\s+[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL7864)'"
			"(?i)(^[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
			"(?i)(^[$]checksum\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum1032)'"
			"(?i)(^[$]checksum64\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum1064)'"
			"(?i)(^\s+[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum7832)'"
			"(?i)(^\s+[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum7864)'"
		}
	}
}

function global:au_BeforeUpdate {
	$Latest.ChecksumType32 = "sha256"
	$Latest.Checksum1032 = Get-RemoteChecksum -Url $Latest.URL1032
	$Latest.Checksum1064 = Get-RemoteChecksum -Url $Latest.URL1064
	$Latest.Checksum7832 = Get-RemoteChecksum -Url $Latest.URL7832
	$Latest.Checksum7864 = Get-RemoteChecksum -Url $Latest.URL7864
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Content.Split("`n") | Select-String "class=""gridItem"">\d+\.\d+</td>" | Select-Object -First 1
	$Matches = $null
	$download_page -match "\d+\.\d+"
	$version = $Matches[0]
	$url1032 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win10-32bit-international-whql.exe"
	$url1064 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win10-64bit-international-whql.exe"
	$url7832 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-32bit-international-whql.exe"
	$url7864 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql.exe"

	return @{
		Version = $version
		URL1032 = $url1032
		URL1064 = $url1064
		URL7832 = $url7832
		URL7864 = $url7864
	}
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor none
}