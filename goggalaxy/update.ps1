Import-Module au

$releases = 'https://www.gog.com/galaxy'

function global:au_SearchReplace {
	@{
		".\tools\chocolateyInstall.ps1" = @{
			"(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
			"(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_BeforeUpdate() {}

function global:au_GetLatest {
	$url32 = (iwr $releases -UseBasicParsing).Links.href | Where-Object {$_ -like '*exe'} | Select-Object -First 1
	$url32 -match '\d+\.\d+\.\d+\.\d+'
	$version = $Matches[0]

	return @{ Version = $version; URL32 = $url32 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package
}
