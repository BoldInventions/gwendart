part of gwendart;

class MenuStrip extends Menu
{
   MenuStrip(GwenControlBase parent) : super(parent) 
   {
     SetBounds(0, 0, 200, 22);
     Dock = Pos.Top;
     m_InnerPanel.Padding = new GwenPadding(5, 0, 5, 0);
   }
   
   void Close() {}
   
   void RenderUnder(GwenSkinBase skin) {}
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawMenuStrip(this);
   }
   
   void Layout(GwenSkinBase skin)
   {
     //TODO: We don't want to do vertical sizing the same as Menu.  Do nothing for now.
   }
   
   bool get ShouldHoverOpenMenu => IsMenuOpen();
   
   void OnAddItem(MenuItem item)
   {
     item.Dock = Pos.Left;
     item.TextPadding = new GwenPadding(5, 0, 5, 0);
     item.SizeToContents();
     item.IsOnStrip = true;
     item.HoverEnter.add(new GwenMenuEventHandler(this));
   }
}