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

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+\.\d+\.\d+'
	$version = $Matches[0]
	$url32 = "https://github.com/qutebrowser/qutebrowser/releases/download/v$version/qutebrowser-$version-win32.exe"
	$url64 = "https://github.com/qutebrowser/qutebrowser/releases/download/v$version/qutebrowser-$version-amd64.exe"

	return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package
}