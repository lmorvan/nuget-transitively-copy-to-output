using System.IO;

namespace PackageA;
public static class Class1
{
    public static void Run()
    {
        if (File.Exists("test.txt"))
        {
            System.Console.WriteLine("PackageA can run as expected.");
        }
        else
        {
            System.Console.WriteLine("PackageA cannot run.");
        }
    }
}
