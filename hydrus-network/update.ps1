Import-Module au

$releases = "https://github.com/hydrusnetwork/hydrus/releases/latest"

function global:au_SearchReplace {
        @{
                ".\tools\chocolateyinstall.ps1" = @{
                "(?i)(^\s*[$]checksumType64\s*=\s*)('.*')" = "`${1}'$($Latest.ChecksumType64)'"
                "(?i)(^\s*[$]checksum64\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum64)'"
                "(?i)(^\s*[$]url64\s*=\s*)('.*')"          = "`${1}'$($Latest.URL64)'"
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
	$download_page -match '\d+'
	$urlvers = $Matches[0]
	$version = $Matches[0] + '.0'
	$url64 = "https://github.com/hydrusnetwork/hydrus/releases/download/v$urlvers/Hydrus.Network.v$urlvers.-.Windows.-.Installer.exe"

	return @{ Version = $version; URL64 = $url64 }
}

Update-Package -ChecksumFor none
