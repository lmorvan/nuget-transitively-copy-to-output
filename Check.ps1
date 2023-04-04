Remove-Item *.nupkg

 # Update me to bypass cache!!!!
$packVersions = "1.0.0"

dotnet pack PackageA/PackageA.csproj -o . /p:PackVersions=$packVersions
dotnet pack PackageB/PackageB.csproj -o . /p:PackVersions=$packVersions

function DidCopied($outputPath) {
    Write-Output "============================================="
    if (Test-Path $outputPath/test.txt) {
        Write-Output "test.txt has been successfully copied to $outputPath."
    } else {
        Write-Output "test.txt has NOT been copied to $outputPath."
    }
    Write-Output "============================================="
}

function Test($project) {
    dotnet restore --no-cache $project /p:PackVersions=$packVersions

    dotnet build --no-restore $project /p:PackVersions=$packVersions
    DidCopied $project/bin/Debug/net7.0

    dotnet publish --no-build $project /p:PackVersions=$packVersions
    DidCopied $project/bin/Debug/net7.0/publish
}

Test "ProjectConsumingA"
Test "ProjectConsumingB"
