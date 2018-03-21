Import-Module au

# At the time of running, github is only operating with 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$releases = "https://github.com/mintty/wsltty/releases/latest"

function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
		"(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
		"(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+\.\d+\.\d+'
	$version = $Matches[0]
	$url32 = "https://github.com/mintty/wsltty/releases/download/1.8.4/wsltty-$version-install.exe"
	
	return @{ Version = $version; URL32 = $url32 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package
}