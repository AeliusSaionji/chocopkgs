Import-Module au

$releases = "https://github.com/mintty/wsltty/releases/latest"

function global:au_SearchReplace {
	@{
		".\tools\VERIFICATION.txt" = @{
		"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
		"(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL64)"
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
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/' | Select-Object -First 1
	$Matches = $null
	$download_page -match '(\d+\.?)+'
	$version = $Matches[0]
	$url32 = "https://github.com/mintty/wsltty/releases/download/$version/wsltty-$version-install-i686.exe"
	$url64 = "https://github.com/mintty/wsltty/releases/download/$version/wsltty-$version-install-x86_64.exe"
	
	return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -NoCheckURL -ChecksumFor none
}
