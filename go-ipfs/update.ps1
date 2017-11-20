Import-Module au

$releases = "https://github.com/ipfs/go-ipfs/releases"

function global:au_SearchReplace {
        @{
				".\tools\chocolateyinstall.ps1" = @{
				"(?i)(^\s*[$]checksumType64\s*=\s*)('.*')" = "`${1}'$($Latest.ChecksumType64)'"
				"(?i)(^\s*[$]checksum64\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum64)'"
				"(?i)(^\s*[$]url64\s*=\s*)('.*')"          = "`${1}'$($Latest.URL64)'"
				}
				".\go-ipfs.nuspec" = @{
					"(?i)(^\s*<releaseNotes>)(.*)" = "`${1}https://github.com/ipfs/go-ipfs/blob/v$($Latest.Version)/CHANGELOG.md</releaseNotes>"
				}
	}
}


function global:au_BeforeUpdate {
	$Latest.ChecksumType64 = 'sha256'
	$Latest.Checksum64 = Get-RemoteChecksum -Url $Latest.URL64 -Algorithm $Latest.ChecksumType64
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+\.\d+\.\d+'
	$version = $Matches[0]
	#$url   = "https://dist.ipfs.io/go-ipfs/v$version/go-ipfs_v${version}_windows-386.zip"
	$url64 = "https://dist.ipfs.io/go-ipfs/v$version/go-ipfs_v${version}_windows-amd64.zip"

	return @{ Version = $version; URL64 = $url64 }
}

Update-Package -ChecksumFor none