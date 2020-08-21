Import-Module au

$releases = 'http://www.bandisoft.com/honeyview/history/'

function global:au_SearchReplace {
	@{
		".\tools\VERIFICATION.txt" = @{
			"(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
			"(?i)(^\s*checksum(32)?\:).*"   = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate() {
	#Download $Latest.URL32 / $Latest.URL64 in tools directory and remove any older installers.
	Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$url = 'https://dl.bandisoft.com/honeyview/HONEYVIEW-PORTABLE.ZIP'
	$download_page = (iwr $releases)
  $versionString = $download_page.ParsedHtml.getElementsByTagName("h2") | % InnerText | select -First 1
	$Matches = $null
	$versionString -match "(\d+\.?)+"
	$version = $Matches[0]

	return @{ Version = $version; URL32 = $url }
}

Update-Package -ChecksumFor none
