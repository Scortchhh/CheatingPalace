using System;
using System.Reflection;

namespace mainLoader
{
    public enum KnownFolderType
    {
        /// <summary>
        /// The per-user app desktop folder, used internally by .NET applications to perform cross-platform app
        /// functionality. Introduced in Windows 10.
        /// Defaults to &quot;%LOCALAPPDATA%\Desktop&quot;.
        /// </summary>
        [KnownFolderGuid("B2C5E279-7ADD-439F-B28C-C41FE1BBF672")]
        AppDataDesktop,

        /// <summary>
        /// The per-user app documents folder, used internally by .NET applications to perform cross-platform app
        /// functionality. Introduced in Windows 10.
        /// Defaults to &quot;%LOCALAPPDATA%\Documents&quot;.
        /// </summary>
        [KnownFolderGuid("7BE16610-1F7F-44AC-BFF0-83E15F2FFCA1")]
        AppDataDocuments,

        /// <summary>
        /// The per-user app program data folder, used internally by .NET applications to perform cross-platform app
        /// functionality. Introduced in Windows 10.
        /// Defaults to &quot;%LOCALAPPDATA%\ProgramData&quot;.
        /// </summary>
        [KnownFolderGuid("559D40A3-A036-40FA-AF61-84CB430A4D34")]
        AppDataProgramData,

        /// <summary>
        /// The per-user Desktop folder.
        /// Defaults to &quot;%USERPROFILE%\Desktop&quot;.
        /// </summary>
        [KnownFolderGuid("B4BFCC3A-DB2C-424C-B029-7FE99A87C641")]
        Desktop,

        /// <summary>
        /// The per-user Documents folder.
        /// Defaults to &quot;%USERPROFILE%\Documents&quot;.
        /// </summary>
        [KnownFolderGuid("FDD39AD0-238F-46AF-ADB4-6C85480369C7")]
        Documents,

        /// <summary>
        /// The per-user Documents library. Introduced in Windows 7.
        /// Defaults to &quot;%APPDATA%\Microsoft\Windows\Libraries\Documents.library-ms&quot;.
        /// </summary>
        [KnownFolderGuid("7B0DB17D-9CD2-4A93-9733-46CC89022E7C")]
        DocumentsLibrary,

        /// <summary>
        /// The per-user localized Documents folder.
        /// Defaults to &quot;%USERPROFILE%\Documents&quot;.
        /// </summary>
        [KnownFolderGuid("F42EE2D3-909F-4907-8871-4C22FC0BF756")]
        DocumentsLocalized,

        /// <summary>
        /// The per-user Downloads folder.
        /// Defaults to &quot;%USERPROFILE%\Downloads&quot;.
        /// </summary>
        [KnownFolderGuid("374DE290-123F-4565-9164-39C4925E467B")]
        Downloads,

        /// <summary>
        /// The per-user localized Downloads folder.
        /// Defaults to &quot;%USERPROFILE%\Downloads&quot;.
        /// </summary>
        [KnownFolderGuid("7d83ee9b-2244-4e70-b1f5-5393042af1e4")]
        DownloadsLocalized,

        /// <summary>
        /// The per-user Temporary Internet Files folder.
        /// Defaults to &quot;%LOCALAPPDATA%\Microsoft\Windows\Temporary Internet Files&quot;.
        /// </summary>
        [KnownFolderGuid("352481E8-33BE-4251-BA85-6007CAEDCF9D")]
        InternetCache,

        /// <summary>
        /// The per-user Local folder.
        /// Defaults to &quot;%LOCALAPPDATA%&quot; (&quot;%USERPROFILE%\AppData\Local&quot;)&quot;.
        /// </summary>
        [KnownFolderGuid("F1B32785-6FBA-4FCF-9D55-7B8E7F157091")]
        LocalAppData,

        /// <summary>
        /// The per-user LocalLow folder.
        /// Defaults to &quot;%USERPROFILE%\AppData\LocalLow&quot;.
        /// </summary>
        [KnownFolderGuid("A520A1A4-1780-4FF6-BD18-167343C5AF16")]
        LocalAppDataLow,

        /// <summary>
        /// The fixed Public folder. Introduced in Windows Vista.
        /// Defaults to &quot;%PUBLIC%&quot; (&quot;%SYSTEMDRIVE%\Users\Public)&quot;.
        /// </summary>
        [KnownFolderGuid("DFDF76A2-C82A-4D63-906A-5644AC457385")]
        Public,

        /// <summary>
        /// The common Public Desktop folder.
        /// Defaults to &quot;%PUBLIC%\Desktop&quot;.
        /// </summary>
        [KnownFolderGuid("C4AA340D-F20F-4863-AFEF-F87EF2E6BA25")]
        PublicDesktop,

        /// <summary>
        /// The common Public Documents folder.
        /// Defaults to &quot;%PUBLIC%\Documents&quot;.
        /// </summary>
        [KnownFolderGuid("ED4824AF-DCE4-45A8-81E2-FC7965083634")]
        PublicDocuments,

        /// <summary>
        /// The common Public Downloads folder. Introduced in Windows Vista.
        /// Defaults to &quot;%PUBLIC%\Downloads&quot;.
        /// </summary>
        [KnownFolderGuid("3D644C9B-1FB8-4F30-9B45-F670235F79C0")]
        PublicDownloads,

        /// <summary>
        /// The per-user Roaming folder.
        /// Defaults to &quot;%APPDATA%&quot; (&quot;%USERPROFILE%\AppData\Roaming&quot;).
        /// </summary>
        [KnownFolderGuid("3EB685DB-65F9-4CF6-A03A-E3EF65729F3D")]
        RoamingAppData,

        /// <summary>
        /// The per-user History folder. Introduced in Windows 8.1.
        /// Defaults to &quot;%LOCALAPPDATA%\Microsoft\Windows\ConnectedSearch\History&quot;.
        /// </summary>
        [KnownFolderGuid("0D4C3DB6-03A3-462F-A0E6-08924C41B5D4")]
        SearchHistory,

        /// <summary>
        /// The per-user Templates folder. Introduced in Windows 8.1.
        /// Defaults to &quot;%LOCALAPPDATA%\Microsoft\Windows\ConnectedSearch\Templates&quot;.
        /// </summary>
        [KnownFolderGuid("7E636BFE-DFA9-4D5E-B456-D7B39851D8A9")]
        SearchTemplates,
    }

    /// <summary>
    /// Represents extension methods for the <see cref="KnownFolderType"/> type.
    /// </summary>
    internal static class KnownFolderTypeExtensions
    {
        // ---- METHODS (INTERNAL) -------------------------------------------------------------------------------------

        /// <summary>
        /// Gets the <see cref="Guid"/> with which the <see cref="KnownFolderType"/> enumeration member has been
        /// decorated.
        /// </summary>
        /// <param name="value">The decorated <see cref="KnownFolderType"/> enumeration member.</param>
        /// <returns>The <see cref="Guid"/> of the <see cref="KnownFolderType"/>.</returns>
        internal static Guid GetGuid(this KnownFolderType value)
        {
            FieldInfo member = typeof(KnownFolderType).GetField(value.ToString());
            object[] attributes = member.GetCustomAttributes(typeof(KnownFolderGuidAttribute), false);
            KnownFolderGuidAttribute guidAttribute = (KnownFolderGuidAttribute)attributes[0];
            return guidAttribute.Guid;
        }
    }

    /// <summary>
    /// Represents an attribute to decorate the members of the <see cref="KnownFolderType"/> enumeration with their
    /// corresponding <see cref="Guid"/> on the Windows system.
    /// </summary>
    [AttributeUsage(AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
    internal class KnownFolderGuidAttribute : Attribute
    {
        // ---- CONSTRUCTORS & DESTRUCTOR ------------------------------------------------------------------------------

        /// <summary>
        /// Initializes a new instance of the <see cref="KnownFolderGuidAttribute"/> class with the given string
        /// representing the GUID of the <see cref="KnownFolderType"/>.
        /// </summary>
        /// <param name="guid">The GUID string of the <see cref="KnownFolderType"/>.</param>
        internal KnownFolderGuidAttribute(string guid)
        {
            Guid = new Guid(guid);
        }

        // ---- PROPERTIES ---------------------------------------------------------------------------------------------

        /// <summary>
        /// Gets the <see cref="Guid"/> for the <see cref="KnownFolderType"/> enumeration member.
        /// </summary>
        internal Guid Guid { get; }
    }
}
