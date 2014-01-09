part of gwendart;

class Button extends Label
{
  
   bool _depressed;
   bool IsToggle;
   bool _toggleStatus;
   bool _centerImage;
   ImagePanel _image;
   
   GwenEventHandlerList Pressed = new GwenEventHandlerList();
   GwenEventHandlerList Released = new GwenEventHandlerList();
   GwenEventHandlerList Toggled = new GwenEventHandlerList();
   GwenEventHandlerList ToggledOn = new GwenEventHandlerList();
   GwenEventHandlerList ToggledOff = new GwenEventHandlerList();
  
  
   bool get IsDepressed => _depressed;
   set IsDepressed(bool value)
   {
     if(_depressed == value) return;
     _depressed = value;
     Redraw();
   }
   
   bool get ToggleState => _toggleStatus;
   set ToggleState(bool value)
   {
     if(!IsToggle) return;
     if(_toggleStatus == value) return;
     _toggleStatus = value;
     Toggled.Invoke(this, GwenEventArgs.Empty);
     if(_toggleStatus)
     {
       ToggledOn.Invoke(this, GwenEventArgs.Empty);
     } else
     {
       ToggledOff.Invoke(this, GwenEventArgs.Empty);
     }
     Redraw();
   }
   
   
   Button(GwenControlBase parent) : IsToggle=false, _depressed = false, _toggleStatus=false, _centerImage=false, super(parent)
   {
     AutoSizeToContents=false;
     SetSize(100, 20);
     MouseInputEnabled=true;
     Alignment = Pos.Center;
     _centerImage=false;
     _image=null;
   }
   
   void Toggle()
   {
     ToggleState = !ToggleState;
   }
   
   
   void Press([GwenControlBase control = null])
   {
     OnClicked(0, 0);
   }
   
   void Render(GwenSkinBase skin)
   {
     if(ShouldDrawBackground)
     {
       bool drawDepressed = IsDepressed && IsHovered;
       if(IsToggle)
       {
         drawDepressed = drawDepressed || ToggleState;
       }
       bool bDrawHovered = IsHovered && ShouldDrawHover;
       skin.DrawButton(this, drawDepressed, bDrawHovered, IsDisabled);
     }
   }
   
   void OnMouseClickedLeft(int x, int y, bool down)
   {
     //base.OnMouseClickedLeft(x, y, down);
     if (down)
     {
       IsDepressed = true;
       InputHandler.MouseFocus = this;
       if (Pressed != null)
         Pressed.Invoke(this, GwenEventArgs.Empty);
     }
     else
     {
       if (IsHovered && _depressed)
       {
         OnClicked(x, y);
       }

       IsDepressed = false;
       InputHandler.MouseFocus = null;
       if (Released != null)
         Released.Invoke(this, GwenEventArgs.Empty);
     }

     Redraw();
   }

   /// <summary>
   /// Internal OnPressed implementation.
   /// </summary>
   void OnClicked(int x, int y)
   {
     if (IsToggle)
     {
       Toggle();
     }

     super.OnMouseClickedLeft(x, y, true);
   }
   
   /// <summary>
   /// Sets the button's image.
   /// </summary>
   /// <param name="textureName">Texture name. Null to remove.</param>
   /// <param name="center">Determines whether the image should be centered.</param>
   void SetImage(String textureName,[ bool center = false])
   {
     bool bNullOrEmpty = null == textureName;
     if(!bNullOrEmpty) bNullOrEmpty = textureName.length==0;
     if (bNullOrEmpty)
     {
       if (_image != null)
         _image.Dispose();
       _image = null;
       return;
     }

     if (_image == null)
     {
       _image = new ImagePanel(this);
     }

     _image.ImageName = textureName;
     _image.SizeToContents( );
     _image.SetPosition(max(Padding.Left, 2), 2);
     _centerImage = center;

     TextPadding = new GwenPadding(_image.Right + 2, TextPadding.Top, TextPadding.Right, TextPadding.Bottom);
   }

   /// <summary>
   /// Sizes to contents.
   /// </summary>
   void SizeToContents()
   {
     super.SizeToContents();
     if (_image != null)
     {
       int height = _image.Height + 4;
       if (Height < height)
       {
         Height = height;
       }
     }
   }

   /// <summary>
   /// Handler for Space keyboard event.
   /// </summary>
   /// <param name="down">Indicates whether the key was pressed or released.</param>
   /// <returns>
   /// True if handled.
   /// </returns>
   bool OnKeySpace(bool down)
   {
     return super.OnKeySpace(down);
     //if (down)
     //    OnClicked(0, 0);
     //return true;
   }

   /// <summary>
   /// Default accelerator handler.
   /// </summary>
   void OnAccelerator()
   {
     OnClicked(0, 0);
   }

   /// <summary>
   /// Lays out the control's interior according to alignment, padding, dock etc.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Layout(GwenSkinBase skin)
   {
     super.Layout(skin);
     if (_image != null)
     {
       Align.CenterVertically(_image);

       if (_centerImage)
         Align.CenterHorizontally(_image);
     }
   }

   /// <summary>
   /// Updates control colors.
   /// </summary>
   void UpdateColors()
   {
     if (IsDisabled)
     {
       TextColor = Skin.SkinColors.m_Button.Disabled;
       return;
     }

     if (IsDepressed || ToggleState)
     {
       TextColor = Skin.SkinColors.m_Button.Down;
       return;
     }

     if (IsHovered)
     {
       TextColor = Skin.SkinColors.m_Button.Hover;
       return;
     }

     TextColor = Skin.SkinColors.m_Button.Normal;
   }

   /// <summary>
   /// Handler invoked on mouse double click (left) event.
   /// </summary>
   /// <param name="x">X coordinate.</param>
   /// <param name="y">Y coordinate.</param>
   void OnMouseDoubleClickedLeft(int x, int y)
   {
     super.OnMouseDoubleClickedLeft(x, y);
     OnMouseClickedLeft(x, y, true);
   }
   
}