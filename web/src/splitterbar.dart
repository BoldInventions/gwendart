part of gwendart;

class SplitterBar extends Dragger
{
  
  SplitterBar(GwenControlBase parent) : super(parent)
  {
    _Target = this;
    RestrictToParent = true;
  }
  
  void Render(GwenSkinBase skin)
  {
    if(ShouldDrawBackground)
    {
      skin.DrawButton(this, true, false, IsDisabled);
    }
  }
}