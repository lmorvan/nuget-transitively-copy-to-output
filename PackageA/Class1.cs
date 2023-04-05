namespace PackageA;
public class Class1
{
    public Class1()
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
