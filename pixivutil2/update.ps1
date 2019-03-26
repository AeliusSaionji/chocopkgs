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

function global:au_BeforeUpdate {}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v?' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+$'
	$version = [datetime]::ParseExact($Matches[0],'yyyyMMdd',$null) | Get-Date -Format yyyy.MM.dd
	$url_segment = (iwr $releases -UseBasicParsing).Links.href | Select-String '.zip' | Select-Object -First 1
	$url32 = "https://github.com" + "$url_segment"

	return @{ Version = $version; URL32 = $url32 }
}

Update-Package
