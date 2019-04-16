. $PSScriptRoot\..\obs-studio.install\update.ps1

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
    }
}


# Left empty intentionally
function global:au_BeforeUpdate { }

Update-Package -ChecksumFor none
