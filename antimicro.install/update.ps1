Import-Module au

$releases = 'https://api.github.com/repos/AntiMicro/antimicro/releases/latest'
$headers = @{
    'User-Agent' = 'AeliusSaionji'
    'Accept' = 'application/vnd.github.v3+json'
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*[$]?checksumType64\s*=\s*)('.*')" = "`${1}'$($Latest.ChecksumType64)'"
      "(?i)(^\s*[$]?checksum64\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum64)'"
      "(?i)(^\s*[$]?url64\s*=\s*)('.*')"          = "`${1}'$($Latest.URL64)'"
    }
  }
}

function global:au_BeforeUpdate {}

function global:au_GetLatest {
  $restAPI = Invoke-RestMethod $releases -Headers $headers
  $Matches = $null
  $restAPI.tag_name -match '(\d+\.?)+'
  $version = $Matches[0]
  $url64 = $restAPI.assets | Where-Object { ($_.content_type -eq 'application/x-msi') `
    -and ($_.name -notlike '*nosse*' ) } `
    | Select-Object -First 1 -ExpandProperty browser_download_url

  return @{ Version = $version; URL64 = $url64 }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  Update-Package -ChecksumFor 64
}
