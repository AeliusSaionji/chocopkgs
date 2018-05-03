Import-Module au

$releases = "https://dist.ipfs.io/#go-ipfs"

function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt" = @{
			"(?i)(\s+x32:).*"               = "`${1} $($Latest.URL32)"
			"(?i)(\s+x64:).*"               = "`${1} $($Latest.URL64)"
			"(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
			"(?i)(^\s*checksum32\:).*"      = "`${1} $($Latest.Checksum32)"
			"(?i)(^\s*checksum64\:).*"      = "`${1} $($Latest.Checksum64)"
		}
		".\go-ipfs.nuspec" = @{
			"(?i)(^\s*<releaseNotes>)(.*)" = "`${1}https://github.com/ipfs/go-ipfs/blob/v$($Latest.Version)/CHANGELOG.md</releaseNotes>"
		}
	}
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Content -split '\n' | sls 'data-id="go-ipfs" data-version="'
	$Matches = $null
	$download_page -match '\d+\.\d+\.\d+'
	$version = $Matches[0]
	$url32 = "https://dist.ipfs.io/go-ipfs/v$version/go-ipfs_v${version}_windows-386.zip"
	$url64 = "https://dist.ipfs.io/go-ipfs/v$version/go-ipfs_v${version}_windows-amd64.zip"

	return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

Update-Package -ChecksumFor none
