part of gwendart;
/// <summary>
/// Represents outer spacing.
/// </summary>
class GwenMargin
{
  final int Top;
  final int Bottom;
  final int Left;
  final int Right;

  // common values
  static GwenMargin Zero = new GwenMargin(0, 0, 0, 0);
  static GwenMargin One = new GwenMargin(1, 1, 1, 1);
  static GwenMargin Two = new GwenMargin(2, 2, 2, 2);
  static GwenMargin Three = new GwenMargin(3, 3, 3, 3);
  static GwenMargin Four = new GwenMargin(4, 4, 4, 4);
  static GwenMargin Five = new GwenMargin(5, 5, 5, 5);
  static GwenMargin Six = new GwenMargin(6, 6, 6, 6);
  static GwenMargin Seven = new GwenMargin(7, 7, 7, 7);
  static GwenMargin Eight = new GwenMargin(8, 8, 8, 8);
  static GwenMargin Nine = new GwenMargin(9, 9, 9, 9);
 static GwenMargin Ten = new GwenMargin(10, 10, 10, 10);

  GwenMargin(int left, int top, int right, int bottom) : Left=left, Right=right, Top=top, Bottom=bottom
  {

  }

  bool Equals(GwenMargin other)
  {
    return other.Top == Top && other.Bottom == Bottom && other.Left == Left && other.Right == Right;
  }


  bool EqualsObj(Object obj)
  {
    if(obj==null) return false;
    if(obj.hashCode == this.hashCode) return true; 
    return Equals(obj as GwenMargin);
  }

  int get hashCode
  {
      int result = Top;
      result = (result*397) ^ Bottom;
      result = (result*397) ^ Left;
      result = (result*397) ^ Right;
      return result;
  }
}