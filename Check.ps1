Remove-Item *.nupkg

 # Update me to bypass cache!!!!
$packVersions = "1.0.0"

dotnet pack PackageA/PackageA.csproj -o . /p:PackVersions=$packVersions
dotnet pack PackageB/PackageB.csproj -o . /p:PackVersions=$packVersions

function Test($project) {
    dotnet restore --no-cache $project /p:PackVersions=$packVersions
    dotnet build --no-restore $project /p:PackVersions=$packVersions

    Write-Output "============================================="
    if (Test-Path $project/bin/Debug/net7.0/test.txt) {
        Write-Output ">>>>>>> $project has successfully copied the content."
    } else {
        Write-Output ">>>>>>> $project has failed in copying the content."
    }
    Write-Output "============================================="
}

Test "ProjectConsumingA"
Test "ProjectConsumingB"
