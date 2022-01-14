Import-Module au

$releasesDCH = 'https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/AjaxDriverService.php?func=DriverManualLookup&psid=98&osID=57&languageCode=1033&beta=0&isWHQL=1&dltype=-1&dch=1&upCRD=0&sort1=0&numberOfResults=1'
$releases7864 = 'https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/AjaxDriverService.php?func=DriverManualLookup&psid=98&osID=19&languageCode=1033&beta=0&isWHQL=1&dltype=-1&dch=0&upCRD=0&sort1=0&numberOfResults=1'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url64\s*=\s*)('.*')"                          = "`$1'$($Latest.URLDCH)'"
      "(?i)(^\s*checksumType64\s*=\s*)('.*')"                 = "`$1'$($Latest.ChecksumType64)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"                     = "`$1'$($Latest.ChecksumDCH)'"
      "(?i)(^\s*[$]packageArgs\['url64'\]\s*=\s*)('.*')"      = "`$1'$($Latest.URL7864)'"
      "(?i)(^\s*[$]packageArgs\['checksum64'\]\s*=\s*)('.*')" = "`$1'$($Latest.Checksum7864)'"
    }
    ".\geforce-game-ready-driver.nuspec" = @{
      "(?i)(^\s*<releaseNotes>)(.*)" = "`${1}https://us.download.nvidia.com/Windows/$($Latest.Version)/$($Latest.Version)-win11-win10-win8-win7-release-notes.pdf</releaseNotes>"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.ChecksumType64 = "sha256"
  $Latest.Checksum7864 = Get-RemoteChecksum -Url $Latest.URL7864
  $Latest.ChecksumDCH  = Get-RemoteChecksum -Url $Latest.URLDCH
  # export checksums for use with other package
  sc ..\knownChecksums "$Latest.Checksum7864`n$Latest.ChecksumDCH"
}

function global:au_GetLatest {
  # check for presence of exported checksums from other package
  if (Test-Path ..\knownChecksums) {
    # overwrite function with known checksums
    function global:au_BeforeUpdate {
      $knownChecksums = gc ..\knownChecksums
      $Latest.ChecksumType64 = "sha256"
      $Latest.Checksum7864 = $knownChecksums[0]
      $Latest.ChecksumDCH  = $knownChecksums[1]
      rm ..\knownChecksums
    }
  }
  $restDCH  = Invoke-RestMethod $releasesDCH -UseBasicParsing
  $rest7864 = Invoke-RestMethod $releases7864 -UseBasicParsing
  $version  = $restDCH.IDS[0].downloadInfo.Version
  $urlDCH   = $restDCH.IDS[0].downloadInfo.DownloadURL
  $url7864  = $rest7864.IDS[0].downloadInfo.DownloadURL
  # Unfortunately I can't think of a clean way to detect -rp just once. The code below releases a new version every time an update is checked for...
  # if (iwr -Method Head "https://us.download.nvidia.com/Windows/$version/$version-desktop-win10-64bit-international-whql-rp.exe") {
  #   $url7864 = "https://us.download.nvidia.com/Windows/$version/$version-desktop-win8-win7-64bit-international-whql-rp.exe"
  #   $version = $Matches[0] + ".0.$(Get-Date -Format yyyyMMdd)"
  # }
  return @{
    Version = $version
    URLDCH  = $urlDCH
    URL7864 = $url7864
  }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  Update-Package -ChecksumFor none
}
