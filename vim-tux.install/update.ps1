Import-Module au

$releases = "https://tuxproject.de/projects/vim/"

function global:au_SearchReplace {
	@{
		".\tools\chocolateyinstall.ps1" = @{
			"(?i)(^\`$versPath).*" = "`${1} = '$($Latest.versionPath)'"
    }
		".\tools\chocolateyuninstall.ps1" = @{
			"(?i)(^\`$versPath).*" = "`${1} = '$($Latest.versionPath)'"
    }
		".\tools\VERIFICATION.txt" = @{
			"(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
			"(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
			"(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
		}
	}
}

function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$url32 = 'http://tuxproject.de/projects/vim/complete-x86.exe'
	$url64 = 'http://tuxproject.de/projects/vim/complete-x64.exe'
	$download_page = (iwr $releases -UseBasicParsing).RawContent.Split("`n") | Select-String '<title>'
	$Matches = $null
	$download_page -match "(\d+)\.(\d+)\.\d+"
	$version = $Matches[0]
	$versionPath = "vim" + $Matches[1] + $Matches[2]

	return @{ Version = $version; VersionPath = $versionPath; URL32 = $url32; URL64 = $url64 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor none
}
