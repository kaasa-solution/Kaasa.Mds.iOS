using ObjCRuntime;

namespace Kaasa.Mds.iOS
{
    [Native]
    public enum MDSResponseMethod : long
    {
        Unknown,
        Get,
        Post,
        Put,
        Delete,
        Subscribe,
        Unsubscribe,
        Register,
        Unregister
    }

    [Native]
    public enum MDSRequestMethod : ulong
    {
        Unknown,
        Get,
        Post,
        Put,
        Delete,
        Subscribe,
        Unsubscribe
    }

    [Native]
    public enum MDSLogLevel : ulong
    {
        Debug,
        Info,
        Error,
        None
    }
}
