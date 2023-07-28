using System.Reflection;

public static class VersionHelper
{
    public static string GetAssemblyVersion()
    {
        var assembly = Assembly.GetExecutingAssembly();
        var versionAttribute = assembly.GetCustomAttribute<AssemblyVersionAttribute>();
        return versionAttribute.Version;
    }
}
