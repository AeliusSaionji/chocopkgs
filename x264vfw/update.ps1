import-module au

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$releases = 'https://sourceforge.net/projects/x264vfw/files/x264vfw/'

function global:au_SearchReplace {
	@{
	".\legal\VERIFICATION.txt" = @{
		"(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
		"(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
		"(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url = $download_page.Links | ? href -match 'x264vfw/[0-9]+' | select -expand href -First 1 | % { 'https://sourceforge.net' + $_ }
	$download_files_page = Invoke-WebRequest -Uri $url -UseBasicParsing
	$url32 = $download_files_page.Links | ? {$_ -match '.exe/download'} | select -first 1 -expand href | % { $_.TrimEnd('/download')}
	$download_files_page.Content -split '\n' | sls 'released on' | ? {$_ -match '[\d]+-[\d]+-[\d]+'; $dashVersion = $Matches[0]}
	$version = $dashVersion -replace ('-','.')
	
	@{ URL32 = $url32; Version = $version; FileType = 'exe' }
}

Update-Package -ChecksumFor none