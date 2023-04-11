namespace PackageB;
public static class ClassB
{
    public static void Run()
    {
        PackageA.ClassA.Run();
    }
}
