Remove-Item *.nupkg
Remove-Item -Recurse **/bin
Remove-Item -Recurse **/obj
Remove-Item -Recurse **/publish

dotnet pack PackageA/PackageA.csproj -o .
dotnet pack PackageB/PackageB.csproj -o .
dotnet pack PackageC/PackageC.csproj -o .

function DidCopied($outputPath) {
    if (Test-Path $outputPath/test.txt) {
        Write-Output "test.txt has been successfully copied to $outputPath."
    } else {
        Write-Output "test.txt has NOT been copied to $outputPath."
    }
}

function DoTest($folder, $project) {
    Write-Output "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
    DidCopied $folder
    Push-Location $folder
    dotnet ./$project.dll
    Pop-Location
    Write-Output "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
}

function Test($project) {
    dotnet build $project -o $project/bin
    DoTest $project/bin/ $project

    dotnet publish -r win-x64 $project --no-self-contained -o $project/publish
    DoTest $project/publish/ $project
}

Test "ProjectConsumingA"
Test "ProjectConsumingB"
Test "ProjectConsumingC"
Test "FinalApplication"
