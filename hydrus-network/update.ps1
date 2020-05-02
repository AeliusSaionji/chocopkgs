Import-Module au

$releases = "https://github.com/hydrusnetwork/hydrus/releases/latest"

function global:au_SearchReplace {
  @{
    ".\tools\VERIFICATION.txt" = @{
      "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
      "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
      "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
    }
   }
}

function global:au_BeforeUpdate() {
    #Download $Latest.URL32 / $Latest.URL64 in tools directory and remove any older installers.
    Get-RemoteFiles -Purge
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Links.href | Select-String '/tag/v' | Select-Object -First 1
	$Matches = $null
	$download_page -match '\d+'
	$urlvers = $Matches[0]
	$version = $Matches[0] + '.0'
	$url64 = "https://github.com/hydrusnetwork/hydrus/releases/download/v$urlvers/Hydrus.Network.$urlvers.-.Windows.-.Installer.exe"

	return @{ Version = $version; URL64 = $url64 }
}

Update-Package -ChecksumFor none
