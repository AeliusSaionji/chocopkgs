Import-Module au

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$releases = 'https://sourceforge.net/projects/vcxsrv/files/vcxsrv/'

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
			"(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
		}

		".\legal\VERIFICATION.txt" = @{
			"(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
			"(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
			"(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
			"(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
			"(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
		}
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url = $download_page.links | ? href -match 'vcxsrv/[0-9.]+/$' | select -expand href -First 1 | % { 'https://sourceforge.net' + $_ }
	$download_files_page = Invoke-WebRequest -Uri $url -UseBasicParsing
	$url32 = $download_files_page.Links | ? {$_ -match "installer.exe/download" -and $_ -notmatch "-64" -and $_ -notmatch "debug"} | select -first 1 -expand href | % { $_.TrimEnd('/download')}
	$url64 = $download_files_page.Links | ? {$_ -match "installer.exe/download" -and $_ -match    "-64" -and $_ -notmatch "debug"} | select -first 1 -expand href | % { $_.TrimEnd('/download')}
	$version = $url -split '/' | select -Last 1 -Skip 1
	$release_notes = "https://sourceforge.net/p/vcxsrv/code/ci/master/tree/releasenotes/releasenote_" + $version + ".txt"

	@{ URL32 = $url32; URL64 = $url64; Version = $version; FileType = 'exe'; ReleaseNotes = $release_notes }
}

Update-Package -ChecksumFor none
