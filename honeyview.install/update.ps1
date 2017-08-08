Import-Module au

$releases = "https://www.bandisoft.com/honeyview/"

function global:au_SearchReplace {
        @{
                ".\legal\VERIFICATION.txt" = @{
                "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
                "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
                }
        }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	function global:au_BeforeUpdate() {
	    #Download $Latest.URL32 / $Latest.URL64 in tools directory and remove any older installers.
	    Get-RemoteFiles -Purge
	}
}

function global:au_GetLatest {
        $url = 'https://dl.bandisoft.com/honeyview/HONEYVIEW-SETUP.EXE'
	$download_page = (iwr $releases -UseBasicParsing).Content.Split("`n") | Select-String 'Honeyview v'
	$Matches = $null
	$download_page -match "\d+\.\d+"
	$version = $Matches[0]

	return @{ Version = $version; URL32 = $url }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
	Update-Package -ChecksumFor none
}
