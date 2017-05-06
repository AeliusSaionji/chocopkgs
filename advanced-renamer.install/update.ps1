import-module au

$releases = 'https://www.advancedrenamer.com/download'


function global:au_SearchReplace {
	@{
		".\tools\chocolateyinstall.ps1" = @{
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
	$download_page = iwr $releases -UseBasicParsing | % Links | % Title | Select-Object -First 1
	$Matches = $null
	$download_page -match "\d+\.\d+"
	$version = $Matches[0]

	return @{ Version = $version }
}

Update-Package -ChecksumFor 32
