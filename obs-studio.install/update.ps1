Import-Module au

$releases = 'https://github.com/obsproject/obs-studio/releases/latest'

function global:au_SearchReplace {
	@{
		".\tools\VERIFICATION.txt" = @{
			"(?i)(^\s*x32:).*"                  = "`${1} $($Latest.URL32)"
			"(?i)(^\s*x64:).*"                  = "`${1} $($Latest.URL64)"
			"(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
			"(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
			"(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
		}
	}
}
function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$cache_page = (iwr $releases -UseBasicParsing).Links.href
	$download_page = $cache_page | Select-String '/tag/' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+\.\d+\.\d+'
	$version = $Matches[0]
	# Filenames omit ending '0' in version string; just scrape again.
	$url32 = 'https://github.com' + ($cache_page | Select-String 'x86.exe$' | Select-Object -First 1 )
	$url64 = 'https://github.com' + ($cache_page | Select-String 'x64.exe$' | Select-Object -First 1 )

	return @{ Version = $version; URL32 = $url32; URL64 = $url64; }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -checksumfor none
}
