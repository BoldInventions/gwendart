part of gwendart;
/// <summary>
/// Key constants.
/// </summary>
class GwenKey
{
  static const Invalid = const GwenKey._(0);
  static const Return = const GwenKey._(1);
  static const Backspace = const GwenKey._(2);
  static const Delete = const GwenKey._(3);
  static const Left = const GwenKey._(4);
  static const Right = const GwenKey._(5);
  static const Shift = const GwenKey._(6);
  static const Tab = const GwenKey._(7);
  static const Space = const GwenKey._(8);
  static const Home = const GwenKey._(9);
  static const End = const GwenKey._(10);
  static const Control = const GwenKey._(11);
  static const Up = const GwenKey._(12);
  static const Down = const GwenKey._(13);
  static const Escape = const GwenKey._(14);
  static const Alt = const GwenKey._(15);

  static const Count = const GwenKey._(16);
  
  static get values => [Invalid, Return, Backspace, Delete, Left, Right, Shift, Tab, Space, Home, End, Control, Up, Down, Escape, Alt, Count];

  static GwenKey getKeyFromValue(int iKey)
  {
     for(GwenKey key in values)
     {
       if(key.value == iKey) return key;
     }
     return null;
  }
  final int value;
  const GwenKey._(this.value);
}