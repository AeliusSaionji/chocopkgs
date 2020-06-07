Import-Module au

$releases = "https://plex.tv/api/downloads/6.json"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*url64\s*=).*"              = "`${1} '$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*Type64\s*=).*"  = "`${1} '$($Latest.ChecksumType64)'"
      "(?i)(^\s*checksum64\s*=).*"         = "`${1} '$($Latest.Checksum64)'"
    }
  }
}

function global:au_BeforeUpdate() {
  Get-RemoteFiles -Purge
}

function global:au_GetLatest {
  $download_page = iwr $releases -UseBasicParsing | ConvertFrom-Json
  # If the array has more than one element, that's probably a hotfix
  $hotfix = 0
  if ($download_page.computer.Windows.releases.count -gt 1) {
    $hotfix = 1
  }
  $Matches = $null
  $download_page.computer.Windows.version -match '(\d+\.?)+'
  $version = $Matches[0]
  $url64   = $download_page.computer.Windows.releases[-1].url
  $sha1    = $download_page.computer.Windows.releases[-1].checksum

  return @{ Version = $version; URL64 = $url64; Checksum64 = $sha1; ChecksumType64 = 'sha1'; Hotfix = $hotfix }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  Update-Package -checksumfor none
}
