Import-Module au

$releases = 'https://www.hwinfo.com/ver.txt'

function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
        "(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL32)"
		"(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
		"(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
		"(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
    $Latest.ChecksumType32 = 'SHA256'
    Remove-Item -Force -ea 0 tools\hwi.zip
	$Headers = @{ Referer = 'https://www.hwinfo.com/download.php'; }
	iwr $Latest.URL32 -OutFile tools\hwi.zip -Headers $Headers
	$Latest.Checksum32 = (Get-FileHash tools\hwi.zip -Algorithm $Latest.ChecksumType32).Hash
}

function global:au_GetLatest {
	$Matches = $null
	(iwr $releases -UseBasicParsing).Content -match '\d+\.\d+'
	$version = $Matches[0]
	$urlvers = $version.Replace(".","")
	$url32   = "https://www.hwinfo.com/files/hwi_$urlvers.zip"
	
	return @{ Version = $version; URL32 = $url32 }
}

Update-Package -NoCheckUrl -ChecksumFor none
