part of gwendart;

class GwenUtil
{
  static const int UTF16_SPACE=32;
  static const int UTF16_DEL = 127;
  static const int UTF16_APS = 159;
  
  static bool icharIsControl(int utf16)
  {
    if(utf16 < 32) return true;
    if(utf16 >= UTF16_DEL && utf16 <= UTF16_APS ) return true;
    return false;
  }
  
  static bool scharIsControl(String schar)
  {
    if(null == schar) return false;
    if(schar.length < 1) return false;
    int utf16 = schar.codeUnitAt(0);
    return icharIsControl(utf16);
  }
  
  static Rectangle FloatRect(double left, double top, double width, double height)
  {
    return new Rectangle(left, top, width, height);
  }
}