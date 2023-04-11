namespace PackageA;
public static class ClassA
{
    public static void Run()
    {
        if (File.Exists("test.txt"))
        {
            Console.WriteLine("PackageA can run as expected.");
        }
        else
        {
            Console.WriteLine("PackageA cannot run.");
        }
    }
}
