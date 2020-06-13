Import-Module au

$releases = 'https://api.github.com/repos/Nandaka/PixivUtil2/releases/latest'
$headers = @{
    'User-Agent' = 'AeliusSaionji'
    'Accept' = 'application/vnd.github.v3+json'
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*[$]checksumType\s*=\s*)('.*')" = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)(^\s*[$]checksum\s*=\s*)('.*')"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*[$]url\s*=\s*)('.*')"          = "`${1}'$($Latest.URL32)'"
    }
    ".\pixivutil2.nuspec" = @{
      "(?i)(^\s*<releaseNotes>\D+2\D+)(\d+)"    = "`${1}$($Latest.versionNotes)"
    }
  }
}

function global:au_BeforeUpdate {}

function global:au_GetLatest {
  $restAPI = Invoke-RestMethod $releases -Headers $headers
  $Matches = $null
  $restAPI.tag_name -match '\d+$'
  $versionNotes = $Matches[0]
  $version = [datetime]::ParseExact($Matches[0],'yyyyMMdd',$null) | Get-Date -Format yyyy.MM.dd
  $url32 = $restAPI.assets.browser_download_url

  return @{ Version = $version; versionNotes = $versionNotes; URL32 = $url32 }
}

Update-Package
