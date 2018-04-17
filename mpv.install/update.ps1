Import-Module au

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$releases = 'https://mpv.srsfckn.biz/'

function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt"      = @{
		"(?i)(\s+x32:).*"               = "`${1} $($Latest.URL32)"
		"(?i)(\s+x64:).*"               = "`${1} $($Latest.URL64)"
		"(?i)(\s+zip:).*"               = "`${1} $($Latest.URLINST)"
		"(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
		"(?i)(^\s*checksum32\:).*"      = "`${1} $($Latest.Checksum32)"
		"(?i)(^\s*checksum64\:).*"      = "`${1} $($Latest.Checksum64)"
		"(?i)(^\s*checksumzp\:).*"      = "`${1} $($Latest.installSum)"
		}
	}
}

function global:au_BeforeUpdate {
	$Latest.ChecksumType32 = 'SHA256'
	Remove-Item -Force -ea 0 tools\*.7z,tools\rossy.zip
	iwr $Latest.URL32 -OutFile tools\mpv_x32.7z
	iwr $Latest.URL64 -OutFile tools\mpv_x64.7z
	iwr -UseBasicParsing 'https://github.com/rossy/mpv-install/archive/master.zip' -OutFile 'tools/rossy.zip'
	$Latest.Checksum32 = (Get-FileHash 'tools\mpv_x32.7z' -Algorithm $Latest.ChecksumType32).Hash
	$Latest.Checksum64 = (Get-FileHash 'tools\mpv_x64.7z' -Algorithm $Latest.ChecksumType32).Hash
	$Latest.installSum = (Get-FileHash 'tools/rossy.zip'  -Algorithm $Latest.ChecksumType32).Hash
}

function global:au_GetLatest {
	$Matches = $null
	$fileName = (iwr $releases -UseBasicParsing).Links.href -match '\.7z' | Select-Object -First 1
	$fileName -match '\d{8}'
	$urlVers = $Matches[0]
	$version = [datetime]::ParseExact($Matches[0],'yyyyMMdd',$null) | Get-Date -Format yyyy.MM.dd
	$url32   = "https://mpv.srsfckn.biz/mpv-i686-$urlVers.7z"
	$url64   = "https://mpv.srsfckn.biz/mpv-x86_64-$urlVers.7z"
	$urlInst = 'https://github.com/rossy/mpv-install/archive/master.zip'

	return @{ Version = $version; URL32 = $url32; URL64 = $url64; URLINST = $urlInst }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor none
}
