Import-Module au

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$releases = 'https://mpv.srsfckn.biz/'

function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt"      = @{
		"(?i)(\s+x32:).*"               = "`${1} $($Latest.URL32)"
		"(?i)(\s+x64:).*"               = "`${1} $($Latest.URL64)"
		"(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
		"(?i)(^\s*checksum32\:).*"      = "`${1} $($Latest.Checksum32)"
		"(?i)(^\s*checksum64\:).*"      = "`${1} $($Latest.Checksum64)"
		}
		".\mpv.portable.nuspec"          = @{
		"(?i)(^\s*<releaseNotes>)(.*)" = "`${1}https://https://mpv.srsfckn.biz/changes/$($Latest.CHANGES)/</releaseNotes>"
		}
	}
}

function global:au_BeforeUpdate {
	$Latest.ChecksumType32 = 'SHA256'
	Remove-Item -Force -ea 0 tools\*.7z
	iwr $Latest.URL32 -OutFile tools\mpv_x32.7z
	iwr $Latest.URL64 -OutFile tools\mpv_x64.7z
	$Latest.Checksum32 = (Get-FileHash 'tools\mpv_x32.7z' -Algorithm $Latest.ChecksumType32).Hash
	$Latest.Checksum64 = (Get-FileHash 'tools\mpv_x64.7z' -Algorithm $Latest.ChecksumType32).Hash
}

function global:au_GetLatest {
	$Matches = $null
	$fileName = (iwr $releases -UseBasicParsing).Links.href -match '\.7z' | Select-Object -First 1
	$fileName -match '\d{8}'
	$urlVers = $Matches[0]
	$version = [datetime]::ParseExact($Matches[0],'yyyyMMdd',$null) | Get-Date -Format yyyy.MM.dd
	$changes = [datetime]::ParseExact($Matches[0],'yyyyMMdd',$null) | Get-Date -Format yyyy-MM-dd
	$url32   = "https://mpv.srsfckn.biz/mpv-i686-$urlVers.7z"
	$url64   = "https://mpv.srsfckn.biz/mpv-x86_64-$urlVers.7z"

	return @{ Version = $version; URL32 = $url32; URL64 = $url64; CHANGES = $changes }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor none
}
