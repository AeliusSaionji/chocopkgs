import-module au

$releases = 'https://www.advancedrenamer.com/download'


function global:au_SearchReplace {
	@{
                ".\legal\VERIFICATION.txt" = @{
                "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
                "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }


function global:au_GetLatest {
	$url = 'https://www.advancedrenamer.com/down/advanced_renamer_portable.zip'
	$download_page = iwr $releases -UseBasicParsing | % Links | % Title | Select-Object -First 1
	$Matches = $null
	$download_page -match "\d+\.\d+"
	$version = $Matches[0]

	return @{ Version = $version; URL32 = $url }
}

Update-Package -ChecksumFor none