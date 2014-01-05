part of gwendart;

class Neutral
{
   static DateTime _firstTime = new DateTime.now();
   static void SetCursor(CssCursor cursor)
   {
      // todo: Not sure what to do here, your cursor depends on what the mouse is over...
   }
   
   static String GetClipboardText()
   {
     /* TODO: add clipboard support. */
     return "";
   }
   
   static bool SetClipboardText(String text)
   {
     /* TODO: add clipboard support. */
   }
   
   static double GetTimeInSeconds()
   {
      DateTime now = new DateTime.now();
      Duration difference = now.difference(_firstTime);
      return difference.inSeconds.toDouble();
   }
   
   static bool FileOpen(String title, String startPath, String extension, var Action)
   {
     throw new UnimplementedError("Platform.Neutral FileOpen() not implemented");
   }
   
   static bool FileSave(String title, String startPath, String extension, var Action)
   {
     throw new UnimplementedError("Platform.Neutral FileSave() not implemented");
   }
}