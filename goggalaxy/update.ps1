Import-Module au

$releases = 'https://remote-config.gog.com/components/webinstaller?component_version=2.0.0'
$headers = @{}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_BeforeUpdate() {}

function global:au_GetLatest {
  $restAPI = Invoke-RestMethod $releases -Headers $headers
  $Matches = $null
  $restAPI.content.windows.version -match '(\d+\.?)+'
  $version = $Matches[0]
  $url32   = $restAPI.content.windows.downloadLink
  $md5     = $restAPI.content.windows.installerMd5

  return @{ Version = $version; URL32 = $url32; Checksum32 = $md5; ChecksumType32 = 'md5' }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  Update-Package -checksumfor none
}
