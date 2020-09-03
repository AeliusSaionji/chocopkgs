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
	$download_page = iwr $releases -UseBasicParsing
	$pkgVer = ($download_page).Links.href | Where-Object {$_ -like '*.pkg'} | Select-Object -First 1
	$pkgVer -match '\d+(\.\d+)+'
	$version = $Matches[0]
	$url32 = 'https://webinstallers.gog.com/download/GOG_Galaxy_2.0.exe'

	return @{ Version = $version; URL32 = $url32 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package
}
