Import-Module au

$releases = 'https://api.github.com/repos/qutebrowser/qutebrowser/releases/latest'
$headers = @{
    'User-Agent' = 'AeliusSaionji'
    'Accept' = 'application/vnd.github.v3+json'
}

function global:au_SearchReplace {
  @{
    ".\tools\VERIFICATION.txt" = @{
      "(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL64)"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(\s+file64\s+=).*"          = "`${1} `"`$toolsdir\$($Latest.FileName64)`""
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge
}

function global:au_GetLatest {
  $restAPI = Invoke-RestMethod $releases -Headers $headers
  $Matches = $null
  $restAPI.tag_name -match '(\d+\.?)+'
  $version = $Matches[0]
  $url64 = $restAPI.assets | Where-Object { ($_.content_type -eq 'application/zip') `
    -and ($_.name -like '*windows-standalone*') } `
    | Select-Object -First 1 -ExpandProperty browser_download_url

  return @{ Version = $version; URL64 = $url64; }
}

Update-Package -checksumfor none
