part of gwendart;


class GwenMenuEventHandler extends GwenEventHandler
{
  final Menu _menu;
  GwenMenuEventHandler(Menu menu) : _menu=menu
  {}
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
    _menu.OnHoverItem(control, args);
  }
}

class Menu extends ScrollControl
{
   bool _disableIconMargin;
   bool _deleteOnClose;
   
   bool get IsMenuComponent => true;

   bool get IconMarginDisabled => _disableIconMargin;
   set IconMarginDisabled(bool value) { _disableIconMargin = value; }
   
   bool get DeleteOnClose => _deleteOnClose;
   set DeleteOnClose(bool value) { _deleteOnClose = value; }
   
   
   bool get ShouldHoverOpenMenu => true;
   
   
   Menu(GwenControlBase parent) : super(parent)
   {
      SetBounds(0, 0, 10, 10);
      Padding = GwenPadding.Two;
      _disableIconMargin = false;
      _deleteOnClose = false;
      AutoHideBars = true;
      EnableScroll(false, true);
   }
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawMenu(this, IconMarginDisabled);
   }
   
   void RenderUnder(GwenSkinBase skin)
   {
     super.RenderUnder(skin);
     skin.DrawShadow(this);
   }
   
   void Open(Pos pos)
   {
     IsHidden = false;
     BringToFront();
     Point mouse = InputHandler.MousePosition;
     SetPosition(mouse.x, mouse.y);
   }
   
   void Layout(GwenSkinBase skin)
   {
     int childrenHeight=0;
     for(GwenControlBase child in Children)
     {
       if(null != child) childrenHeight += child.Height;
     }
     if( Y + childrenHeight > GetCanvas().Height)
     {
       childrenHeight = GetCanvas().Height - Y;
     }
     SetSize(Width, childrenHeight);
     super.Layout(skin);
   }
   
   MenuItem AddItem(String text, [String iconName="", String accelerator=""])
   {
      MenuItem item = new MenuItem(this);
      item.Padding = GwenPadding.Four;
      item.SetText(text);
      item.SetImage(iconName);
      item.SetAccelerator(accelerator);
      OnAddItem(item);
      return item;
   }
   
   void OnAddItem(MenuItem item)
   {
     item.TextPadding = new GwenPadding(IconMarginDisabled ? 0 : 24, 0, 16, 0);
     item.Dock = Pos.Top;
     item.SizeToContents();
     item.Alignment = new Pos(Pos.CenterV.value | Pos.Left.value);
     item.HoverEnter.add(new GwenMenuEventHandler(this));
     
     // Do this here - after Top Docking these values mean nothing in layout
     int w = item.Width + 10 + 32;
     if(w < Width) w = Width;
     SetSize(w, Height);
   }
   
   void CloseAll()
   {
     for(GwenControlBase child in Children)
     {
       if(null != child)
       {
         if(child is MenuItem)
         {
           MenuItem item = child;
           item.CloseMenu();
         }
       }
     }
   }
   
   bool IsMenuOpen()
   {
     for(GwenControlBase child in Children)
     {
       if(null != child)
       {
         if(child is MenuItem)
         {
           MenuItem item = child;
           return item.IsMenuOpen;
         }
       }
     }
     return false;
   }
   
   void OnHoverItem(GwenControlBase control, GwenEventArgs args)
   {
     if(!ShouldHoverOpenMenu) return;
     if(control is MenuItem)
     {
       MenuItem item = control;
       if(item.IsMenuOpen) return;
       CloseAll();
       item.OpenMenu();
     }
   }
   
   void Close()
   {
     IsHidden=true;
     if(DeleteOnClose)
     {
       DelayedDelete();
     }
   }
   
   void CloseMenus()
   {
     super.CloseMenus();
     CloseAll();
     Close();
   }
   
   void AddDivider()
   {
     MenuDivider divider = new MenuDivider(this);
     divider.Dock = Pos.Top;
     divider.Margin = new GwenMargin(IconMarginDisabled ? 0:24, 0, 4, 0);
   }
   
   
}