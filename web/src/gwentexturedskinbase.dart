part of gwendart;

class _Active
{
   Single Normal;
   Single Checked;
   _Active(Single checked, Single normal)
   {
     Normal = normal;
     Checked = checked;
   }
}

class _Disabled
{
  Single Normal;
  Single Checked;
  _Disabled(this.Checked, this.Normal);
}

class _ScrollerButton
{
  List<Bordered> Normal;
  List<Bordered> Hover;
  List<Bordered> Down;
  List<Bordered> Disabled;
  _ScrollerButton(this.Normal, this.Hover, this.Down, this.Disabled);
}

class _Panel
{
  Bordered Normal;
  Bordered Bright;
  Bordered Dark;
  Bordered Highlight;
  _Panel(this.Normal, this.Bright, this.Dark, this.Highlight);
}

class _Window
{
  Bordered Normal;
  Bordered Inactive;
  Single Close;
  Single Close_Hover;
  Single Close_Down;
  Single Close_Disabled;
  _Window(this.Normal, this.Inactive, this.Close, this.Close_Hover, this.Close_Down, this.Close_Disabled);
}

class _CheckBox
{
  _Active m_Active;
  _Disabled m_Disabled;
  _CheckBox(this.m_Active, this.m_Disabled);
}

class _RadioButton
{
  _Active m_Active;
  _Disabled m_Disabled;
  _RadioButton(this.m_Active, this.m_Disabled);
}

class _TextBox
{
  Bordered Normal;
  Bordered Focus;
  Bordered Disabled;
  _TextBox(this.Normal, this.Focus, this.Disabled);
}

class _Tree
{
  Bordered Background;
  Single Minus;
  Single Plus;
  _Tree(this.Background, this.Minus, this.Plus);
}

class _ProgressBar
{
  Bordered Back;
  Bordered Front;
  _ProgressBar(this.Back, this.Front);
}

class _Menu
{
   Single RightArrow;
   Single Check;
   Bordered Strip;
   Bordered Background;
   Bordered BackgroundWithMargin;
   Bordered Hover;
   _Menu(this.RightArrow, this.Check, this.Strip, this.Background, this.BackgroundWithMargin, this.Hover);
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
  _Scroller(this.TrackV, this.TrackH, this.ButtonV_Normal, this.ButtonV_Hover, this.ButtonV_Down, this.ButtonV_Disabled,
                                      this.ButtonH_Normal, this.ButtonH_Hover, this.ButtonH_Down, this.ButtonH_Disabled,
            this.m_ScrollerButton);
}

class _H
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
  _H(this.Normal, this.Hover, this.Down, this.Disabled);
}

class _V
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
  _V(this.Normal, this.Hover, this.Down, this.Disabled);
}

class _Slider
{
  _H m_H;
  _V m_V;
  _Slider(this.m_H, this.m_V);
}

class _Button
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
  _Button(this.Normal, this.Hover, this.Down, this.Disabled);
}
class _ComboBox
{
  Bordered Normal;
  Bordered Hover;
  Bordered Down;
  Bordered Disabled;
  _Button m_Button;
  _ComboBox(this.Normal, this.Hover, this.Down, this.Disabled, this.m_Button);
}

class _ListBox
{
  Bordered Background;
  Bordered Hovered;
  Bordered EvenLine;
  Bordered OddLine;
  Bordered EvenLineSelected;
  Bordered OddLineSelected;
  _ListBox(this.Background, this.Hovered, this.EvenLine, this.OddLine, this.EvenLineSelected, this.OddLineSelected);
}

class _Up
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
  _Up(this.Normal, this.Hover, this.Down, this.Disabled);
}



class _Down
{
  Single Normal;
  Single Hover;
  Single Down;
  Single Disabled;
  _Down(this.Normal, this.Hover, this.Down, this.Disabled);
}

class _UpDown
{
  _Up m_Up;
  _Down m_Down;
  _UpDown(this.m_Up, this.m_Down);
}

class _InputButton
{
  Bordered Normal;
  Bordered Hovered;
  Bordered Disabled;
  Bordered Pressed;
  _InputButton(this.Normal, this.Hovered, this.Disabled, this.Pressed);
}
class _Input
{
  _InputButton m_InputButton;
  _ComboBox m_ComboBox;
  _Slider m_Slider;
  _ListBox m_ListBox;
  _UpDown m_UpDown;
  _Input(this.m_InputButton, this.m_ComboBox, this.m_Slider, this.m_ListBox, this.m_UpDown);
}


class _Bottom
{
  Bordered Inactive;
  Bordered Active;
  _Bottom(this.Inactive, this.Active);
}
class _Top
{
  Bordered Inactive;
  Bordered Active;
  _Top(this.Inactive, this.Active);
}
class _Left
{
  Bordered Inactive;
  Bordered Active;
  _Left(this.Inactive, this.Active);
}
class _Right
{
  Bordered Inactive;
  Bordered Active;
  _Right(this.Inactive, this.Active);
}

class _Tab
{
  _Bottom m_Bottom;
  _Top m_Top;
  _Left m_Left;
  _Right m_Right;
  Bordered Control;
  Bordered HeaderBar;
  _Tab(this.m_Bottom, this.m_Top, this.m_Left, this.m_Right, this.Control, this.HeaderBar);
}

class _CategoryList
{
  Bordered Outer;
  Bordered Inner;
  Bordered Header;
  _CategoryList(this.Outer, this.Inner, this.Header);
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
  SkinTextures(this.StatusBar, this.Selection, this.Shadow, this.Tooltip,
      this.m_Panel, this.m_Window, this.m_CheckBox, this.m_RadioButton, this.m_TextBox,
      this.m_Tree, this.m_ProgressBar, this.m_Scroller, this.m_Menu, 
      this.m_Input, this.m_Tab, this.m_CategoryList);
  
}

class GwenTexturedSkinBase extends GwenSkinBase
{
  SkinTextures MySkinTextures;
  GwenTexture _Texture;
  
  GwenTexturedSkinBase(GwenRendererBase renderer, String textureName) : super(renderer)
  {
    _Texture = new GwenTexture(renderer);
    _Texture.Name = textureName;
    renderer.loadTextureKnownSize(_Texture, 512, 512);
 //   _Texture.load(textureName);
  
    
    InitializeColors();
    InitializeTextures();
  }
  
  void InitializeColors()
  {
    SkinColors = new GwenSkinColors();
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
    Bordered Bor_Shadow    = new Bordered(_Texture, 448, 0, 31, 31, GwenMargin.Eight);
    Bordered Bor_Tooltip   = new Bordered(_Texture, 128, 320, 127, 31, GwenMargin.Eight);
    Bordered Bor_StatusBar = new Bordered(_Texture, 128, 288, 127, 31, GwenMargin.Eight);
    Bordered Bor_Selection = new Bordered(_Texture, 384, 32, 31, 31, GwenMargin.Four);

    Bordered Bor_Panel_Normal    = new Bordered(_Texture, 256, 0, 63, 63, new GwenMargin(16, 16, 16, 16));
    Bordered Bor_Panel_Bright    = new Bordered(_Texture, 256 + 64, 0, 63, 63, new GwenMargin(16, 16, 16, 16));
    Bordered Bor_Panel_Dark      = new Bordered(_Texture, 256, 64, 63, 63, new GwenMargin(16, 16, 16, 16));
    Bordered Bor_Panel_Highlight = new Bordered(_Texture, 256 + 64, 64, 63, 63, new GwenMargin(16, 16, 16, 16));

    Bordered Bor_m_Window_Normal   = new Bordered(_Texture, 0, 0, 127, 127, new GwenMargin(8, 32, 8, 8));
    Bordered Bor_m_Window_Inactive = new Bordered(_Texture, 128, 0, 127, 127, new GwenMargin(8, 32, 8, 8));
    Single Sing_Window_Close       = new Single(_Texture, 0, 224, 24, 24);
    Single Sing_Window_Close_Hover = new Single(_Texture, 32, 224, 24, 24);
    Single Sing_Window_Close_Down = new Single(_Texture, 64, 224, 24, 24);
    Single Sing_Window_Close_Disabled = new Single(_Texture, 96, 224, 24, 24);

    Single Sing_CheckBox_Active_Checked  = new Single(_Texture, 448, 32, 15, 15);
    Single Sing_CheckBox_Active_Normal   = new Single(_Texture, 464, 32, 15, 15);
    Single Sing_CheckBox_Disabled_Checked = new Single(_Texture, 448, 48, 15, 15);
    Single Sing_CheckBox_Disabled_Normal = new Single(_Texture, 464, 48, 15, 15);
    


    Single Sing_RadioButton_Active_Checked  = new Single(_Texture, 448, 64, 15, 15);
    Single Sing_RadioButton_Active_Normal   = new Single(_Texture, 464, 64, 15, 15);
    Single Sing_RadioButton_Disabled_Checked = new Single(_Texture, 448, 80, 15, 15);
    Single Sing_RadioButton_Disabled_Normal = new Single(_Texture, 464, 80, 15, 15);
    


    Bordered Bor_TextBox_Normal   = new Bordered(_Texture, 0, 150, 127, 21, GwenMargin.Four);
    Bordered Bor_TextBox_Focus    = new Bordered(_Texture, 0, 172, 127, 21, GwenMargin.Four);
    Bordered Bor_TextBox_Disabled = new Bordered(_Texture, 0, 193, 127, 21, GwenMargin.Four);
    


    Bordered Bor_Menu_Strip                = new Bordered(_Texture, 0, 128, 127, 21, GwenMargin.One);
    Bordered Bor_Menu_BackgroundWithMargin = new Bordered(_Texture, 128, 128, 127, 63, new GwenMargin(24, 8, 8, 8));
    Bordered Bor_Menu_Background           = new Bordered(_Texture, 128, 192, 127, 63, GwenMargin.Eight);
    Bordered Bor_Menu_Hover                = new Bordered(_Texture, 128, 256, 127, 31, GwenMargin.Eight);
    Single Sing_Menu_RightArrow           = new Single(_Texture, 464, 112, 15, 15);
    Single Sing_Menu_Check                = new Single(_Texture, 448, 112, 15, 15);
    

    

    Bordered Bor_Tab_Control         = new Bordered(_Texture, 0, 256, 127, 127, GwenMargin.Eight);
    Bordered Bor_Tab_Bottom_Active   = new Bordered(_Texture, 0, 416, 63, 31, GwenMargin.Eight);
    Bordered Bor_Tab_Bottom_Inactive = new Bordered(_Texture, 0 + 128, 416, 63, 31, GwenMargin.Eight);
    Bordered Bor_Tab_Top_Active      = new Bordered(_Texture, 0, 384, 63, 31, GwenMargin.Eight);
    Bordered Bor_Tab_Top_Inactive    = new Bordered(_Texture, 0 + 128, 384, 63, 31, GwenMargin.Eight);
    Bordered Bor_Tab_Left_Active     = new Bordered(_Texture, 64, 384, 31, 63, GwenMargin.Eight);
    Bordered Bor_Tab_Left_Inactive   = new Bordered(_Texture, 64 + 128, 384, 31, 63, GwenMargin.Eight);
    Bordered Bor_Tab_Right_Active    = new Bordered(_Texture, 96, 384, 31, 63, GwenMargin.Eight);
    Bordered Bor_Tab_Right_Inactive  = new Bordered(_Texture, 96 + 128, 384, 31, 63, GwenMargin.Eight);
    Bordered Bor_Tab_HeaderBar       = new Bordered(_Texture, 128, 352, 127, 31, GwenMargin.Four);




    Bordered Bor_Scroller_TrackV           = new Bordered(_Texture, 384, 208, 15, 127, GwenMargin.Four);
    Bordered Bor_Scroller_ButtonV_Normal   = new Bordered(_Texture, 384 + 16, 208, 15, 127, GwenMargin.Four);
    Bordered Bor_Scroller_ButtonV_Hover    = new Bordered(_Texture, 384 + 32, 208, 15, 127, GwenMargin.Four);
    Bordered Bor_Scroller_ButtonV_Down     = new Bordered(_Texture, 384 + 48, 208, 15, 127, GwenMargin.Four);
    Bordered Bor_Scroller_ButtonV_Disabled = new Bordered(_Texture, 384 + 64, 208, 15, 127, GwenMargin.Four);
    Bordered Bor_Scroller_TrackH           = new Bordered(_Texture, 384, 128, 127, 15, GwenMargin.Four);
    Bordered Bor_Scroller_ButtonH_Normal   = new Bordered(_Texture, 384, 128 + 16, 127, 15, GwenMargin.Four);
    Bordered Bor_Scroller_ButtonH_Hover    = new Bordered(_Texture, 384, 128 + 32, 127, 15, GwenMargin.Four);
    Bordered Bor_Scroller_ButtonH_Down     = new Bordered(_Texture, 384, 128 + 48, 127, 15, GwenMargin.Four);
    Bordered Bor_Scroller_ButtonH_Disabled = new Bordered(_Texture, 384, 128 + 64, 127, 15, GwenMargin.Four);

    List<Bordered> List_Scroller_ScrollerButton_Normal   = new List<Bordered>(4);
    List<Bordered> List_Scroller_ScrollerButton_Disabled = new List<Bordered>(4);
    List<Bordered> List_Scroller_ScrollerButton_Hover    = new List<Bordered>(4);
    List<Bordered> List_Scroller_ScrollerButton_Down     = new List<Bordered>(4);
    



    Bordered Bore_Background = new Bordered(_Texture, 256, 128, 127, 127, new GwenMargin(16, 16, 16, 16));
    Single Sing_Tree_Plus       = new Single(_Texture, 448, 96, 15, 15);
    Single Sing_Tree_Minus      = new Single(_Texture, 464, 96, 15, 15);
    

    Bordered Bor_Input_InputButton_Normal   = new Bordered(_Texture, 480, 0, 31, 31, GwenMargin.Eight);
    Bordered Bor_Input_InputButton_Hovered  = new Bordered(_Texture, 480, 32, 31, 31, GwenMargin.Eight);
    Bordered Bor_Input_InputButton_Disabled = new Bordered(_Texture, 480, 64, 31, 31, GwenMargin.Eight);
    Bordered Bor_Input_InputButton_Pressed  = new Bordered(_Texture, 480, 96, 31, 31, GwenMargin.Eight);
    



    for (int i = 0; i < 4; i++)
    {
      List_Scroller_ScrollerButton_Normal[i]   = new Bordered(_Texture, 464 + 0, 208 + i * 16, 15, 15, GwenMargin.Two);
      List_Scroller_ScrollerButton_Hover[i]    = new Bordered(_Texture, 480, 208 + i * 16, 15, 15, GwenMargin.Two);
      List_Scroller_ScrollerButton_Down[i]     = new Bordered(_Texture, 464, 272 + i * 16, 15, 15, GwenMargin.Two);
      List_Scroller_ScrollerButton_Disabled[i] = new Bordered(_Texture, 480 + 48, 272 + i * 16, 15, 15, GwenMargin.Two);
    }

    Bordered Bor_Input_ListBox_Background       = new Bordered(_Texture, 256, 256, 63, 127, GwenMargin.Eight);
    Bordered Bor_Input_ListBox_Hovered          = new Bordered(_Texture, 320, 320, 31, 31, GwenMargin.Eight);
    Bordered Bor_Input_ListBox_EvenLine         = new Bordered(_Texture, 352, 256, 31, 31, GwenMargin.Eight);
    Bordered Bor_Input_ListBox_OddLine          = new Bordered(_Texture, 352, 288, 31, 31, GwenMargin.Eight);
    Bordered Bor_Input_ListBox_EvenLineSelected = new Bordered(_Texture, 320, 270, 31, 31, GwenMargin.Eight);
    Bordered Bor_Input_ListBox_OddLineSelected  = new Bordered(_Texture, 320, 288, 31, 31, GwenMargin.Eight);
    



    Bordered Bor_Input_ComboBox_Normal   = new Bordered(_Texture, 384, 336, 127, 31, new GwenMargin(8, 8, 32, 8));
    Bordered Bor_Input_ComboBox_Hover    = new Bordered(_Texture, 384, 336 + 32, 127, 31, new GwenMargin(8, 8, 32, 8));
    Bordered Bor_Input_ComboBox_Down     = new Bordered(_Texture, 384, 336 + 64, 127, 31, new GwenMargin(8, 8, 32, 8));
    Bordered Bor_Input_ComboBox_Disabled = new Bordered(_Texture, 384, 336 + 96, 127, 31, new GwenMargin(8, 8, 32, 8));
    


    Single Sing_Input_ComboBox__Button_Normal   = new Single(_Texture, 496, 272, 15, 15);
    Single Sing_Input_ComboBox__Button_Hover    = new Single(_Texture, 496, 272 + 16, 15, 15);
    Single Sing_Input_ComboBox__Button_Down     = new Single(_Texture, 496, 272 + 32, 15, 15);
    Single Sing_Input_ComboBox__Button_Disabled = new Single(_Texture, 496, 272 + 48, 15, 15);



    
    Single Sing_Input_UpDown_Up_Normal     = new Single(_Texture, 384, 112, 7, 7);
    Single Sing_Input_UpDown_Up_Hover      = new Single(_Texture, 384 + 8, 112, 7, 7);
    Single Sing_Input_UpDown_Up_Down       = new Single(_Texture, 384 + 16, 112, 7, 7);
    Single Sing_Input_UpDown_Up_Disabled   = new Single(_Texture, 384 + 24, 112, 7, 7);
    Single Sing_Input_UpDown_Down_Normal   = new Single(_Texture, 384, 120, 7, 7);
    Single Sing_Input_UpDown_Down_Hover    = new Single(_Texture, 384 + 8, 120, 7, 7);
    Single Sing_Input_UpDown_Down_Down     = new Single(_Texture, 384 + 16, 120, 7, 7);
    Single Sing_Input_UpDown_Down_Disabled = new Single(_Texture, 384 + 24, 120, 7, 7);
    
    Bordered Bor_ProgressBar_Back  = new Bordered(_Texture, 384, 0, 31, 31, GwenMargin.Eight);
    Bordered Bor_ProgressBar_Front = new Bordered(_Texture, 384 + 32, 0, 31, 31, GwenMargin.Eight);
    

    Single Sing_Input_Slider_H_Normal   = new Single(_Texture, 416, 32, 15, 15);
    Single Sing_Input_Slider_H_Hover    = new Single(_Texture, 416, 32 + 16, 15, 15);
    Single Sing_Input_Slider_H_Down     = new Single(_Texture, 416, 32 + 32, 15, 15);
    Single Sing_Input_Slider_H_Disabled = new Single(_Texture, 416, 32 + 48, 15, 15);

    Single Sing_Input_Slider_V_Normal   = new Single(_Texture, 416 + 16, 32, 15, 15);
    Single Sing_Input_Slider_V_Hover    = new Single(_Texture, 416 + 16, 32 + 16, 15, 15);
    Single Sing_Input_Slider_V_Down     = new Single(_Texture, 416 + 16, 32 + 32, 15, 15);
    Single Sing_Input_Slider_V_Disabled = new Single(_Texture, 416 + 16, 32 + 48, 15, 15);
    


    Bordered Bor_CategoryList_Outer  = new Bordered(_Texture, 256, 384, 63, 63, GwenMargin.Eight);
    Bordered Bor_CategoryList_Inner  = new Bordered(_Texture, 256 + 64, 384, 63, 63, new GwenMargin(8, 21, 8, 8));
    Bordered Bor_CategoryList_Header = new Bordered(_Texture, 320, 352, 63, 31, GwenMargin.Eight);
    

    
    /* Bordered StatusBar;
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
    _CategoryList m_CategoryList; */
    MySkinTextures = new SkinTextures(
        Bor_StatusBar,
        Bor_Selection, 
        Bor_Shadow, 
        Bor_Tooltip,
        new _Panel(
            Bor_Panel_Normal,
            Bor_Panel_Bright,
            Bor_Panel_Dark,
            Bor_Panel_Highlight
            ), 
         new _Window(Bor_m_Window_Normal, Bor_m_Window_Inactive, 
                Sing_Window_Close, Sing_Window_Close_Hover, 
                Sing_Window_Close_Down, Sing_Window_Close_Disabled),
         new _CheckBox(
             new _Active(
                    Sing_CheckBox_Active_Checked,
                    Sing_CheckBox_Active_Normal),
             new _Disabled(       Sing_CheckBox_Disabled_Checked,
                    Sing_CheckBox_Disabled_Normal)
                ),
         new _RadioButton(
                    new _Active(Sing_RadioButton_Active_Checked, Sing_RadioButton_Active_Normal),
                    new _Disabled(Sing_CheckBox_Disabled_Checked, Sing_RadioButton_Disabled_Normal)), 
         new _TextBox(Bor_TextBox_Normal, Bor_TextBox_Focus, Bor_TextBox_Disabled),
         new _Tree(Bore_Background, Sing_Tree_Plus, Sing_Tree_Minus), 
         new _ProgressBar(Bor_ProgressBar_Back, Bor_ProgressBar_Front), 
         new _Scroller(
             Bor_Scroller_TrackV,
             Bor_Scroller_TrackH ,
             Bor_Scroller_ButtonV_Normal,
             Bor_Scroller_ButtonV_Hover,
             Bor_Scroller_ButtonV_Down,
             Bor_Scroller_ButtonV_Disabled,

             Bor_Scroller_ButtonH_Normal,
             Bor_Scroller_ButtonH_Hover,
             Bor_Scroller_ButtonH_Down,
             Bor_Scroller_ButtonH_Disabled,
             new _ScrollerButton(List_Scroller_ScrollerButton_Normal,
                 List_Scroller_ScrollerButton_Hover,
                 List_Scroller_ScrollerButton_Down,
                 List_Scroller_ScrollerButton_Disabled)
         ), 
         new _Menu(
             Sing_Menu_RightArrow,
             Sing_Menu_Check,
             Bor_Menu_Strip,
             Bor_Menu_Background,
             Bor_Menu_BackgroundWithMargin,
             Bor_Menu_Hover
         ), 
         new _Input(
             new _InputButton(
                 Bor_Input_InputButton_Normal,
                 Bor_Input_InputButton_Hovered,
                 Bor_Input_InputButton_Disabled,
                 Bor_Input_InputButton_Pressed
             ),
             new _ComboBox(
                 Bor_Input_ComboBox_Normal,
                 Bor_Input_ComboBox_Hover,
                 Bor_Input_ComboBox_Down,
                 Bor_Input_ComboBox_Disabled,
                 new _Button(
                     Sing_Input_ComboBox__Button_Normal,
                     Sing_Input_ComboBox__Button_Hover,
                     Sing_Input_ComboBox__Button_Down,
                     Sing_Input_ComboBox__Button_Disabled
                 )
             ),
             new _Slider(
                 new _H(Sing_Input_Slider_H_Normal,
                     Sing_Input_Slider_H_Hover,
                     Sing_Input_Slider_H_Down,
                     Sing_Input_Slider_H_Disabled
                 ),
                 new _V(Sing_Input_Slider_V_Normal,
                     Sing_Input_Slider_V_Hover,
                     Sing_Input_Slider_V_Down,
                     Sing_Input_Slider_V_Disabled
                 )
             ),
             new _ListBox
             (
                 Bor_Input_ListBox_Background,
                 Bor_Input_ListBox_Hovered,
                 Bor_Input_ListBox_EvenLine,
                 Bor_Input_ListBox_OddLine,
                 Bor_Input_ListBox_EvenLineSelected,
                 Bor_Input_ListBox_OddLineSelected
             ),
             new _UpDown(
                 new _Up(
                     Sing_Input_UpDown_Up_Normal,
                     Sing_Input_UpDown_Up_Hover,
                     Sing_Input_UpDown_Up_Down,
                     Sing_Input_UpDown_Up_Disabled
                 ),
                 new _Down(
                     Sing_Input_UpDown_Down_Normal,
                     Sing_Input_UpDown_Down_Hover,
                     Sing_Input_UpDown_Down_Down,
                     Sing_Input_UpDown_Down_Disabled        
                 )
             )
         ), 
         new _Tab(
             new _Bottom(
                 Bor_Tab_Bottom_Inactive,
                 Bor_Tab_Bottom_Active 
             ),
             new _Top(
                 Bor_Tab_Top_Inactive,
                 Bor_Tab_Top_Active 
             ),
             new _Left(
                 Bor_Tab_Left_Inactive,
                 Bor_Tab_Left_Active 
             ),
             new _Right(
                 Bor_Tab_Right_Inactive,
                 Bor_Tab_Right_Active 
             ),
             Bor_Tab_Control,
             Bor_Tab_HeaderBar
         ), 
         new _CategoryList(
             Bor_CategoryList_Outer,
             Bor_CategoryList_Inner,
             Bor_CategoryList_Header
         )
    );
    
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