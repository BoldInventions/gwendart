part of gwendart;

class WindowControl extends ResizableControl
{
   Dragger _titleBar;
   Label _title;
   CloseButton _closeButton;
   bool DeleteOnClose;
   Modal _modal;
   
   String get Title => _title.Text;
   set Title(String value)
   {
     _title.Text = value;
   }
   
   bool get IsClosable => !_closeButton.IsHidden;
   set IsClosable(bool value)
   {
     _closeButton.IsHidden = !value;
   }
   
   bool get IsHidden => super.IsHidden;
   set IsHidden(bool value)
   {
      if(!value) BringToFront();
      super.IsHidden= value;
   }
   
   void ToggleHidden() { IsHidden = !IsHidden; }
   
   
   WindowControl(GwenControlBase parent, [String title="", bool modal=false]) : super(parent)
   {
     _titleBar = new Dragger(this);
     _titleBar.Height = 24;
     _titleBar.Padding = GwenPadding.Zero;
     _titleBar.Margin = new GwenMargin(0, 0, 0, 4);
     _titleBar._Target = this;
     _titleBar.Dock = Pos.Top;
     
     _title = new Label(_titleBar);
     _title.Alignment = new Pos(Pos.Left.value | Pos.CenterV.value);
     _title.Text = title;
     _title.Dock = Pos.Fill;
     _title.Padding = new GwenPadding(8, 4, 0, 0);
     _title.TextColor = Skin.SkinColors.m_Window.TitleInactive;
     _title.AutoSizeToContents=false;
     
     _closeButton = new CloseButton(_titleBar, this);
     _closeButton.SetSize(24, 24);
     _closeButton.Dock = Pos.Right;
     _closeButton.Clicked;
     
     //Create a blank content control, dock it to the top - Should this be a ScrollControl?
     m_InnerPanel = new GwenControlBase(this);
     m_InnerPanel.Dock = Pos.Fill;
     GetResizer(8).Hide();
     BringToFront();
     IsTabable = false;
     Focus();
     MinimumSize = new Point(100, 40);
     ClampMovement = true;
     KeyboardInputEnabled = false;

     if (modal)
       MakeModal();
   }
   
   void DisableResizing()
   {
     super.DisableResizing();
     Padding = new GwenPadding(6, 0, 6, 0);
   }
   
   void Close()
   {
     CloseButtonPressed(this, GwenEventArgs.Empty);
   }
   
   void CloseButtonPressed(GwenControlBase contrl, GwenEventArgs args)
   {
      IsHidden = true;
      if(null != _modal)
      {
        _modal.DelayedDelete();
        _modal=null;
      }
      
      if(DeleteOnClose)
      {
        Parent.RemoveChild(this, true);
      }
   }
   
   void MakeModal([bool dim=false])
   {
     if(_modal!=null) return;
     _modal = new Modal(GetCanvas());
     Parent = _modal;
     if(dim)
     {
       _modal.ShouldDrawBackground=true;
     } else
     {
       _modal.ShouldDrawBackground=false;
     }
   }
   
   void Render(GwenSkinBase skin)
   {
     bool hasFocus = IsOnTop;
     if(hasFocus)
     {
       _title.TextColor = Skin.SkinColors.m_Window.TitleActive;
     } else
     {
       _title.TextColor = Skin.SkinColors.m_Window.TitleInactive;
     }
     skin.DrawWindow(this, _titleBar.Bottom, hasFocus);
   }
   
   void RenderUnder(GwenSkinBase skin)
   {
     super.RenderUnder(skin);
     skin.DrawShadow(this);
   }
   
   void Touch()
   {
     super.Touch();
     BringToFront();
   }
   
   void RenderFocus(GwenSkinBase skin)
   {
     
   }
   
}