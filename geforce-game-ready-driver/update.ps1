Import-Module au

$releases = 'https://www.nvidia.com/Download/processFind.aspx?psid=95&pfid=694&osid=19&lid=1&whql=&lang=en-us'

function global:au_SearchReplace {
        @{
		".\tools\chocolateyInstall.ps1" = @{
			"(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
			"(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
			"(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
                }
        }
}

function global:au_GetLatest {
	$download_page = (iwr $releases -UseBasicParsing).Content.Split("`n") | Select-String "class=""gridItem"">\d+\.\d+</td>" | Select-Object -First 1
	$Matches = $null
	$download_page -match "\d+\.\d+"
	$version = $Matches[0]

	return @{ Version = $version }
}

Update-Package -ChecksumFor all
