part of gwendart;

class TabStrip extends GwenControlBase
{
   GwenControlBase _TabDragControl;
   bool AllowReorder;
   
   bool get ShouldClip => false;
   
   
   TabStrip(GwenControlBase parent) : super(parent)
   {
      AllowReorder = false;
   }
   
   Pos get StripPosition => Dock;
   set StripPosition(Pos value)
   {
      Dock = value;
      if (Dock == Pos.Top)
        Padding = new GwenPadding(5, 0, 0, 0);
      if (Dock == Pos.Left)
        Padding = new GwenPadding(0, 5, 0, 0);
      if (Dock == Pos.Bottom)
        Padding = new GwenPadding(5, 0, 0, 0);
      if (Dock == Pos.Right)
        Padding = new GwenPadding(0, 5, 0, 0);
   }
   
   bool DragAndDrop_HandleDrop(GwenPackage p, int x, int y)
   {
     /* TODO: Implement Drag & Drop
     Point LocalPos = CanvasPosToLocal(new Point(x, y));

     TabButton button = DragAndDrop.SourceControl as TabButton;
     TabControl tabControl = Parent as TabControl;
     if (tabControl != null && button != null)
     {
       if (button.TabControl != tabControl)
       {
         // We've moved tab controls!
         tabControl.AddPage(button);
       }
     }

     Base droppedOn = GetControlAt(LocalPos.X, LocalPos.Y);
     if (droppedOn != null)
     {
       Point dropPos = droppedOn.CanvasPosToLocal(new Point(x, y));
       DragAndDrop.SourceControl.BringNextToControl(droppedOn, dropPos.X > droppedOn.Width/2);
     }
     else
     {
       DragAndDrop.SourceControl.BringToFront();
     }
     */
     return true;
   }

   bool DragAndDrop_CanAcceptGwenPackage(GwenPackage p)
   {
     if (!AllowReorder)
       return false;

     if (p.Name == "TabButtonMove")
       return true;

     return false;
   }

   /// <summary>
   /// Lays out the control's interior according to alignment, padding, dock etc.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Layout(GwenSkinBase skin)
   {
     Point largestTab = new Point(5, 5);

     int num = 0;
     for (var child in Children)
     {
       TabButton button = child as TabButton;
       if (null == button) continue;

       button.SizeToContents();


       int notFirst = num > 0 ? -1 : 0;
       int left=0;
       int top = 0;
       
       if (Dock == Pos.Top)
       {
         left = notFirst;
         button.Dock = Pos.Left;
       }

       if (Dock == Pos.Left)
       {
         top = notFirst;
         button.Dock = Pos.Top;
       }

       if (Dock == Pos.Right)
       {
         top = notFirst;
         button.Dock = Pos.Top;
       }

       if (Dock == Pos.Bottom)
       {
         left = notFirst;
         button.Dock = Pos.Left;
       }
       GwenMargin m = new GwenMargin(left, top, 0, 0);

       int largestTabx = max(largestTab.x, button.Width);
       int largestTaby = max(largestTab.y, button.Height);
       largestTab = new Point(largestTabx, largestTaby);
       button.Margin = m;
       num++;
     }

     if (Dock == Pos.Top || Dock == Pos.Bottom)
       SetSize(Width, largestTab.y);

     if (Dock == Pos.Left || Dock == Pos.Right)
       SetSize(largestTab.x, Height);

     super.Layout(skin);
   }

   void DragAndDrop_HoverEnter(GwenPackage p, int x, int y)
   {
     if (_TabDragControl != null)
     {
       throw new ArgumentError("ERROR! TabStrip::DragAndDrop_HoverEnter");
     }

     _TabDragControl = new Highlight(this);
     _TabDragControl.MouseInputEnabled = false;
     _TabDragControl.SetSize(3, Height);
   }

   void DragAndDrop_HoverLeave(GwenPackage p)
   {
     if (_TabDragControl != null)
     {
       RemoveChild(_TabDragControl, false); // [omeg] need to do that explicitely
       _TabDragControl.Dispose();
     }
     _TabDragControl = null;
   }

   void DragAndDrop_Hover(GwenPackage p, int x, int y)
   {
     Point localPos = CanvasPosToLocal(new Point(x, y));

     GwenControlBase droppedOn = GetControlAt(localPos.x, localPos.y);
     if (droppedOn != null && droppedOn != this)
     {
       Point dropPos = droppedOn.CanvasPosToLocal(new Point(x, y));
       _TabDragControl.SetBounds(0, 0, 3, Height);
       _TabDragControl.BringToFront();
       _TabDragControl.SetPosition(droppedOn.X - 1, 0);

       if (dropPos.x > droppedOn.Width/2)
       {
         _TabDragControl.MoveBy(droppedOn.Width - 1, 0);
       }
       _TabDragControl.Dock = Pos.None;
     }
     else
     {
       _TabDragControl.Dock = Pos.Left;
       _TabDragControl.BringToFront();
     }
   }
   
   
}