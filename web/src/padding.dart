part of gwendart;

class GwenPadding 
{
  
  final int Top;
  final int Bottom;
  final int Left;
  final int Right;

  // common values
  static GwenPadding Zero = new GwenPadding(0, 0, 0, 0);
  static GwenPadding One = new GwenPadding(1, 1, 1, 1);
  static GwenPadding Two = new GwenPadding(2, 2, 2, 2);
  static GwenPadding Three = new GwenPadding(3, 3, 3, 3);
  static GwenPadding Four = new GwenPadding(4, 4, 4, 4);
  static GwenPadding Five = new GwenPadding(5, 5, 5, 5);

  GwenPadding(int left, int top, int right, int bottom) : Top = top, Bottom=bottom, Right=right, Left=left
  {

  }

  bool Equals(GwenPadding other)
  {
    return other.Top == Top && other.Bottom == Bottom && other.Left == Left && other.Right == Right;
  }



  bool EqualsObj(Object obj)
  {
    if(obj==null) return false;
    if(this.hashCode == obj.hashCode) return true; 
    if(!obj is GwenPadding) return false;
    GwenPadding other = obj as GwenPadding;
    return Equals(other);
  }

  int GetHashCode()
  {
      int result = Top;
      result = (result*397) ^ Bottom;
      result = (result*397) ^ Left;
      result = (result*397) ^ Right;
      return result;
  }
}