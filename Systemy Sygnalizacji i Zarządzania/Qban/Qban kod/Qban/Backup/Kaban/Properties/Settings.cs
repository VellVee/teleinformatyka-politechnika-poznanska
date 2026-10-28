// Decompiled with JetBrains decompiler
// Type: Kaban.Properties.Settings
// Assembly: Kaban, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9AECCFA3-73DB-498E-920E-F77538729A37
// Assembly location: C:\Users\adamp\Desktop\Qban.exe

using System.CodeDom.Compiler;
using System.Configuration;
using System.Runtime.CompilerServices;

namespace Kaban.Properties
{
  [GeneratedCode("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "9.0.0.0")]
  [CompilerGenerated]
  internal sealed class Settings : ApplicationSettingsBase
  {
    private static Settings defaultInstance = (Settings) SettingsBase.Synchronized((SettingsBase) new Settings());

    public static Settings Default
    {
      get
      {
        Settings defaultInstance = Settings.defaultInstance;
        return defaultInstance;
      }
    }
  }
}
