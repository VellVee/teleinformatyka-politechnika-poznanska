// Decompiled with JetBrains decompiler
// Type: Form1.Program
// Assembly: Kaban, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 9AECCFA3-73DB-498E-920E-F77538729A37
// Assembly location: C:\Users\adamp\Desktop\Qban.exe

using System;
using System.Windows.Forms;

namespace Form1
{
  internal static class Program
  {
    [STAThread]
    private static void Main()
    {
      Application.EnableVisualStyles();
      Application.SetCompatibleTextRenderingDefault(false);
      Application.Run((Form) new Form1());
    }
  }
}
