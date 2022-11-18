Import-Module au

$releases = "http://www.resplendence.com/latencymon"

function global:au_SearchReplace {
	@{
		".\tools\chocolateyinstall.ps1" = @{
			"(?i)(^\s*checksum\s*=).*"      = "`${1} `'$($Latest.Checksum32)`'"
			"(?i)(^\s*checksumtype\s*=).*"  = "`${1} `'$($Latest.ChecksumType32)`'"
		}
	}
}
function global:au_BeforeUpdate {
	$Latest.ChecksumType32 = 'SHA256'
	$Latest.CheckSum32 = Get-RemoteChecksum -Url 'http://www.resplendence.com/download/LatencyMon.exe' -Algorithm $Latest.ChecksumType32
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Content -split '\n' | sls 'Latest version: LatencyMon v'
	$Matches = $null
	$download_page -match '\d+\.\d+'
	$version = $Matches[0]

	return @{ Version = $version }
}

Update-Package -checksumFor none
