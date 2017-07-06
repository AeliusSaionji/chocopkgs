Import-Module au

$releases = "https://github.com/qutebrowser/qutebrowser/releases/latest"

function global:au_SearchReplace {
        @{
                ".\tools\chocolateyinstall.ps1" = @{
                "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"   = "`${1}'$($Latest.ChecksumType)'"
                "(?i)(^\s*[$]checksum\s*=\s*)('.*')"       = "`${1}'$($Latest.Checksum32)'"
                "(?i)(^\s*[$]checksum64\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum64)'"
                "(?i)(^\s*[$]url\s*=\s*)('.*')"            = "`${1}'$($Latest.URL32)'"
                "(?i)(^\s*[$]url64\s*=\s*)('.*')"          = "`${1}'$($Latest.URL64)'"
                }
        }
}



function global:au_BeforeUpdate {
	$Latest.ChecksumType = 'sha256'
	$Latest.Checksum32 = Get-RemoteChecksum -Url $Latest.URL32 -Algorithm $Latest.ChecksumType
	$Latest.Checksum64 = Get-RemoteChecksum -Url $Latest.URL64 -Algorithm $Latest.ChecksumType
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+\.\d+\.\d+'
	$version = $Matches[0]
	$url32 = "https://github.com/qutebrowser/qutebrowser/releases/download/v$version/qutebrowser-$version-windows-standalone-win32.zip"
	$url64 = "https://github.com/qutebrowser/qutebrowser/releases/download/v$version/qutebrowser-$version-windows-standalone-amd64.zip"

	return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

Update-Package -ChecksumFor none
