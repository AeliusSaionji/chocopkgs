Import-Module au

$releases = 'https://api.github.com/repos/picotorrent/picotorrent/releases/latest'
$headers = @{
    'User-Agent' = 'AeliusSaionji'
    'Accept' = 'application/vnd.github.v3+json'
}

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
  $restAPI = Invoke-RestMethod $releases -Headers $headers
  $Matches = $null
  $restAPI.tag_name -match '(\d+\.?)+'
  $version = $Matches[0]
  $url32 = $restAPI.assets | Where-Object { ($_.content_type -eq 'application/x-zip-compressed') `
    -and ($_.name -like '*x86*') -and ($_.name -notlike '*symbols*') } `
    | Select-Object -First 1 -ExpandProperty browser_download_url
  $url64 = $restAPI.assets | Where-Object { ($_.content_type -eq 'application/x-zip-compressed') `
    -and ($_.name -like '*x64*') -and ($_.name -notlike '*symbols*') } `
    | Select-Object -First 1 -ExpandProperty browser_download_url

	return @{ Version = $version; URL32 = $url32; URL64 = $url64; }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -checksumfor none
}
