part of gwendart;

class DockedTabControl extends TabControl
{
   TabTitleBar _TitleBar;
   
   bool get TitleBarVisible => !_TitleBar.IsHidden;
   set TitleBarVisible (bool value)
   {
     _TitleBar.IsHidden = !value;
   }
   
   DockedTabControl(GwenControlBase parent) : super(parent)
   {
     Dock = Pos.Fill;
     _TitleBar = new TabTitleBar(this);
     _TitleBar.Dock = Pos.Top;
     _TitleBar.IsHidden = true;
   }
   
   /// <summary>
   /// Lays out the control's interior according to alignment, padding, dock etc.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Layout(GwenSkinBase skin)
   {
     _TabStrip.IsHidden = (TabCount <= 1);
     UpdateTitleBar();
     super.Layout(skin);
   }

   void UpdateTitleBar()
   {
     if (CurrentButton == null)
       return;

     _TitleBar.UpdateFromTab(CurrentButton);
   }

   void DragAndDrop_StartDragging(GwenPackage package, int x, int y)
   {
     super.DragAndDrop_StartDragging(package, x, y);

     IsHidden = true;
     // This hiding our parent thing is kind of lousy.
     Parent.IsHidden = true;
   }

   void DragAndDrop_EndDragging(bool success, int x, int y)
   {
     IsHidden = false;
     if (!success)
     {
       Parent.IsHidden = false;
     }
   }

   void MoveTabsTo(DockedTabControl target)
   {
     var children = _TabStrip.Children.toList(growable: false);
     for (GwenControlBase child in children)
     {
       TabButton button = child as TabButton;
       if (button == null)
         continue;
       target.AddPageButton(button);
     }
     Invalidate();
   }
}