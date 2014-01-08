part of gwendart;

class SkinWindow
{
  Color TitleActive;
  Color TitleInactive;
  SkinWindow()
  {
    TitleActive   =  Color.Red;
    TitleInactive =  Color.Yellow;
  }
}

class SkinButton
{
  Color Normal;
  Color Hover;
  Color Down;
  Color Disabled;
  SkinButton()
  {
    Normal   =  Color.Yellow;
    Hover    =  Color.Yellow;
    Down     = Color.Yellow;
    Disabled = Color.Yellow;
  }
}

class SkinInactive
{
  Color Normal=  Color.Yellow;
  Color Hover=  Color.Yellow;
  Color Down=  Color.Yellow;
  Color Disabled=  Color.Yellow;
}

class SkinActive
{
  Color Normal;
  Color Hover;
  Color Down;
  Color Disabled;
  SkinActive()
  {
     Normal=  Color.Yellow;
    Hover=  Color.Yellow;
     Down=  Color.Yellow;
     Disabled=  Color.Yellow;
  }
}

class SkinTab
{
   SkinInactive m_Inactive;
   SkinActive m_Active;
   SkinTab()
   {
     m_Inactive = new SkinInactive();
     m_Active = new SkinActive();
   }
}

class SkinLabel
{
  Color Default;
  Color Bright;
  Color Dark;
  Color Highlight;
  SkinLabel()
  {
  Default=Color.Grey;
  Bright=Color.White;
  Dark=Color.Black;
  Highlight=Color.Yellow;
  }
}

class SkinTree
{
  Color Lines;
  Color Normal;
  Color Hover;
  Color Selected;
  SkinTree()
  {
    Lines = Color.Blue;
    Normal=Color.Grey;
    Hover=Color.Green;
    Selected=Color.White;
  }
}

class SkinProperties
{
  Color Line_Normal;
  Color Line_Selected;
  Color Line_Hover;
  Color Column_Normal;
  Color Column_Selected;
  Color Column_Hover;
  Color Label_Normal;
  Color Label_Selected;
  Color Label_Hover;
  Color Border;
  Color Title;
  SkinProperties()
  {
    Line_Normal = Color.Blue;
    Line_Selected=Color.White;
    Line_Hover=Color.Green;
    Column_Normal=Color.Grey;
    Column_Selected=Color.Purple;
    Column_Hover=Color.Blue;
    Label_Normal=Color.Grey;
    Label_Selected=Color.White;
    Label_Hover=Color.Black;
    Border=Color.Black;
    Color Title=Color.Yellow;
  }
}

class SkinLine
{
  Color Text;
  Color Text_Hover;
  Color Text_Selected;
  Color Button;
  Color Button_Hover;
  Color Button_Selected;
  SkinLine()
  {
    Text=Color.White;
    Text_Hover=Color.White;
    Text_Selected=Color.Blue;
    Button=Color.Grey;
    Button_Hover=Color.Yellow;
    Button_Selected=Color.Green;
  }
}

class SkinLineAlt
{
  Color Text;
  Color Text_Hover;
  Color Text_Selected;
  Color Button;
  Color Button_Hover;
  Color Button_Selected;
  SkinLineAlt()
  {
    Text=Color.White;
    Text_Hover=Color.White;
    Text_Selected=Color.Blue;
    Button=Color.Grey;
    Button_Hover=Color.Yellow;
    Button_Selected=Color.Green;
  }
}

class SkinCategory
{
  Color Header;
  Color Header_Closed;
  SkinLine m_Line;
  SkinLineAlt m_LineAlt;
  SkinCategory()
  {
    Header=Color.Yellow;
    Header_Closed=Color.Grey;
    m_Line=new SkinLine();
    m_LineAlt= new SkinLineAlt();
  }
}

class GwenSkinColors
{

  Color m_ModalBackground;
  Color m_TooltipText;
  SkinWindow m_Window;
  SkinButton m_Button;
  SkinTab m_Tab;
  SkinLabel m_Label;
  SkinTree m_Tree;
  SkinProperties m_Properties;
  SkinCategory m_Category;
  GwenSkinColors()
  {
    m_ModalBackground = Color.Grey;
    m_TooltipText= Color.White;
    m_Window=new SkinWindow();
    m_Button=new SkinButton();
    m_Tab= new SkinTab();
    m_Label=new SkinLabel();
    m_Tree=new SkinTree();
    m_Properties=new SkinProperties();
    m_Category=new SkinCategory();
  }
}

class GwenSkinBase 
{
   GwenFont DefaultFont;
   final GwenRendererBase _renderer;
   GwenRendererBase get Renderer => _renderer;
   
   GwenSkinColors SkinColors;
   
   GwenSkinBase(GwenRendererBase renderer) : _renderer = renderer
       {
          DefaultFont = new GwenFont(renderer);
       }
   
   void ReleaseFont(GwenFont font){}
   
   
   void SetDefaultFont(String facename, [int size=10])
   {
     DefaultFont = new GwenFont(null, facename, size);
   }
   void DrawButton(GwenControlBase control, bool depressed, bool hovered, bool disabled) { }
   void DrawTabButton(GwenControlBase control, bool active, Pos dir) { }
   void DrawTabControl(GwenControlBase control) { }
   void DrawTabTitleBar(GwenControlBase control) { }
   void DrawMenuItem(GwenControlBase control, bool submenuOpen, bool isChecked) { }
   void DrawMenuRightArrow(GwenControlBase control) { }
   void DrawMenuStrip(GwenControlBase control) { }
   void DrawMenu(GwenControlBase control, bool paddingDisabled) { }
   void DrawRadioButton(GwenControlBase control, bool selected, bool depressed) { }
   void DrawCheckBox(GwenControlBase control, bool selected, bool depressed) { }
   void DrawGroupBox(GwenControlBase control, int textStart, int textHeight, int textWidth) { }
   void DrawTextBox(GwenControlBase control) { }
   void DrawWindow(GwenControlBase control, int topHeight, bool inFocus) { }
   void DrawWindowCloseButton(GwenControlBase control, bool depressed, bool hovered, bool disabled) { }
   void DrawHighlight(GwenControlBase control) { }
   void DrawStatusBar(GwenControlBase control) { }
   void DrawShadow(GwenControlBase control) { }
   void DrawScrollBarBar(GwenControlBase control, bool depressed, bool hovered, bool horizontal) { }
   void DrawScrollBar(GwenControlBase control, bool horizontal, bool depressed) { }
   void DrawScrollButton(GwenControlBase control, Pos direction, bool depressed, bool hovered, bool disabled) { }
   void DrawProgressBar(GwenControlBase control, bool horizontal, double progress) { }
   void DrawListBox(GwenControlBase control) { }
   void DrawListBoxLine(GwenControlBase control, bool selected, bool even) { }
   void DrawSlider(GwenControlBase control, bool horizontal, int numNotches, int barSize) { }
   void DrawSliderButton(GwenControlBase control, bool depressed, bool horizontal) { }
   void DrawComboBox(GwenControlBase control, bool down, bool isMenuOpen) { }
   void DrawComboBoxArrow(GwenControlBase control, bool hovered, bool depressed, bool open, bool disabled) { }
   void DrawKeyboardHighlight(GwenControlBase control, Rectangle rect, int offset) { }
   void DrawToolTip(GwenControlBase control) { }
   void DrawNumericUpDownButton(GwenControlBase control, bool depressed, bool up) { }
   void DrawTreeButton(GwenControlBase control, bool open) { }
   void DrawTreeControl(GwenControlBase control) { }
   
   

   void DrawDebugOutlines(GwenControlBase control)
   {
     _renderer.DrawColor = control.PaddingOutlineColor;
     Rectangle inner = new Rectangle(control.Bounds.left + control.Padding.Left,
         control.Bounds.top + control.Padding.Top,
         control.Bounds.width - control.Padding.Right - control.Padding.Left,
         control.Bounds.height - control.Padding.Bottom - control.Padding.Top);
     _renderer.drawLinedRect(inner);

     _renderer.DrawColor = control.MarginOutlineColor;
     Rectangle outer = new Rectangle(control.Bounds.left - control.Margin.Left,
         control.Bounds.top - control.Margin.Top,
         control.Bounds.width + control.Margin.Right + control.Margin.Left,
         control.Bounds.height + control.Margin.Bottom + control.Margin.Top);
     _renderer.drawLinedRect(outer);

     _renderer.DrawColor = control.BoundsOutlineColor;
     _renderer.drawLinedRect(control.Bounds);
   }

   void DrawTreeNode(GwenControlBase ctrl, bool open, bool selected, int labelHeight, int labelWidth, int halfWay, int lastBranch, bool isRoot)
   {
     Renderer.DrawColor = SkinColors.m_Tree.Lines;

     if (!isRoot)
       Renderer.drawFilledRect(new Rectangle(8, halfWay, 16 - 9, 1));

     if (!open) return;

     Renderer.drawFilledRect(new Rectangle(14 + 7, labelHeight + 1, 1, lastBranch + halfWay - labelHeight));
   }

   void DrawPropertyRow(GwenControlBase control, int iWidth, bool bBeingEdited, bool hovered)
   {
     Rectangle rect = control.RenderBounds;

     if (bBeingEdited)
       _renderer.DrawColor = SkinColors.m_Properties.Column_Selected;
     else if (hovered)
       _renderer.DrawColor = SkinColors.m_Properties.Column_Hover;
     else
       _renderer.DrawColor = SkinColors.m_Properties.Column_Normal;

     _renderer.drawFilledRect(new Rectangle(0, rect.top, iWidth, rect.height));

     if (bBeingEdited)
       _renderer.DrawColor = SkinColors.m_Properties.Line_Selected;
     else if (hovered)
       _renderer.DrawColor = SkinColors.m_Properties.Line_Hover;
     else
       _renderer.DrawColor = SkinColors.m_Properties.Line_Normal;

     _renderer.drawFilledRect(new Rectangle(iWidth, rect.top, 1, rect.height));

     // kds - replaced next two lines with new Rectangle below
     //rect.top += rect.height - 1;
     //rect.height = 1;

     _renderer.drawFilledRect(new Rectangle<int>(rect.left, rect.top + rect.height+1, rect.width, 1));
   }

   void DrawColorDisplay(GwenControlBase control, Color color) { }
   void DrawModalControl(GwenControlBase control) { }
   void DrawMenuDivider(GwenControlBase control) { }
   void DrawCategoryHolder(GwenControlBase control) { }
   void DrawCategoryInner(GwenControlBase control, bool collapsed) { }

   void DrawPropertyTreeNode(GwenControlBase control, int BorderLeft, int BorderTop)
   {
     Rectangle rect = control.RenderBounds;

     _renderer.DrawColor = SkinColors.m_Properties.Border;

     _renderer.drawFilledRect(new Rectangle(rect.left, rect.top, BorderLeft, rect.height));
     _renderer.drawFilledRect(new Rectangle(rect.left + BorderLeft, rect.top, rect.width - BorderLeft, BorderTop));
   }
   
   
}