part of gwendart;

class _Active
{
   Single Normal;
   Single Checked;
}

class _Disabled
{
  Single Normal;
  Single Checked;
}

class _ScrollerButton
{
  List<Bordered> Normal;
  List<Bordered> Hover;
  List<Bordered> Down;
  List<Bordered> Disabled;
}

class _Panel
{
  Bordered Normal;
  Bordered Bright;
  Bordered Dark;
  Bordered Highlight;
}

class _Window
{
  Bordered Normal;
  Bordered Inactive;
  Single Close;
  Single Close_Hover;
  Single Close_Down;
  Single Close_Disabled;
}

class _CheckBox
{
  _Active m_Active;
  _Disabled m_Disabled;
}

class _RadioButton
{
  _Active m_Active;
  _Disabled m_Disabled;
}

class _TextBox
{
  Bordered Normal;
  Bordered Focus;
  Bordered Disabled;
}

class _Tree
{
  Bordered Background;
  Single Minus;
  Single Plus;
}

class _ProgressBar
{
  Bordered Back;
  Bordered Front;
}

class _Menu
{
   Single RightArrow;
   Single Check;
   Bordered Strip;
   Bordered Background;
   Bordered BackgroundWithMargin;
   Bordered Hover;
}

class _Scroller
{
  Bordered TrackV;
  Bordered TrackH;
  Bordered ButtonV_Normal;
  Bordered ButtonV_Hover;
  Bordered ButtonV_Down;
  Bordered ButtonV_Disabled;
  Bordered ButtonH_Normal;
  Bordered ButtonH_Hover;
  Bordered ButtonH_Down;
  Bordered ButtonH_Disabled;
  
  _ScrollerButton m_ScrollerButton;
}

class _H
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
}

class _V
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
}

class _Slider
{
  _H m_H;
  _V m_V;
}

class _Button
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
}
class _ComboBox
{
  Bordered Normal;
  Bordered Hover;
  Bordered Down;
  Bordered Disabled;
  _Button m_Button;
}

class _ListBox
{
  Bordered Background;
  Bordered Hovered;
  Bordered EvenLine;
  Bordered OddLine;
  Bordered EvenLineSelected;
  Bordered OddLineSelected;
}

class _Up
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
}

class _UpDown
{
  _Up m_Up;
  _Down m_Down;
}

class _Down
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
}
class _InputButton
{
  Bordered Normal;
  Bordered Hovered;
  Bordered Disabled;
  Bordered Pressed;
}
class _Input
{
  _InputButton m_InputButton;
  _ComboBox m_ComboBox;
  _Slider m_Slider;
  _ListBox m_ListBox;
  _UpDown m_UpDown;
}


class _Bottom
{
  Bordered Inactive;
  Bordered Active;
}
class _Top
{
  Bordered Inactive;
  Bordered Active;
}
class _Left
{
  Bordered Inactive;
  Bordered Active;
}
class _Right
{
  Bordered Inactive;
  Bordered Active;
}

class _Tab
{
  _Bottom m_Bottom;
  _Top m_Top;
  _Left m_Left;
  _Right m_Right;
  Bordered Control;
  Bordered HeaderBar;
}

class _CategoryList
{
  Bordered Outer;
  Bordered Inner;
  Bordered Header;
}

class SkinTextures
{
  Bordered StatusBar;
  Bordered Selection;
  Bordered Shadow;
  Bordered Tooltip;
  _Panel m_Panel;
  _Window m_Window;
  _CheckBox m_CheckBox;
  _RadioButton m_RadioButton;
  _TextBox m_TextBox;
  _Tree m_Tree;
  _ProgressBar m_ProgressBar;
  _Scroller m_Scroller;
  _Menu m_Menu;
  _Input m_Input;
  _Tab m_Tab;
  _CategoryList m_CategoryList;
}

class GwenTexturedSkinBase extends GwenSkinBase
{
  SkinTextures MySkinTextures;
  GwenTexture _Texture;
  
  GwenTexturedSkinBase(GwenRendererBase renderer, String textureName) : super(renderer)
  {
    _Texture = new GwenTexture(renderer);
    _Texture.load(textureName);
  }
  
  void InitializeColors()
  {
    SkinColors.m_Window.TitleActive   = Renderer.pixelColor(_Texture, 4 + 8*0, 508, Color.Red);
    SkinColors.m_Window.TitleInactive = Renderer.pixelColor(_Texture, 4 + 8*1, 508, Color.Yellow);

    SkinColors.m_Button.Normal   = Renderer.pixelColor(_Texture, 4 + 8*2, 508, Color.Yellow);
    SkinColors.m_Button.Hover    = Renderer.pixelColor(_Texture, 4 + 8*3, 508, Color.Yellow);
    SkinColors.m_Button.Down     = Renderer.pixelColor(_Texture, 4 + 8*2, 500, Color.Yellow);
    SkinColors.m_Button.Disabled = Renderer.pixelColor(_Texture, 4 + 8*3, 500, Color.Yellow);

    SkinColors.m_Tab.m_Active.Normal     = Renderer.pixelColor(_Texture, 4 + 8*4, 508, Color.Yellow);
    SkinColors.m_Tab.m_Active.Hover      = Renderer.pixelColor(_Texture, 4 + 8*5, 508, Color.Yellow);
    SkinColors.m_Tab.m_Active.Down       = Renderer.pixelColor(_Texture, 4 + 8*4, 500, Color.Yellow);
    SkinColors.m_Tab.m_Active.Disabled   = Renderer.pixelColor(_Texture, 4 + 8*5, 500, Color.Yellow);
    SkinColors.m_Tab.m_Inactive.Normal   = Renderer.pixelColor(_Texture, 4 + 8*6, 508, Color.Yellow);
    SkinColors.m_Tab.m_Inactive.Hover    = Renderer.pixelColor(_Texture, 4 + 8*7, 508, Color.Yellow);
    SkinColors.m_Tab.m_Inactive.Down     = Renderer.pixelColor(_Texture, 4 + 8*6, 500, Color.Yellow);
    SkinColors.m_Tab.m_Inactive.Disabled = Renderer.pixelColor(_Texture, 4 + 8*7, 500, Color.Yellow);

    SkinColors.m_Label.Default   = Renderer.pixelColor(_Texture, 4 + 8*8, 508, Color.Yellow);
    SkinColors.m_Label.Bright    = Renderer.pixelColor(_Texture, 4 + 8*9, 508, Color.Yellow);
    SkinColors.m_Label.Dark      = Renderer.pixelColor(_Texture, 4 + 8*8, 500, Color.Yellow);
    SkinColors.m_Label.Highlight = Renderer.pixelColor(_Texture, 4 + 8*9, 500, Color.Yellow);

    SkinColors.m_Tree.Lines    = Renderer.pixelColor(_Texture, 4 + 8*10, 508, Color.Yellow);
    SkinColors.m_Tree.Normal   = Renderer.pixelColor(_Texture, 4 + 8*11, 508, Color.Yellow);
    SkinColors.m_Tree.Hover    = Renderer.pixelColor(_Texture, 4 + 8*10, 500, Color.Yellow);
    SkinColors.m_Tree.Selected = Renderer.pixelColor(_Texture, 4 + 8*11, 500, Color.Yellow);

    SkinColors.m_Properties.Line_Normal     = Renderer.pixelColor(_Texture, 4 + 8*12, 508, Color.Yellow);
    SkinColors.m_Properties.Line_Selected   = Renderer.pixelColor(_Texture, 4 + 8*13, 508, Color.Yellow);
    SkinColors.m_Properties.Line_Hover      = Renderer.pixelColor(_Texture, 4 + 8*12, 500, Color.Yellow);
    SkinColors.m_Properties.Title           = Renderer.pixelColor(_Texture, 4 + 8*13, 500, Color.Yellow);
    SkinColors.m_Properties.Column_Normal   = Renderer.pixelColor(_Texture, 4 + 8*14, 508, Color.Yellow);
    SkinColors.m_Properties.Column_Selected = Renderer.pixelColor(_Texture, 4 + 8*15, 508, Color.Yellow);
    SkinColors.m_Properties.Column_Hover    = Renderer.pixelColor(_Texture, 4 + 8*14, 500, Color.Yellow);
    SkinColors.m_Properties.Border          = Renderer.pixelColor(_Texture, 4 + 8*15, 500, Color.Yellow);
    SkinColors.m_Properties.Label_Normal    = Renderer.pixelColor(_Texture, 4 + 8*16, 508, Color.Yellow);
    SkinColors.m_Properties.Label_Selected  = Renderer.pixelColor(_Texture, 4 + 8*17, 508, Color.Yellow);
    SkinColors.m_Properties.Label_Hover     = Renderer.pixelColor(_Texture, 4 + 8*16, 500, Color.Yellow);

    SkinColors.m_ModalBackground = Renderer.pixelColor(_Texture, 4 + 8*18, 508, Color.Yellow);
    
    SkinColors.m_TooltipText = Renderer.pixelColor(_Texture, 4 + 8*19, 508, Color.Yellow);

    SkinColors.m_Category.Header                  = Renderer.pixelColor(_Texture, 4 + 8*18, 500, Color.Yellow);
    SkinColors.m_Category.Header_Closed           = Renderer.pixelColor(_Texture, 4 + 8*19, 500, Color.Yellow);
    SkinColors.m_Category.m_Line.Text               = Renderer.pixelColor(_Texture, 4 + 8*20, 508, Color.Yellow);
    SkinColors.m_Category.m_Line.Text_Hover         = Renderer.pixelColor(_Texture, 4 + 8*21, 508, Color.Yellow);
    SkinColors.m_Category.m_Line.Text_Selected      = Renderer.pixelColor(_Texture, 4 + 8*20, 500, Color.Yellow);
    SkinColors.m_Category.m_Line.Button             = Renderer.pixelColor(_Texture, 4 + 8*21, 500, Color.Yellow);
    SkinColors.m_Category.m_Line.Button_Hover       = Renderer.pixelColor(_Texture, 4 + 8*22, 508, Color.Yellow);
    SkinColors.m_Category.m_Line.Button_Selected    = Renderer.pixelColor(_Texture, 4 + 8*23, 508, Color.Yellow);
    SkinColors.m_Category.m_LineAlt.Text            = Renderer.pixelColor(_Texture, 4 + 8*22, 500, Color.Yellow);
    SkinColors.m_Category.m_LineAlt.Text_Hover      = Renderer.pixelColor(_Texture, 4 + 8*23, 500, Color.Yellow);
    SkinColors.m_Category.m_LineAlt.Text_Selected   = Renderer.pixelColor(_Texture, 4 + 8*24, 508, Color.Yellow);
    SkinColors.m_Category.m_LineAlt.Button          = Renderer.pixelColor(_Texture, 4 + 8*25, 508, Color.Yellow);
    SkinColors.m_Category.m_LineAlt.Button_Hover    = Renderer.pixelColor(_Texture, 4 + 8*24, 500, Color.Yellow);
    SkinColors.m_Category.m_LineAlt.Button_Selected = Renderer.pixelColor(_Texture, 4 + 8*25, 500, Color.Yellow);
  }

  void InitializeTextures()
  {
    MySkinTextures.Shadow    = new Bordered(_Texture, 448, 0, 31, 31, GwenMargin.Eight);
    MySkinTextures.Tooltip   = new Bordered(_Texture, 128, 320, 127, 31, GwenMargin.Eight);
    MySkinTextures.StatusBar = new Bordered(_Texture, 128, 288, 127, 31, GwenMargin.Eight);
    MySkinTextures.Selection = new Bordered(_Texture, 384, 32, 31, 31, GwenMargin.Four);

    MySkinTextures.m_Panel.Normal    = new Bordered(_Texture, 256, 0, 63, 63, new GwenMargin(16, 16, 16, 16));
    MySkinTextures.m_Panel.Bright    = new Bordered(_Texture, 256 + 64, 0, 63, 63, new GwenMargin(16, 16, 16, 16));
    MySkinTextures.m_Panel.Dark      = new Bordered(_Texture, 256, 64, 63, 63, new GwenMargin(16, 16, 16, 16));
    MySkinTextures.m_Panel.Highlight = new Bordered(_Texture, 256 + 64, 64, 63, 63, new GwenMargin(16, 16, 16, 16));

    MySkinTextures.m_Window.Normal   = new Bordered(_Texture, 0, 0, 127, 127, new GwenMargin(8, 32, 8, 8));
    MySkinTextures.m_Window.Inactive = new Bordered(_Texture, 128, 0, 127, 127, new GwenMargin(8, 32, 8, 8));

    MySkinTextures.m_CheckBox.m_Active.Checked  = new Single(_Texture, 448, 32, 15, 15);
    MySkinTextures.m_CheckBox.m_Active.Normal   = new Single(_Texture, 464, 32, 15, 15);
    MySkinTextures.m_CheckBox.m_Disabled.Normal = new Single(_Texture, 448, 48, 15, 15);
    MySkinTextures.m_CheckBox.m_Disabled.Normal = new Single(_Texture, 464, 48, 15, 15);

    MySkinTextures.m_RadioButton.m_Active.Checked  = new Single(_Texture, 448, 64, 15, 15);
    MySkinTextures.m_RadioButton.m_Active.Normal   = new Single(_Texture, 464, 64, 15, 15);
    MySkinTextures.m_RadioButton.m_Disabled.Normal = new Single(_Texture, 448, 80, 15, 15);
    MySkinTextures.m_RadioButton.m_Disabled.Normal = new Single(_Texture, 464, 80, 15, 15);

    MySkinTextures.m_TextBox.Normal   = new Bordered(_Texture, 0, 150, 127, 21, GwenMargin.Four);
    MySkinTextures.m_TextBox.Focus    = new Bordered(_Texture, 0, 172, 127, 21, GwenMargin.Four);
    MySkinTextures.m_TextBox.Disabled = new Bordered(_Texture, 0, 193, 127, 21, GwenMargin.Four);

    MySkinTextures.m_Menu.Strip                = new Bordered(_Texture, 0, 128, 127, 21, GwenMargin.One);
    MySkinTextures.m_Menu.BackgroundWithMargin = new Bordered(_Texture, 128, 128, 127, 63, new GwenMargin(24, 8, 8, 8));
    MySkinTextures.m_Menu.Background           = new Bordered(_Texture, 128, 192, 127, 63, GwenMargin.Eight);
    MySkinTextures.m_Menu.Hover                = new Bordered(_Texture, 128, 256, 127, 31, GwenMargin.Eight);
    MySkinTextures.m_Menu.RightArrow           = new Single(_Texture, 464, 112, 15, 15);
    MySkinTextures.m_Menu.Check                = new Single(_Texture, 448, 112, 15, 15);

    MySkinTextures.m_Tab.Control         = new Bordered(_Texture, 0, 256, 127, 127, GwenMargin.Eight);
    MySkinTextures.m_Tab.m_Bottom.Active   = new Bordered(_Texture, 0, 416, 63, 31, GwenMargin.Eight);
    MySkinTextures.m_Tab.m_Bottom.Inactive = new Bordered(_Texture, 0 + 128, 416, 63, 31, GwenMargin.Eight);
    MySkinTextures.m_Tab.m_Top.Active      = new Bordered(_Texture, 0, 384, 63, 31, GwenMargin.Eight);
    MySkinTextures.m_Tab.m_Top.Inactive    = new Bordered(_Texture, 0 + 128, 384, 63, 31, GwenMargin.Eight);
    MySkinTextures.m_Tab.m_Left.Active     = new Bordered(_Texture, 64, 384, 31, 63, GwenMargin.Eight);
    MySkinTextures.m_Tab.m_Left.Inactive   = new Bordered(_Texture, 64 + 128, 384, 31, 63, GwenMargin.Eight);
    MySkinTextures.m_Tab.m_Right.Active    = new Bordered(_Texture, 96, 384, 31, 63, GwenMargin.Eight);
    MySkinTextures.m_Tab.m_Right.Inactive  = new Bordered(_Texture, 96 + 128, 384, 31, 63, GwenMargin.Eight);
    MySkinTextures.m_Tab.HeaderBar       = new Bordered(_Texture, 128, 352, 127, 31, GwenMargin.Four);

    MySkinTextures.m_Window.Close       = new Single(_Texture, 0, 224, 24, 24);
    MySkinTextures.m_Window.Close_Hover = new Single(_Texture, 32, 224, 24, 24);
    MySkinTextures.m_Window.Close_Hover = new Single(_Texture, 64, 224, 24, 24);
    MySkinTextures.m_Window.Close_Hover = new Single(_Texture, 96, 224, 24, 24);

    MySkinTextures.m_Scroller.TrackV           = new Bordered(_Texture, 384, 208, 15, 127, GwenMargin.Four);
    MySkinTextures.m_Scroller.ButtonV_Normal   = new Bordered(_Texture, 384 + 16, 208, 15, 127, GwenMargin.Four);
    MySkinTextures.m_Scroller.ButtonV_Hover    = new Bordered(_Texture, 384 + 32, 208, 15, 127, GwenMargin.Four);
    MySkinTextures.m_Scroller.ButtonV_Down     = new Bordered(_Texture, 384 + 48, 208, 15, 127, GwenMargin.Four);
    MySkinTextures.m_Scroller.ButtonV_Disabled = new Bordered(_Texture, 384 + 64, 208, 15, 127, GwenMargin.Four);
    MySkinTextures.m_Scroller.TrackH           = new Bordered(_Texture, 384, 128, 127, 15, GwenMargin.Four);
    MySkinTextures.m_Scroller.ButtonH_Normal   = new Bordered(_Texture, 384, 128 + 16, 127, 15, GwenMargin.Four);
    MySkinTextures.m_Scroller.ButtonH_Hover    = new Bordered(_Texture, 384, 128 + 32, 127, 15, GwenMargin.Four);
    MySkinTextures.m_Scroller.ButtonH_Down     = new Bordered(_Texture, 384, 128 + 48, 127, 15, GwenMargin.Four);
    MySkinTextures.m_Scroller.ButtonH_Disabled = new Bordered(_Texture, 384, 128 + 64, 127, 15, GwenMargin.Four);

    MySkinTextures.m_Scroller.m_ScrollerButton.Normal   = new List<Bordered>();
    MySkinTextures.m_Scroller.m_ScrollerButton.Disabled = new List<Bordered>();
    MySkinTextures.m_Scroller.m_ScrollerButton.Hover    = new List<Bordered>();
    MySkinTextures.m_Scroller.m_ScrollerButton.Down     = new List<Bordered>();

    MySkinTextures.m_Tree.Background = new Bordered(_Texture, 256, 128, 127, 127, new GwenMargin(16, 16, 16, 16));
    MySkinTextures.m_Tree.Plus       = new Single(_Texture, 448, 96, 15, 15);
    MySkinTextures.m_Tree.Minus      = new Single(_Texture, 464, 96, 15, 15);

    MySkinTextures.m_Input.m_InputButton.Normal   = new Bordered(_Texture, 480, 0, 31, 31, GwenMargin.Eight);
    MySkinTextures.m_Input.m_InputButton.Hovered  = new Bordered(_Texture, 480, 32, 31, 31, GwenMargin.Eight);
    MySkinTextures.m_Input.m_InputButton.Disabled = new Bordered(_Texture, 480, 64, 31, 31, GwenMargin.Eight);
    MySkinTextures.m_Input.m_InputButton.Pressed  = new Bordered(_Texture, 480, 96, 31, 31, GwenMargin.Eight);

    for (int i = 0; i < 4; i++)
    {
      MySkinTextures.m_Scroller.m_ScrollerButton.Normal[i]   = new Bordered(_Texture, 464 + 0, 208 + i * 16, 15, 15, GwenMargin.Two);
      MySkinTextures.m_Scroller.m_ScrollerButton.Hover[i]    = new Bordered(_Texture, 480, 208 + i * 16, 15, 15, GwenMargin.Two);
      MySkinTextures.m_Scroller.m_ScrollerButton.Down[i]     = new Bordered(_Texture, 464, 272 + i * 16, 15, 15, GwenMargin.Two);
      MySkinTextures.m_Scroller.m_ScrollerButton.Disabled[i] = new Bordered(_Texture, 480 + 48, 272 + i * 16, 15, 15, GwenMargin.Two);
    }

    MySkinTextures.m_Input.m_ListBox.Background       = new Bordered(_Texture, 256, 256, 63, 127, GwenMargin.Eight);
    MySkinTextures.m_Input.m_ListBox.Hovered          = new Bordered(_Texture, 320, 320, 31, 31, GwenMargin.Eight);
    MySkinTextures.m_Input.m_ListBox.EvenLine         = new Bordered(_Texture, 352, 256, 31, 31, GwenMargin.Eight);
    MySkinTextures.m_Input.m_ListBox.OddLine          = new Bordered(_Texture, 352, 288, 31, 31, GwenMargin.Eight);
    MySkinTextures.m_Input.m_ListBox.EvenLineSelected = new Bordered(_Texture, 320, 270, 31, 31, GwenMargin.Eight);
    MySkinTextures.m_Input.m_ListBox.OddLineSelected  = new Bordered(_Texture, 320, 288, 31, 31, GwenMargin.Eight);

    MySkinTextures.m_Input.m_ComboBox.Normal   = new Bordered(_Texture, 384, 336, 127, 31, new GwenMargin(8, 8, 32, 8));
    MySkinTextures.m_Input.m_ComboBox.Hover    = new Bordered(_Texture, 384, 336 + 32, 127, 31, new GwenMargin(8, 8, 32, 8));
    MySkinTextures.m_Input.m_ComboBox.Down     = new Bordered(_Texture, 384, 336 + 64, 127, 31, new GwenMargin(8, 8, 32, 8));
    MySkinTextures.m_Input.m_ComboBox.Disabled = new Bordered(_Texture, 384, 336 + 96, 127, 31, new GwenMargin(8, 8, 32, 8));

    MySkinTextures.m_Input.m_ComboBox.m_Button.Normal   = new Single(_Texture, 496, 272, 15, 15);
    MySkinTextures.m_Input.m_ComboBox.m_Button.Hover    = new Single(_Texture, 496, 272 + 16, 15, 15);
    MySkinTextures.m_Input.m_ComboBox.m_Button.Down     = new Single(_Texture, 496, 272 + 32, 15, 15);
    MySkinTextures.m_Input.m_ComboBox.m_Button.Disabled = new Single(_Texture, 496, 272 + 48, 15, 15);

    MySkinTextures.m_Input.m_UpDown.m_Up.Normal     = new Single(_Texture, 384, 112, 7, 7);
    MySkinTextures.m_Input.m_UpDown.m_Up.Hover      = new Single(_Texture, 384 + 8, 112, 7, 7);
    MySkinTextures.m_Input.m_UpDown.m_Up.Down       = new Single(_Texture, 384 + 16, 112, 7, 7);
    MySkinTextures.m_Input.m_UpDown.m_Up.Disabled   = new Single(_Texture, 384 + 24, 112, 7, 7);
    MySkinTextures.m_Input.m_UpDown.m_Down.Normal   = new Single(_Texture, 384, 120, 7, 7);
    MySkinTextures.m_Input.m_UpDown.m_Down.Hover    = new Single(_Texture, 384 + 8, 120, 7, 7);
    MySkinTextures.m_Input.m_UpDown.m_Down.Down     = new Single(_Texture, 384 + 16, 120, 7, 7);
    MySkinTextures.m_Input.m_UpDown.m_Down.Disabled = new Single(_Texture, 384 + 24, 120, 7, 7);

    MySkinTextures.m_ProgressBar.Back  = new Bordered(_Texture, 384, 0, 31, 31, GwenMargin.Eight);
    MySkinTextures.m_ProgressBar.Front = new Bordered(_Texture, 384 + 32, 0, 31, 31, GwenMargin.Eight);

    MySkinTextures.m_Input.m_Slider.m_H.Normal   = new Single(_Texture, 416, 32, 15, 15);
    MySkinTextures.m_Input.m_Slider.m_H.Hover    = new Single(_Texture, 416, 32 + 16, 15, 15);
    MySkinTextures.m_Input.m_Slider.m_H.Down     = new Single(_Texture, 416, 32 + 32, 15, 15);
    MySkinTextures.m_Input.m_Slider.m_H.Disabled = new Single(_Texture, 416, 32 + 48, 15, 15);

    MySkinTextures.m_Input.m_Slider.m_V.Normal   = new Single(_Texture, 416 + 16, 32, 15, 15);
    MySkinTextures.m_Input.m_Slider.m_V.Hover    = new Single(_Texture, 416 + 16, 32 + 16, 15, 15);
    MySkinTextures.m_Input.m_Slider.m_V.Down     = new Single(_Texture, 416 + 16, 32 + 32, 15, 15);
    MySkinTextures.m_Input.m_Slider.m_V.Disabled = new Single(_Texture, 416 + 16, 32 + 48, 15, 15);

    MySkinTextures.m_CategoryList.Outer  = new Bordered(_Texture, 256, 384, 63, 63, GwenMargin.Eight);
    MySkinTextures.m_CategoryList.Inner  = new Bordered(_Texture, 256 + 64, 384, 63, 63, new GwenMargin(8, 21, 8, 8));
    MySkinTextures.m_CategoryList.Header = new Bordered(_Texture, 320, 352, 63, 31, GwenMargin.Eight);
  }
  
  void DrawButton(GwenControlBase control, bool depressed, bool hovered, bool disabled)
  {
    if (disabled)
    {
      MySkinTextures.m_Input.m_InputButton.Disabled.Draw(Renderer, control.RenderBounds);
      return;
    }
    if (depressed)
    {
      MySkinTextures.m_Input.m_InputButton.Pressed.Draw(Renderer, control.RenderBounds);
      return;
    }
    if (hovered)
    {
      MySkinTextures.m_Input.m_InputButton.Hovered.Draw(Renderer, control.RenderBounds);
      return;
    }
    MySkinTextures.m_Input.m_InputButton.Normal.Draw(Renderer, control.RenderBounds);
  }

  void DrawMenuRightArrow(GwenControlBase control)
  {
    MySkinTextures.m_Menu.RightArrow.Draw(Renderer, control.RenderBounds);
  }

  void DrawMenuItem(GwenControlBase control, bool submenuOpen, bool isChecked)
  {
    if (submenuOpen || control.IsHovered)
      MySkinTextures.m_Menu.Hover.Draw(Renderer, control.RenderBounds);

    if (isChecked)
      MySkinTextures.m_Menu.Check.Draw(Renderer, new Rectangle(control.RenderBounds.left + 4, control.RenderBounds.top + 3, 15, 15));
  }

  void DrawMenuStrip(GwenControlBase control)
  {
    MySkinTextures.m_Menu.Strip.Draw(Renderer, control.RenderBounds);
  }

  void DrawMenu(GwenControlBase control, bool paddingDisabled)
  {
    if (!paddingDisabled)
    {
      MySkinTextures.m_Menu.BackgroundWithMargin.Draw(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Menu.Background.Draw(Renderer, control.RenderBounds);
  }

  void DrawShadow(GwenControlBase control)
  {
    Rectangle r = control.RenderBounds;

    MySkinTextures.Shadow.Draw(Renderer, new Rectangle(r.left-4, r.top-4, r.width+10, r.height+10));
  }

  void DrawRadioButton(GwenControlBase control, bool selected, bool depressed)
  {
    if (selected)
    {
      if (control.IsDisabled)
        MySkinTextures.m_RadioButton.m_Disabled.Checked.Draw(Renderer, control.RenderBounds);
      else
        MySkinTextures.m_RadioButton.m_Active.Checked.Draw(Renderer, control.RenderBounds);
    }
    else
    {
      if (control.IsDisabled)
        MySkinTextures.m_RadioButton.m_Disabled.Normal.Draw(Renderer, control.RenderBounds);
      else
        MySkinTextures.m_RadioButton.m_Active.Normal.Draw(Renderer, control.RenderBounds);
    }
  }

  void DrawCheckBox(GwenControlBase control, bool selected, bool depressed)
  {
    if (selected)
    {
      if (control.IsDisabled)
        MySkinTextures.m_CheckBox.m_Disabled.Checked.Draw(Renderer, control.RenderBounds);
      else
        MySkinTextures.m_CheckBox.m_Active.Checked.Draw(Renderer, control.RenderBounds);
    }
    else
    {
      if (control.IsDisabled)
        MySkinTextures.m_CheckBox.m_Disabled.Normal.Draw(Renderer, control.RenderBounds);
      else
        MySkinTextures.m_CheckBox.m_Active.Normal.Draw(Renderer, control.RenderBounds);
    }
  }

  void DrawGroupBox(GwenControlBase control, int textStart, int textHeight, int textWidth)
  {
    Rectangle rect1 = control.RenderBounds;

    int top = rect1.top + (textHeight * 0.5).toInt();
    int height = rect1.height - (textHeight * 0.5).toInt();
    
    Rectangle rect = new Rectangle(rect1.left, top, rect1.width, height);

    Color m_colDarker = new Color.argb(50, 0, 50, 60);
    Color m_colLighter = new Color.argb(150, 255, 255, 255);

    Renderer.DrawColor = m_colLighter;

    Renderer.drawFilledRect(new Rectangle(rect.left + 1, rect.top + 1, textStart - 3, 1));
    Renderer.drawFilledRect(new Rectangle(rect.left + 1 + textStart + textWidth, rect.top + 1, rect.width - textStart + textWidth - 2, 1));
    Renderer.drawFilledRect(new Rectangle(rect.left + 1, (rect.top + rect.height) - 1, rect.left + rect.width - 2, 1));

    Renderer.drawFilledRect(new Rectangle(rect.left + 1, rect.top + 1, 1, rect.height));
    Renderer.drawFilledRect(new Rectangle((rect.left + rect.width) - 2, rect.top + 1, 1, rect.height - 1));

    Renderer.DrawColor = m_colDarker;

    Renderer.drawFilledRect(new Rectangle(rect.left + 1, rect.top, textStart - 3, 1));
    Renderer.drawFilledRect(new Rectangle(rect.left + 1 + textStart + textWidth, rect.top, rect.width - textStart - textWidth - 2, 1));
    Renderer.drawFilledRect(new Rectangle(rect.left + 1, (rect.top + rect.height) - 1, rect.left + rect.width - 2, 1));

    Renderer.drawFilledRect(new Rectangle(rect.left, rect.top + 1, 1, rect.height - 1));
    Renderer.drawFilledRect(new Rectangle((rect.left + rect.width) - 1, rect.top + 1, 1, rect.height - 1));
  }

  void DrawTextBox(GwenControlBase control)
  {
    if (control.IsDisabled)
    {
      MySkinTextures.m_TextBox.Disabled.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (control.HasFocus)
      MySkinTextures.m_TextBox.Focus.Draw(Renderer, control.RenderBounds);
    else
      MySkinTextures.m_TextBox.Normal.Draw(Renderer, control.RenderBounds);
  }

  void DrawTabButton(GwenControlBase control, bool active, Pos dir)
  {
    if (active)
    {
      DrawActiveTabButton(control, dir);
      return;
    }

    if (dir == Pos.Top)
    {
      MySkinTextures.m_Tab.m_Top.Inactive.Draw(Renderer, control.RenderBounds);
      return;
    }
    if (dir == Pos.Left)
    {
      MySkinTextures.m_Tab.m_Left.Inactive.Draw(Renderer, control.RenderBounds);
      return;
    }
    if (dir == Pos.Bottom)
    {
      MySkinTextures.m_Tab.m_Bottom.Inactive.Draw(Renderer, control.RenderBounds);
      return;
    }
    if (dir == Pos.Right)
    {
      MySkinTextures.m_Tab.m_Right.Inactive.Draw(Renderer, control.RenderBounds);
      return;
    }
  }

  void DrawActiveTabButton(GwenControlBase control, Pos dir)
  {
    if (dir == Pos.Top)
    {
      MySkinTextures.m_Tab.m_Top.Active.Draw(Renderer, control.addToRenderBounds(new Rectangle(0, 0, 0, 8)));
      return;
    }
    if (dir == Pos.Left)
    {
      MySkinTextures.m_Tab.m_Left.Active.Draw(Renderer, control.addToRenderBounds(new Rectangle(0, 0, 8, 0)));
      return;
    }
    if (dir == Pos.Bottom)
    {
      MySkinTextures.m_Tab.m_Bottom.Active.Draw(Renderer, control.addToRenderBounds(new Rectangle(0, -8, 0, 8)));
      return;
    }
    if (dir == Pos.Right)
    {
      MySkinTextures.m_Tab.m_Right.Active.Draw(Renderer, control.addToRenderBounds(new Rectangle(-8, 0, 8, 0)));
      return;
    }
  }

  void DrawTabControl(GwenControlBase control)
  {
    MySkinTextures.m_Tab.Control.Draw(Renderer, control.RenderBounds);
  }

  void DrawTabTitleBar(GwenControlBase control)
  {
    MySkinTextures.m_Tab.HeaderBar.Draw(Renderer, control.RenderBounds);
  }

  void DrawWindow(GwenControlBase control, int topHeight, bool inFocus)
  {
    if (inFocus) 
      MySkinTextures.m_Window.Normal.Draw(Renderer, control.RenderBounds);
    else 
      MySkinTextures.m_Window.Inactive.Draw(Renderer, control.RenderBounds);
  }

  void DrawHighlight(GwenControlBase control)
  {
    Rectangle rect = control.RenderBounds;
    Renderer.DrawColor = new Color.argb(255, 255, 100, 255);
    Renderer.drawFilledRect(rect);
  }

  void DrawScrollBar(GwenControlBase control, bool horizontal, bool depressed)
  {
    if (horizontal)
      MySkinTextures.m_Scroller.TrackH.Draw(Renderer, control.RenderBounds);
    else
      MySkinTextures.m_Scroller.TrackV.Draw(Renderer, control.RenderBounds);
  }

  void DrawScrollBarBar(GwenControlBase control, bool depressed, bool hovered, bool horizontal)
  {
    if (!horizontal)
    {
      if (control.IsDisabled)
      {
        MySkinTextures.m_Scroller.ButtonV_Disabled.Draw(Renderer, control.RenderBounds);
        return;
      }

      if (depressed)
      {
        MySkinTextures.m_Scroller.ButtonV_Down.Draw(Renderer, control.RenderBounds);
        return;
      }

      if (hovered)
      {
        MySkinTextures.m_Scroller.ButtonV_Hover.Draw(Renderer, control.RenderBounds);
        return;
      }

      MySkinTextures.m_Scroller.ButtonV_Normal.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (control.IsDisabled)
    {
      MySkinTextures.m_Scroller.ButtonH_Disabled.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (depressed)
    {
      MySkinTextures.m_Scroller.ButtonH_Down.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (hovered)
    {
      MySkinTextures.m_Scroller.ButtonH_Hover.Draw(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Scroller.ButtonH_Normal.Draw(Renderer, control.RenderBounds);
  }

  void DrawProgressBar(GwenControlBase control, bool horizontal, double progress)
  {
    Rectangle rect1 = control.RenderBounds;
    
    int left = rect1.left;
    int top = rect1.top;
    int width = rect1.width;
    int height = rect1.height;
    
    Rectangle rect;
    
    if (horizontal)
    {
      MySkinTextures.m_ProgressBar.Back.Draw(Renderer, rect1);
      width =  (rect1.width*progress);
      rect = new Rectangle(left, top, width, height);
      MySkinTextures.m_ProgressBar.Front.Draw(Renderer, rect);
    }
    else
    {
      MySkinTextures.m_ProgressBar.Back.Draw(Renderer, rect1);
      top =  (rect.top + rect.height*(1 - progress));
      height = (rect.height * progress);
      rect = new Rectangle(left, top, width, height);
      MySkinTextures.m_ProgressBar.Front.Draw(Renderer, rect);
    }
  }

  void DrawListBox(GwenControlBase control)
  {
    MySkinTextures.m_Input.m_ListBox.Background.Draw(Renderer, control.RenderBounds);
  }

  void DrawListBoxLine(GwenControlBase control, bool selected, bool even)
  {
    if (selected)
    {
      if (even)
      {
        MySkinTextures.m_Input.m_ListBox.EvenLineSelected.Draw(Renderer, control.RenderBounds);
        return;
      }
      MySkinTextures.m_Input.m_ListBox.OddLineSelected.Draw(Renderer, control.RenderBounds);
      return;
    }
    
    if (control.IsHovered)
    {
      MySkinTextures.m_Input.m_ListBox.Hovered.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (even)
    {
      MySkinTextures.m_Input.m_ListBox.EvenLine.Draw(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Input.m_ListBox.OddLine.Draw(Renderer, control.RenderBounds);
  }

   DrawSliderNotchesH(Rectangle rect, int numNotches, double dist)
  {
    if (numNotches == 0) return;

    double  iSpacing = rect.width / numNotches;
    for (int i = 0; i < numNotches + 1; i++)
      Renderer.drawFilledRect(GwenUtil.FloatRect(rect.left + iSpacing * i, rect.top + dist - 2, 1.0, 5.0));
  }

   DrawSliderNotchesV(Rectangle rect, int numNotches, double dist)
  {
    if (numNotches == 0) return;

    double iSpacing = rect.height / numNotches;
    for (int i = 0; i < numNotches + 1; i++)
      Renderer.drawFilledRect(GwenUtil.FloatRect(rect.left + dist - 2, rect.top + iSpacing * i, 5.0, 1.0));
  }

  void DrawSlider(GwenControlBase control, bool horizontal, int numNotches, int barSize)
  {
    Rectangle rect1 = control.RenderBounds;
    Renderer.DrawColor = new Color.argb(100, 0, 0, 0);
    int left = rect1.left;
    int top = rect1.top;
    int width = rect1.width;
    int height = rect1.height;
    Rectangle rect;
    
    if (horizontal)
    {
      left +=  (barSize*0.5);
      width -= barSize;
      top += (rect.height * 0.5 - 1);
      height = 1;
      rect = new Rectangle(left, top, width, height);
      DrawSliderNotchesH(rect, numNotches, barSize*0.5);
      Renderer.drawFilledRect(rect);
      return;
    }

    top += (barSize * 0.5);
    height -= barSize;
    left += (rect.width * 0.5 - 1);
    width = 1;
    rect = new Rectangle(left, top, width, height);
    DrawSliderNotchesV(rect, numNotches, barSize * 0.4);
    Renderer.drawFilledRect(rect);
  }

  void DrawComboBox(GwenControlBase control, bool down, bool open)
  {
    if (control.IsDisabled)
    {
      MySkinTextures.m_Input.m_ComboBox.Disabled.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (down || open)
    {
      MySkinTextures.m_Input.m_ComboBox.Down.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (control.IsHovered)
    {
      MySkinTextures.m_Input.m_ComboBox.Down.Draw(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Input.m_ComboBox.Normal.Draw(Renderer, control.RenderBounds);
  }

  void DrawKeyboardHighlight(GwenControlBase control, Rectangle r, int offset)
  {

    Rectangle rect1 = r;

    int left = rect1.left;
    int top = rect1.top;
    int width = rect1.width;
    int height = rect1.height;
    Rectangle rect;
    left += offset;
    top += offset;
    width -= offset * 2;
    height -= offset * 2;
    rect = new Rectangle(left, top, width, height);
    //draw the top and bottom
    bool skip = true;
    for (int i = 0; i < width * 0.5; i++)
    {
      Renderer.DrawColor = Color.Black;
      if (!skip)
      {
        Renderer.drawPixel(rect.left + (i * 2), rect.top);
        Renderer.drawPixel(rect.left + (i * 2), rect.top + rect.height - 1);
      }
      else
        skip = false;
    }

    for (int i = 0; i < rect.height * 0.5; i++)
    {
      Renderer.DrawColor = Color.Black;
      Renderer.drawPixel(rect.left, rect.top + i * 2);
      Renderer.drawPixel(rect.left + rect.width - 1, rect.top + i * 2);
    }
  }

  void DrawToolTip(GwenControlBase control)
  {
    MySkinTextures.Tooltip.Draw(Renderer, control.RenderBounds);
  }

  void DrawScrollButton(GwenControlBase control, Pos direction, bool depressed, bool hovered, bool disabled)
  {
    int i = 0;
    if (direction == Pos.Top) i = 1;
    if (direction == Pos.Right) i = 2;
    if (direction == Pos.Bottom) i = 3;

    if (disabled)
    {
      MySkinTextures.m_Scroller.m_ScrollerButton.Disabled[i].Draw(Renderer, control.RenderBounds);
      return;
    }

    if (depressed)
    {
      MySkinTextures.m_Scroller.m_ScrollerButton.Down[i].Draw(Renderer, control.RenderBounds);
      return;
    }

    if (hovered)
    {
      MySkinTextures.m_Scroller.m_ScrollerButton.Hover[i].Draw(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Scroller.m_ScrollerButton.Normal[i].Draw(Renderer, control.RenderBounds);
  }

  void DrawComboBoxArrow(GwenControlBase control, bool hovered, bool down, bool open, bool disabled)
  {
    if (disabled)
    {
      MySkinTextures.m_Input.m_ComboBox.m_Button.Disabled.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (down || open)
    {
      MySkinTextures.m_Input.m_ComboBox.m_Button.Down.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (hovered)
    {
      MySkinTextures.m_Input.m_ComboBox.m_Button.Hover.Draw(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Input.m_ComboBox.m_Button.Normal.Draw(Renderer, control.RenderBounds);
  }

  void DrawNumericUpDownButton(GwenControlBase control, bool depressed, bool up)
  {
    if (up)
    {
      if (control.IsDisabled)
      {
        MySkinTextures.m_Input.m_UpDown.m_Up.Disabled.DrawCenter(Renderer, control.RenderBounds);
        return;
      }

      if (depressed)
      {
        MySkinTextures.m_Input.m_UpDown.m_Up.Down.DrawCenter(Renderer, control.RenderBounds);
        return;
      }

      if (control.IsHovered)
      {
        MySkinTextures.m_Input.m_UpDown.m_Up.Hover.DrawCenter(Renderer, control.RenderBounds);
        return;
      }

      MySkinTextures.m_Input.m_UpDown.m_Up.Normal.DrawCenter(Renderer, control.RenderBounds);
      return;
    }

    if (control.IsDisabled)
    {
      MySkinTextures.m_Input.m_UpDown.m_Down.Disabled.DrawCenter(Renderer, control.RenderBounds);
      return;
    }

    if (depressed)
    {
      MySkinTextures.m_Input.m_UpDown.m_Down.Down.DrawCenter(Renderer, control.RenderBounds);
      return;
    }

    if (control.IsHovered)
    {
      MySkinTextures.m_Input.m_UpDown.m_Down.Hover.DrawCenter(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Input.m_UpDown.m_Down.Normal.DrawCenter(Renderer, control.RenderBounds);
  }

  void DrawStatusBar(GwenControlBase control)
  {
    MySkinTextures.StatusBar.Draw(Renderer, control.RenderBounds);
  }

  void DrawTreeButton(GwenControlBase control, bool open)
  {
    Rectangle rect = control.RenderBounds;

    if (open)
      MySkinTextures.m_Tree.Minus.Draw(Renderer, rect);
    else
      MySkinTextures.m_Tree.Plus.Draw(Renderer, rect);
  }

  void DrawTreeControl(GwenControlBase control)
  {
    MySkinTextures.m_Tree.Background.Draw(Renderer, control.RenderBounds);
  }

  void DrawTreeNode(GwenControlBase ctrl, bool open, bool selected, int labelHeight, int labelWidth, int halfWay, int lastBranch, bool isRoot)
  {
    if (selected)
    {
      MySkinTextures.Selection.Draw(Renderer, new Rectangle(17, 0, labelWidth + 2, labelHeight - 1));
    }

    super.DrawTreeNode(ctrl, open, selected, labelHeight, labelWidth, halfWay, lastBranch, isRoot);
  }

  void DrawColorDisplay(GwenControlBase control, Color color)
  {
    Rectangle rect = control.RenderBounds;

    if (color.a != 255)
    {
      Renderer.DrawColor = new Color.argb(255, 255, 255, 255);
      Renderer.drawFilledRect(rect);

      Renderer.DrawColor = new Color.argb(128, 128, 128, 128);

      Renderer.drawFilledRect(GwenUtil.FloatRect(0.0, 0.0, rect.width * 0.5, rect.height * 0.5));
      Renderer.drawFilledRect(GwenUtil.FloatRect(rect.width * 0.5, rect.height * 0.5, rect.width * 0.5, rect.height * 0.5));
    }

    Renderer.DrawColor = color;
    Renderer.drawFilledRect(rect);

    Renderer.DrawColor = Color.Black;
    Renderer.drawLinedRect(rect);
  }

  void DrawModalControl(GwenControlBase control)
  {
    if (!control.ShouldDrawBackground)
      return;
    Rectangle rect = control.RenderBounds;
    Renderer.DrawColor = SkinColors.m_ModalBackground;
    Renderer.drawFilledRect(rect);
  }

  void DrawMenuDivider(GwenControlBase control)
  {
    Rectangle rect = control.RenderBounds;
    Renderer.DrawColor = new Color.argb(100, 0, 0, 0);
    Renderer.drawFilledRect(rect);
  }

  void DrawWindowCloseButton(GwenControlBase control, bool depressed, bool hovered, bool disabled)
  {

    if (disabled)
    {
      MySkinTextures.m_Window.Close_Disabled.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (depressed)
    {
      MySkinTextures.m_Window.Close_Down.Draw(Renderer, control.RenderBounds);
      return;
    }

    if (hovered)
    {
      MySkinTextures.m_Window.Close_Hover.Draw(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Window.Close.Draw(Renderer, control.RenderBounds);
  }

  void DrawSliderButton(GwenControlBase control, bool depressed, bool horizontal)
  {
    if (!horizontal)
    {
      if (control.IsDisabled)
      {
        MySkinTextures.m_Input.m_Slider.m_V.Disabled.DrawCenter(Renderer, control.RenderBounds);
        return;
      }
      
      if (depressed)
      {
        MySkinTextures.m_Input.m_Slider.m_V.Down.DrawCenter(Renderer, control.RenderBounds);
        return;
      }
      
      if (control.IsHovered)
      {
        MySkinTextures.m_Input.m_Slider.m_V.Hover.DrawCenter(Renderer, control.RenderBounds);
        return;
      }

      MySkinTextures.m_Input.m_Slider.m_V.Normal.DrawCenter(Renderer, control.RenderBounds);
      return;
    }

    if (control.IsDisabled)
    {
      MySkinTextures.m_Input.m_Slider.m_H.Disabled.DrawCenter(Renderer, control.RenderBounds);
      return;
    }

    if (depressed)
    {
      MySkinTextures.m_Input.m_Slider.m_H.Down.DrawCenter(Renderer, control.RenderBounds);
      return;
    }

    if (control.IsHovered)
    {
      MySkinTextures.m_Input.m_Slider.m_H.Hover.DrawCenter(Renderer, control.RenderBounds);
      return;
    }

    MySkinTextures.m_Input.m_Slider.m_H.Normal.DrawCenter(Renderer, control.RenderBounds);
  }

  void DrawCategoryHolder(GwenControlBase control)
  {
    MySkinTextures.m_CategoryList.Outer.Draw(Renderer, control.RenderBounds);
  }

  void DrawCategoryInner(GwenControlBase control, bool collapsed)
  {
    if (collapsed)
      MySkinTextures.m_CategoryList.Header.Draw(Renderer, control.RenderBounds);
    else
      MySkinTextures.m_CategoryList.Inner.Draw(Renderer, control.RenderBounds);
  }
}