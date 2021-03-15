Import-Module au

$releases = "https://cancel.fm/ripcord/updates/v1"
$headers = @{}

function global:au_SearchReplace {
  @{
    ".\tools\VERIFICATION.txt" = @{
      "(?i)(^\s*x64:).*"                  = "`${1} $($Latest.URL64)"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_BeforeUpdate() {
  Get-RemoteFiles -Purge
}

function global:au_GetLatest {
  $restAPI = Invoke-RestMethod $releases -Headers $headers
  # If the array has more than one element, that's a hotfix
  # dev would ideally prefer unupdated users not get the update, and 
  # users who have the update are the only ones to get the hotfix
  $hotfix = 1
  if ($restAPI.versions.windows.normal.count -gt 1) {
    $hotfix = 0
  }
  $Matches = $null
  $restAPI.versions.windows.normal[-1].file_version -match '(\d+\.?)+'
  $version = $Matches[0]
  $url64    = $restAPI.versions.windows.normal[-1].file_url
  $sha256   = $restAPI.versions.windows.normal[-1].sha256

  return @{ Version = $version; URL64 = $url64; Checksum64 = $sha256; ChecksumType64 = 'sha256'; Hotfix = $hotfix }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  Update-Package -checksumfor none
}
