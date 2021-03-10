Import-Module au

$releases = 'https://remote-config.gog.com/components/webinstaller?component_version=2.0.0'

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
	$download_page = iwr $releases -UseBasicParsing | ConvertFrom-Json
	$version  = $download_page.content.windows.version
	$url32    = $download_page.content.windows.downloadLink
	$md5      = $download_page.content.windows.installerMd5

	return @{ Version = $version; URL32 = $url32; Checksum32 = $md5; ChecksumType32 = 'md5' }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -checksumfor none
}
