part of gwendart;

class GwenMouseEventArgs extends GwenEventArgs
{
   final int MouseX;
   final int MouseY;
   GwenMouseEventArgs(int mx, int my) : MouseX=mx, MouseY=my
       {
     
       }
}

class GwenControlCanvas extends GwenControlBase
{
   bool NeedsRedraw;
   double _scale;
   Color _backgroundColor;
   
   GwenControlBase _firstTab;
   GwenControlBase _nextTab;
   
   GwenEventHandlerList MouseMovedHandler = new GwenEventHandlerList();
   
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
     /* 15Jan2014 kds - if boundschanged called from constructor, it is not ready for laying out yet. */
     new Future(Redraw);
   }
   
   Color get BackgroundColor => _backgroundColor;
   set BackgroundColor( Color value) { _backgroundColor = value; }
   
   GwenControlCanvas(GwenSkinBase skin) : super()
   {
     SetSkin(skin);
     SetBounds(0, 0, 10000, 1000);

     Scale = 1.0;
     BackgroundColor = Color.White;
     ShouldDrawBackground = false;
   }
   
   void Redraw()
   {
     NeedsRedraw = true;
     super.Redraw();
     Skin.Renderer.notifyRedrawRequested();
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
     
     bool bDone=false;

     // Todo: Handle scaling here..
     //float fScale = 1.0f / Scale();

     InputHandler.OnMouseMoved(this, x, y, dx, dy);

     bDone = (InputHandler.HoveredControl == null);
     if(!bDone) bDone= (InputHandler.HoveredControl == this);
     if(!bDone) bDone= (InputHandler.HoveredControl.GetCanvas() != this);

     if(!bDone)
     {
       InputHandler.HoveredControl.InputMouseMoved(x, y, dx, dy);
       InputHandler.HoveredControl.UpdateCursor();
     }
     GwenMouseEventArgs mouseArgs = new GwenMouseEventArgs(x, y);
     MouseMovedHandler.Invoke(this, mouseArgs);
     
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
     if (key.value <= GwenKey.Invalid.value) return false;
     if (key.value >= GwenKey.Count.value) return false;

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