part of gwendart;

class GwenControlCanvas extends GwenControlBase
{
   bool NeedsRedraw;
   double _scale;
   Color _backgroundColor;
   
   GwenControlBase _firstTab;
   GwenControlBase _nextTab;
   
   double get Scale => _scale;
   set Scale (double value)
   {
     if(_scale==value) return;
     _scale=value;
     if(Skin != null && Skin.Renderer != null)
     {
       Skin.Renderer.Scale = _scale;
     }
     OnScaleChanged();
     Redraw();
   }
   
   Color get BackgroundColor => _backgroundColor;
   set BackgroundColor( Color value) { _backgroundColor = value; }
   
   GwenControlCanvas(GwenSkinBase skin) : super()
   {
     SetBounds(0, 0, 10000, 1000);
     SetSkin(skin);
     Scale = 1.0;
     BackgroundColor = Color.White;
     ShouldDrawBackground = false;
   }
   
   void Redraw()
   {
     NeedsRedraw = true;
     super.Redraw();
   }
   
   // Children call parent.GetCanvas() until they get to the top level function.
   // seems useless.
   GwenControlCanvas GetCanvas() { return this; }
   
   void RenderCanvas()
   {
     DoThink();

     GwenRendererBase render = Skin.Renderer;

     render.begin();

     RecurseLayout(Skin);

     render.ClipRegion = Bounds;
     render.RenderOffset = new Point<int>(0,0);
     render.Scale = Scale;

     if (ShouldDrawBackground)
     {
       render.DrawColor = _backgroundColor;
       render.drawFilledRect(RenderBounds);
     }

     DoRender(Skin);

     // TODO: Implement drag and drop
     //DragAndDrop.RenderOverlay(this, Skin);

     // TODO: IMplement tooltips
     //Gwen.ToolTip.RenderToolTip(Skin);

     render.endClip();

     render.end();
   }
   
   void Render(GwenSkinBase skin)
   {
     //skin.Renderer.rnd = new Random(1);
     super.Render(skin);
     NeedsRedraw = false;
   }
   
   void OnBoundsChanged(Rectangle oldBounds)
   {
     super.OnBoundsChanged(oldBounds);
     InvalidateChildren(true);
   }
   
   void DoThink()
   {
     if (IsHidden)
       return;

     // TODO: Animation
     //Animation.GlobalThink();

     // Reset tabbing
     _nextTab = null;
     _firstTab = null;
     
     ProcessDelayedDeletes();

     // Check has focus etc..
     RecurseLayout(Skin);

     // If we didn't have a next tab, cycle to the start.
     if (_nextTab == null)
       _nextTab = _firstTab;

     InputHandler.OnCanvasThink(this);
   }
   
   void ProcessDelayedDeletes()
   {

   }
   
   void AddDelayedDelete(GwenControlBase control)
   {
       RemoveChild(control, false);
   }
   bool Input_MouseMoved(int x, int y, int dx, int dy)
   {
     if (IsHidden)
       return false;

     // Todo: Handle scaling here..
     //float fScale = 1.0f / Scale();

     InputHandler.OnMouseMoved(this, x, y, dx, dy);

     if (InputHandler.HoveredControl == null) return false;
     if (InputHandler.HoveredControl == this) return false;
     if (InputHandler.HoveredControl.GetCanvas() != this) return false;

     InputHandler.HoveredControl.InputMouseMoved(x, y, dx, dy);
     InputHandler.HoveredControl.UpdateCursor();
     
     // TODO: implment Drag and Drop
     //DragAndDrop.OnMouseMoved(InputHandler.HoveredControl, x, y);
     return true;
   }
   
   bool Input_MouseButton(int button, bool down)
   {
     if (IsHidden) return false;

     return InputHandler.OnMouseClicked(this, button, down);
   }
   
   
   bool Input_Key(GwenKey key, bool down)
   {
     if (IsHidden) return false;
     if (key.value <= GwenKey.Invalid) return false;
     if (key.value >= GwenKey.Count) return false;

     return InputHandler.OnKeyEvent(this, key, down);
   }
   
   
   bool Input_Character(String chr)
   {
     if (IsHidden) return false;

     if (GwenUtil.scharIsControl(chr)) return false;

     //Handle Accelerators
     if (InputHandler.HandleAccelerator(this, chr))
       return true;

     //Handle characters
     if (InputHandler.KeyboardFocus == null) return false;
     if (InputHandler.KeyboardFocus.GetCanvas() != this) return false;
     if (!InputHandler.KeyboardFocus.IsVisible) return false;
     if (InputHandler.IsControlDown) return false;

     return InputHandler.KeyboardFocus.InputChar(chr);
   }
   
   bool Input_MouseWheel(int val)
   {
     if (IsHidden) return false;
     if (InputHandler.HoveredControl == null) return false;
     if (InputHandler.HoveredControl == this) return false;
     if (InputHandler.HoveredControl.GetCanvas() != this) return false;

     return InputHandler.HoveredControl.InputMouseWheeled(val);
   }
}