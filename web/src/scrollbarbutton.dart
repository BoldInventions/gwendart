part of gwendart;

class ScrollBarButton extends Button
{
  Pos _Direction;
  
  ScrollBarButton(GwenControlBase parent) : super(parent)
  {
    SetDirectionUp();
    
  }
  
  void SetDirectionUp()
  {
    _Direction = Pos.Top;
  }
  void SetDirectionDown()
  {
    _Direction = Pos.Bottom;
  }
  void SetDirectionLeft()
  {
    _Direction = Pos.Left;
  }
  void SetDirectionRight()
  {
    _Direction = Pos.Right;
  }
  
  void Render(GwenSkinBase skin) 
  {
    skin.DrawScrollButton(this, _Direction, IsDepressed, IsHovered, IsDisabled);
  }
}