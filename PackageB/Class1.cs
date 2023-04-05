namespace PackageB;
public class Class1
{
    private readonly PackageA.Class1 instance;

    public Class1()
    {
        instance = new PackageA.Class1();
    }
}
