# Content from NuGet copy to output issue

## How to execute

As a prerequisites, you need .NET 7 to be installed (you can also downgrade the version needed by editing the 4 projects yourself).

You can build and run the test by running the script `Check.ps1`.

If you want to do more tests, you will need to update the `$packVersions` variable from that `Check.ps1` script, as the cache will probably restore previous versions of the packages.

## What to expect

Let's say that - for some reasons - my `PackageA` absolutely needs the file `test.txt` to be present in the final application binary folder to run correctly.

In `PackageA.csproj`, the file is declared as `Content` with the metadata `PackageCopyToOutput` set to true.

As expected, the project `ProjectConsumingA` consuming the generated `PackageA` package, will copy `test.txt` to its output.

When running the script `Check.ps1`, you can see these lines in the output, after build:
```log
=============================================
test.txt has been successfully copied to ProjectConsumingA/bin/Debug/net7.0.
=============================================
```
and after publish:
```log
=============================================
test.txt has been successfully copied to ProjectConsumingA/bin/Debug/net7.0/publish.
=============================================
```

So far, so good.

However, when the `PackageA` is referenced by a `PackageB`, and a `ProjectConsumingB` consumes the generated package `PackageB`, the file `test.txt` is not copied to its output. That way the transitively referenced `PackageA` will never work as expected.

Again, with the script `Check.ps1`, you can see, after build:
```log
=============================================
test.txt has NOT been copied to ProjectConsumingB/bin/Debug/net7.0.
=============================================
```
and after publish:
```log
=============================================
test.txt has NOT been copied to ProjectConsumingB/bin/Debug/net7.0/publish.
=============================================
```

## Expected behavior

I want the file `test.txt` from `PackageA` to be transitively copied in the output of the project `ProjectConsumingB` through the package reference to `PackageB` when building and publishing `ProjectConsumingB`.
