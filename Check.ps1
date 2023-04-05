Remove-Item *.nupkg

 # Update me to bypass cache!!!!
$packVersions = "1.0.0-test.32"

dotnet pack PackageA/PackageA.csproj -o . /p:PackVersions=$packVersions
dotnet pack PackageB/PackageB.csproj -o . /p:PackVersions=$packVersions
dotnet pack PackageC/PackageC.csproj -o . /p:PackVersions=$packVersions

function DidCopied($outputPath) {
    if (Test-Path $outputPath/test.txt) {
        Write-Output "test.txt has been successfully copied to $outputPath."
    } else {
        Write-Output "test.txt has NOT been copied to $outputPath."
    }
}

function Test($project) {
    dotnet restore --no-cache $project /p:PackVersions=$packVersions

    dotnet build --no-restore $project /p:PackVersions=$packVersions
    Write-Output "============================================="
    DidCopied $project/bin/Debug/net7.0
    Push-Location $project/bin/Debug/net7.0/
    dotnet ./$project.dll
    Pop-Location
    Write-Output "============================================="

    dotnet publish --no-build $project /p:PackVersions=$packVersions
    Write-Output "============================================="
    DidCopied $project/bin/Debug/net7.0/publish
    Push-Location $project/bin/Debug/net7.0/publish/
    dotnet ./$project.dll
    Pop-Location
    Write-Output "============================================="
}

Test "ProjectConsumingA"
Test "ProjectConsumingB"
Test "ProjectConsumingC"
Test "FinalApplication"
