Import-Module au

$releases = "https://github.com/Nandaka/PixivUtil2/releases/latest"

function global:au_SearchReplace {
        @{
                ".\tools\chocolateyinstall.ps1" = @{
                "(?i)(^\s*[$]checksumType\s*=\s*)('.*')" = "`${1}'$($Latest.ChecksumType32)'"
                "(?i)(^\s*[$]checksum\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum32)'"
                "(?i)(^\s*[$]url\s*=\s*)('.*')"          = "`${1}'$($Latest.URL32)'"
                }
        }
}

function global:au_BeforeUpdate {
	$Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.URL32
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d\d\d\d\d\d\d\d'
	$urlvers = $Matches[0]
	$version = [datetime]::ParseExact($Matches[0],'yyyyMMdd',$null) | Get-Date -Format yyyy.MM.dd
	$url32 = "https://github.com/Nandaka/PixivUtil2/releases/download/v$urlvers/pixivutil$urlvers.7z"

	return @{ Version = $version; URL32 = $url32 }
}

Update-Package -ChecksumFor none