Import-Module au

$releases = "https://github.com/qutebrowser/qutebrowser/releases/latest"

function global:au_SearchReplace {
	@{
		".\tools\VERIFICATION.txt" = @{
			"(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL64)"
			"(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
			"(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+\.\d+\.\d+'
	$version = $Matches[0]
	$url64 = "https://github.com/qutebrowser/qutebrowser/releases/download/v$version/qutebrowser-$version-windows-standalone-amd64.zip"

	return @{ Version = $version; URL64 = $url64 }
}

Update-Package -checksumfor none
