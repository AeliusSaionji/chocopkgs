Import-Module au

$releases = 'https://github.com/plexinc/plex-media-player/releases/latest'

function global:au_SearchReplace {
	@{
		".\tools\chocolateyinstall.ps1" = @{
			"(?i)(^\s*url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
			"(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
			"(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_BeforeUpdate() {}

function global:au_GetLatest {
	$cache_page = (iwr $releases -UseBasicParsing).Links.href
	$download_page = $cache_page | Select-String '/tag/' | Select-Object -First 1
	$Matches = $null
	$download_page -match '(\d+\.){2}\d+'
	$version = $Matches[0]
	$url_version = $download_page -split 'releases/tag/v' | select -Last 1
	$url64 = "https://downloads.plex.tv/plexmediaplayer/$url_version/PlexMediaPlayer-$url_version-windows-x64.exe"

	return @{ Version = $version; URL64 = $url64; }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor 64 -NoReadme
}
