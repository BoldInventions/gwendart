part of gwendart;
class Pos
{
  static const None = const Pos._(0);
      static const Left = const Pos._(1 << 1);
          static const Right = const Pos._(1 << 2);
              static const Top = const Pos._(1 << 3);
      static const Bottom = const Pos._(1 << 4);
     static const CenterV = const Pos._(1 << 5);
      static const CenterH = const Pos._(1 << 6);
      static const Fill = const Pos._(1 << 7);
      static const Center = const Pos._( (1 << 5) | (1 << 6));
      
      static get values => [None, Left, Right, Top, Bottom, CenterV, CenterH, Fill, Center];
      final int value;
      
      const Pos._(this.value);
      factory Pos(int value)
      {
        return new Pos._(value);
      }
}