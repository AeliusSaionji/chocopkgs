Import-Module au

$releases = "https://tuxproject.de/projects/vim/"

function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt" = @{
		"(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
		"(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
		"(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_BeforeUpdate() {
	#Download $Latest.URL32 / $Latest.URL64 in tools directory and remove any older installers.
	Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$url32 = 'http://tuxproject.de/projects/vim/complete-x86.7z'
	$url64 = 'http://tuxproject.de/projects/vim/complete-x64.7z'
	$download_page = (iwr $releases -UseBasicParsing).Content.Split("`n") | Select-String '<title>'
	$Matches = $null
	$download_page -match "\d+\.\d+\.\d+"
	$version = $Matches[0]

	return @{ Version = $version; URL32 = $url32; URL64 = $url64 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor none
}