import-module au

$releases = 'https://www.advancedrenamer.com/download'


function global:au_SearchReplace {
	@{
		".\tools\VERIFICATION.txt" = @{
			"(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType64)"
			"(?i)(^\s*checksum(64)?\:).*"   = "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
	$download_page = iwr $releases -UseBasicParsing
	$Matches = $null
  $download_page -match "(\d+_\d+_\d+)\.zip"
	$version = $Matches[1] -replace '_','.'
  $url64 = 'https://www.advancedrenamer.com/down/advanced_renamer_portable_' + $Matches[0]

	return @{ Version = $version; URL64 = $url64 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor none
}
