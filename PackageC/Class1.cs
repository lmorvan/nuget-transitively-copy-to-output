namespace PackageC;
public class Class1
{
    private readonly PackageB.Class1 instance;

    public Class1()
    {
        instance = new PackageB.Class1();
    }
}
