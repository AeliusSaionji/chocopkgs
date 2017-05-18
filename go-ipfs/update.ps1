Import-Module au

$releases = "https://github.com/ipfs/go-ipfs/releases"

function global:au_SearchReplace {
        @{
                ".\tools\chocolateyinstall.ps1" = @{
                "(?i)(^\s*[$]checksumType\s*=\s*)('.*')" = "`${1}'$($Latest.ChecksumType32)'"
                "(?i)(^\s*[$]checksum64\s*=\s*)('.*')"   = "`${1}'$($Latest.Checksum64)'"
                "(?i)(^\s*[$]checksum\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum32)'"
                "(?i)(^\s*[$]url64\s*=\s*)('.*')"        = "`${1}'$($Latest.URL64)'"
                "(?i)(^\s*[$]url\s*=\s*)('.*')"          = "`${1}'$($Latest.URL32)'"
                }
        }
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d\.\d\.\d'
	$version = $Matches[0]
	# TODO - check for RC release and append -beta to version?
	$url   = "https://dist.ipfs.io/go-ipfs/v$version/go-ipfs_v${version}_windows-386.zip"
	$url64 = "https://dist.ipfs.io/go-ipfs/v$version/go-ipfs_v${version}_windows-amd64.zip"

	return @{ Version = $version; URL32 = $url; URL64 = $url64 }
}

Update-Package
