Import-Module au

$releases = 'https://www.nvidia.com/en-us/geforce/geforce-experience/'

function global:au_SearchReplace {
	@{
		".\tools\chocolateyinstall.ps1" = @{
			"(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`${1}'$($Latest.ChecksumType32)'"
			"(?i)(^\s*checksum\s*=\s*)('.*')"       = "`${1}'$($Latest.Checksum32)'"
			"(?i)(^\s*url\s*=\s*)('.*')"            = "`${1}'$($Latest.URL32)'"
		}
	}
}

function global:au_BeforeUpdate {}
function global:au_GetLatest {
	$url32 = (iwr $releases -UseBasicParsing).Links.href | Select-String '.exe$'
	$Matches = $null
	$url32 -match '(\d+\.*)+'
	$version = $Matches[0]

	return @{ Version = $version; URL32 = $url32 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package
}
