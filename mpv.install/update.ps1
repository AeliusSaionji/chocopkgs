Import-Module au

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$releases = 'https://sourceforge.net/projects/mpv-player-windows/files/release/'

function global:au_SearchReplace {
  @{
    ".\tools\VERIFICATION.txt"      = @{
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
  Get-RemoteFiles -Purge
  iwr -UseBasicParsing 'https://github.com/rossy/mpv-install/archive/master.zip' -OutFile 'tools/rossy.zip'
	$Latest.installSum = (Get-FileHash 'tools/rossy.zip' -Algorithm $Latest.ChecksumType32).Hash
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32   = $download_page.Links | ? {$_ -match "7z/download" -and $_ -notmatch "_64"} | select -first 1 -expand href | % { $_.TrimEnd('/download')}
  $url64   = $download_page.Links | ? {$_ -match "7z/download" -and $_ -match    "_64\."} | select -first 1 -expand href | % { $_.TrimEnd('/download')}
  $urlInst = 'https://github.com/rossy/mpv-install/archive/master.zip'

  $url32 -match '\d+\.\d+\.\d+'
  $version = $Matches[0]

  return @{ Version = $version; URL32 = $url32; URL64 = $url64; URLINST = $urlInst }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  Update-Package -ChecksumFor none
}
