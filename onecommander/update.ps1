Import-Module au

$releases = 'https://onecommander.com/version.txt'
$headers = @{
    'User-Agent' = 'AeliusSaionji'
}

function global:au_SearchReplace {
	@{
		".\tools\VERIFICATION.txt" = @{
			"(?i)(^\s*x64:).*"                  = "`${1} $($Latest.URL64)"
			"(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
			"(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
		}
	}
}
function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge
}

function global:au_GetLatest {
  #TODO
  ##(Get-Item oc.exe).VersionInfo.FileVersion to no-op updates
  ##In installer: check if running, abort, do not kill
  $version = Invoke-WebRequest $releases -UseBasicParsing
  $url64 = "https://onecommander.com/OneCommander$version.zip"

	return @{ Version = $version; URL64 = $url64; }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -checksumfor none
}
