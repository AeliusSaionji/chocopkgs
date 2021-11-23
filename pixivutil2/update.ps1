Import-Module au

$releases = 'https://api.github.com/repos/Nandaka/PixivUtil2/releases/latest'
$headers = @{
    'User-Agent' = 'AeliusSaionji'
    'Accept' = 'application/vnd.github.v3+json'
}

function global:au_SearchReplace {
  @{
    ".\pixivutil2.nuspec" = @{
      "(?i)(^\s*<releaseNotes>\D+2\D+)(\d+)"    = "`${1}$($Latest.versionNotes)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge
}

function global:au_GetLatest {
  $restAPI = Invoke-RestMethod $releases -Headers $headers
  $Matches = $null
  $restAPI.tag_name -match '\d+$'
  $versionNotes = $Matches[0]
  # Defend against upstream typos
  $version = [datetime]::ParseExact($Matches[0],'yyyyMMdd',$null) | Get-Date -Format yyyy.MM.dd
  $url32 = $restAPI.assets | Where-Object { `
    ($_.content_type -eq 'application/x-zip-compressed') -and `
    ($_.name -notlike '*win*') } `
    | Select-Object -First 1 -ExpandProperty browser_download_url

  return @{ Version = $version; versionNotes = $versionNotes; URL32 = $url32 }
}

Update-Package -checksumfor none
