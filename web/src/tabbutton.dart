part of gwendart;

class TabButton extends Button
{
   GwenControlBase Page;
   TabControl _Control;
   
   bool get IsActive => Page != null && Page.IsVisible;
   
   TabControl get MyTabControl => _Control;
   set MyTabControl ( TabControl value )
   {
     if(value == _Control) return;
     if(_Control != null)
     {
       _Control.OnLoseTab(this);
     }
     _Control = value;
   }
   
   bool get ShouldClip => false;
   
   TabButton(GwenControlBase parent) : super(parent)
   {
      DragAndDrop_SetPackage(true, "TabButtonMove");
      Alignment = new Pos(Pos.Top.value | Pos.Left.value);
      TextPadding = new GwenPadding(5, 3, 3, 3);
      Padding = GwenPadding.Two;
      KeyboardInputEnabled = true;
   }
   
   /* TODO: implmement Drag & Drop
   void DragAndDrop_StartDragging(DragDrop.Package package, int x, int y)
   {
     IsHidden = true;
   }
   */

   void DragAndDrop_EndDragging(bool success, int x, int y)
   {
     IsHidden = false;
     IsDepressed = false;
   }

   bool DragAndDrop_ShouldStartDrag()
   {
     return _Control.AllowReorder;
   }

   /// <summary>
   /// Renders the control using specified skin.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Render(GwenSkinBase skin)
   {
     skin.DrawTabButton(this, IsActive, _Control._TabStrip.Dock);
   }

   /// <summary>
   /// Handler for Down Arrow keyboard event.
   /// </summary>
   /// <param name="down">Indicates whether the key was pressed or released.</param>
   /// <returns>
   /// True if handled.
   /// </returns>
   bool OnKeyDown(bool down)
   {
     OnKeyRight(down);
     return true;
   }

   /// <summary>
   /// Handler for Up Arrow keyboard event.
   /// </summary>
   /// <param name="down">Indicates whether the key was pressed or released.</param>
   /// <returns>
   /// True if handled.
   /// </returns>
   bool OnKeyUp(bool down)
   {
     OnKeyLeft(down);
     return true;
   }

   /// <summary>
   /// Handler for Right Arrow keyboard event.
   /// </summary>
   /// <param name="down">Indicates whether the key was pressed or released.</param>
   /// <returns>
   /// True if handled.
   /// </returns>
   bool OnKeyRight(bool down)
   {
     if (down)
     {
       var count = Parent.Children.length;
       int me = Parent.Children.indexOf(this);
       if (me + 1 < count)
       {
         var nextTab = Parent.Children[me + 1];
         _Control.OnTabPressed(nextTab, GwenEventArgs.Empty);
         InputHandler.KeyboardFocus = nextTab;
       }
     }

     return true;
   }

   /// <summary>
   /// Handler for Left Arrow keyboard event.
   /// </summary>
   /// <param name="down">Indicates whether the key was pressed or released.</param>
   /// <returns>
   /// True if handled.
   /// </returns>
   bool OnKeyLeft(bool down)
   {
     if (down)
     {
       var count = Parent.Children.length;
       int me = Parent.Children.indexOf(this);
       if (me - 1 >= 0)
       {
         var prevTab = Parent.Children[me - 1];
         _Control.OnTabPressed(prevTab, GwenEventArgs.Empty);
         InputHandler.KeyboardFocus = prevTab;
       }
     }

     return true;
   }

   /// <summary>
   /// Updates control colors.
   /// </summary>
   void UpdateColors()
   {
     if (IsActive)
     {
       if (IsDisabled)
       {
         TextColor = Skin.SkinColors.m_Tab.m_Active.Disabled;
         return;
       }
       if (IsDepressed)
       {
         TextColor = Skin.SkinColors.m_Tab.m_Active.Down;
         return;
       }
       if (IsHovered)
       {
         TextColor = Skin.SkinColors.m_Tab.m_Active.Hover;
         return;
       }

       TextColor = Skin.SkinColors.m_Tab.m_Active.Normal;
     }

     if (IsDisabled)
     {
       TextColor = Skin.SkinColors.m_Tab.m_Inactive.Disabled;
       return;
     }
     if (IsDepressed)
     {
       TextColor = Skin.SkinColors.m_Tab.m_Inactive.Down;
       return;
     }
     if (IsHovered)
     {
       TextColor = Skin.SkinColors.m_Tab.m_Inactive.Hover;
       return;
     }

     TextColor = Skin.SkinColors.m_Tab.m_Inactive.Normal;
   }
}