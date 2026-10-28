// Decompiled with JetBrains decompiler
// Type: Kaban.Properties.Resources
// Assembly: Kaban, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9AECCFA3-73DB-498E-920E-F77538729A37
// Assembly location: C:\Users\adamp\Desktop\Qban.exe

using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Globalization;
using System.Resources;
using System.Runtime.CompilerServices;

namespace Kaban.Properties
{
  [GeneratedCode("System.Resources.Tools.StronglyTypedResourceBuilder", "2.0.0.0")]
  [DebuggerNonUserCode]
  [CompilerGenerated]
  internal class Resources
  {
    private static ResourceManager resourceMan;
    private static CultureInfo resourceCulture;

    internal Resources()
    {
    }

    [EditorBrowsable(EditorBrowsableState.Advanced)]
    internal static ResourceManager ResourceManager
    {
      get
      {
        if (Kaban.Properties.Resources.resourceMan == null)
          Kaban.Properties.Resources.resourceMan = new ResourceManager("Kaban.Properties.Resources", typeof (Kaban.Properties.Resources).Assembly);
        return Kaban.Properties.Resources.resourceMan;
      }
    }

    [EditorBrowsable(EditorBrowsableState.Advanced)]
    internal static CultureInfo Culture
    {
      get
      {
        return Kaban.Properties.Resources.resourceCulture;
      }
      set
      {
        Kaban.Properties.Resources.resourceCulture = value;
      }
    }
  }
}
