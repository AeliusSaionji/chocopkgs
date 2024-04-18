Import-Module au

$releases = 'https://www.hwinfo.com/ver.txt'

function global:au_SearchReplace {
  @{
    ".\tools\VERIFICATION.txt" = @{
      "(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL64)"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.ChecksumType64 = 'SHA256'
  Remove-Item -Force -ea 0 tools\hwi64.exe
  $Headers = @{ Referer = 'https://www.hwinfo.com/download.php' }
  iwr $Latest.URL64 -OutFile tools\hwi64.exe -Headers $Headers
  $Latest.Checksum64 = (Get-FileHash tools\hwi64.exe -Algorithm $Latest.ChecksumType64).Hash
}

function global:au_GetLatest {
  $Matches = $null
  (iwr $releases -UseBasicParsing).Content -match '\d+\.\d+'
  $version = $Matches[0]
  $urlvers = $version.Replace(".","")
  $url64   = "https://www.hwinfo.com/files/hwi64_$urlvers.exe"

  return @{ Version = $version; URL64 = $url64 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  Update-Package -NoCheckUrl -ChecksumFor none
}
