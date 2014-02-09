import 'dart:html';
import 'src/gwendart.dart';







class TestDockBase extends GwenControlBase
{
  static const String SkinImageFilename = "DefaultSkin.png";
  
  static List<String> getListOfTextureFilenames()
  {
    List<String> listRet = new List<String>();
    listRet.add("test16.png");
    listRet.add("redBrightMetallicC128.png");
    return listRet;
  }
  static GwenControlBase createTestDocBase(CanvasRenderer renderer, GwenControlCanvas gcanvas, int width, int height)
  {
    return new TestDockBase(renderer, gcanvas, renderer.Width, renderer.Height);
  }
  
   GwenControlBase _lastControl;
   double Fps;
   String Note;
//   Timer _timer;
   final CanvasRenderer _cvsr;
   
   Label _lblMouseCoords;
   
   TestDockBase(CanvasRenderer cvsr, 
       GwenControlBase parent, int width, int height) : _cvsr=cvsr, super(parent)
   {
      Dock = Pos.Fill;
      SetSize(width, height);
      
      //TabButton tabPageButton = LeftDock.MyDockedTabControl.AddPage("Tests");
      //LeftDock.Width=500;
      
      
      MenuStrip menu = new MenuStrip(this);
      MenuItem root = menu.AddItem("File");
      root.MyMenu.AddItem("Load", "test16.png");
      root.MyMenu.AddItem("Save");
      root.MyMenu.AddItem("Save As..");
      MenuItem menuItemAbout = root.MyMenu.AddItem("About");
      menuItemAbout.Clicked.add(new GwenControlEventHandler(buttonClickHandler_showMsgBox));
      root.MyMenu.AddItem("Exit");
      
      MenuItem editroot = menu.AddItem("Edit");
      MenuItem editSweetMode = editroot.MyMenu.AddItem("Sweet Mode");
      editSweetMode.IsCheckable = true;
      editSweetMode.IsChecked = true;
      MenuItem editChalky = editroot.MyMenu.AddItem("Chalky");
      editChalky.IsCheckable = true;
      
      TabControl tabControl = new TabControl(this);
      tabControl.Dock = Pos.Top;
      tabControl.Height = Height - menu.Height;
      
      TabButton tabButton = tabControl.AddPage("page0");
      
      GwenControlBase page0 = tabButton.Page;
      
      TabButton tabButton1 = tabControl.AddPage("page1");
      GwenControlBase page1 = tabButton1.Page;
      
      //page0.SetBounds(0, menu.Height, Width, Height-menu.Height);
      page0.Dock = Pos.Top;
      page0.Height = Height-menu.Height-24;
      //page0.SetBounds(0, 0, page0.Parent.Width, page0.Parent.Height-30);
      
      page1.Dock = Pos.Top;
      page1.Height = Height-menu.Height-24;
     
      
      Label label = new Label(page0);
      label.SetPosition(200, 50);
      label.SetText("Hello, Label!");
      
      Button button = new Button(page0);
      button.SetSize(24, 24);
      button.SetText("ok");
      button.SetPosition(485, 40);
      button.MouseInputEnabled=true;
      button.KeyboardInputEnabled=true;
   
      WindowControl window = new WindowControl(page0, "My Window");
      window.SetSize(220, 100);
      window.SetPosition(1, 5);
      
      
      ImagePanel imgPanel = new ImagePanel(page0);
      imgPanel.ImageName = "redBrightMetallicC128.png";
      imgPanel.SetPosition(10, 240);
      
      
      TextBox textBox = new TextBox(page1);
      textBox.Text = "Hello";
      textBox.AutoSizeToContents = false;
      textBox.SetPosition(250, 410);
      
      LabeledCheckBox ckbox = new LabeledCheckBox(page1);
      ckbox.Text = "Awesomeness";
      ckbox.SetPosition(12, 410);
      
     // GroupBox gb = new GroupBox(page0);
      //gb.Text = "Group Box!";
     // gb.SetBounds(1, 350, 220, 150);
      RadioButtonGroup rbGroup = new RadioButtonGroup(page1);
      rbGroup.SetText("Options!");
      rbGroup.AddOption("radio1", "opName1");
      rbGroup.AddOption("Optioh 2", "opName2");
      rbGroup.AddOption("option 3", "opName3");
      rbGroup.SetPosition(260, 320);
      
      LabeledRadioButton radio = new LabeledRadioButton(page0);
      radio.Text = "Radio Button!";
      radio.SetPosition(120, 410);
      
      
      ScrollControl scrollControl = new ScrollControl(page0);
      scrollControl.SetBounds(250, 30, 100, 130);
      Button but1 = new Button(scrollControl);
      but1.SetText("Twice as big");
      but1.SetBounds(0, 0, 200, 260);
      
     
      ListBox listbox = new ListBox(page0);
      listbox.AddRowString("Item One", "item1");
      listbox.AddRowString("Item Two", "item2");
      listbox.AddRowString("Item THree", "item3");
      listbox.SetPosition(350, 150);

      listbox.AddRowString("Item FOUR", "4");
      listbox.AddRowString("ITEM FIVE", "5");
      listbox.AddRowString("Item six", "6");
      listbox.AddRowString("Item seven", "7");
      listbox.AddRowString("ITEM eight", "8");
      listbox.AddRowString("Item nine", "9");
      listbox.SetSize(120, 120);
      
      ComboBox combo = new ComboBox(page1);
      combo.SetPosition(5, 140);
      combo.Width = 200;
      combo.AddItem("Option 1", "one1");
      combo.AddItem("Option 2", "one2");
      combo.AddItem("Option 3", "one3");
      combo.AddItem("Option 4", "one4");
      combo.AddItem("Option 5", "one5");
      combo.AddItem("Option 6", "one6");
      combo.AddItem("Option 7", "one7");
      
      /* Simple Tree Control */
      {
        TreeControl ctrl = new TreeControl(page0);

        ctrl.AddNode("Node One");
        TreeNode node = ctrl.AddNode("Node Two");
        {
          node.AddNode("Node Two Inside");

          node.AddNode("Eyes");
          {
            node.AddNode("Brown").AddNode("Node Two Inside").AddNode("Eyes").AddNode("Brown");
          }

          TreeNode imgnode = node.AddNode("Image");
          imgnode.SetImage("test16.png");

          imgnode = node.AddNode("Image_Kids");
          imgnode.SetImage("test16.png");
          {
            imgnode.AddNode("Kid1");
            imgnode.AddNode("Kid2");
          }

          node.AddNode("Nodes");
        }
        ctrl.AddNode("Node Three");

        node = ctrl.AddNode("Clickables");
        {
          TreeNode click = node.AddNode("Single Click");
          //click.Clicked += NodeClicked;
         // click.RightClicked += NodeClicked;

          click = node.AddNode("Double Click");
         // click.DoubleClicked += NodeDoubleClicked;
        }


        ctrl.SetBounds(1, 100, 200, 100);
        ctrl.ExpandAll();
        

        
        CrossSplitter m_splitter = new CrossSplitter(page1);
        m_splitter.SetBounds(0, 200, 200, 200);
        m_splitter.Dock = Pos.None;
        
        {
          VerticalSplitter vsplitter = new VerticalSplitter(m_splitter);
          Button button1 = new Button(vsplitter);
          button1.SetText("vertical left");
          Button button2 = new Button(vsplitter);
          button2.SetText("vertical right");
          vsplitter.SetPanel(0, button1);
          vsplitter.SetPanel(1, button2);
          m_splitter.SetPanel(0, vsplitter);
        }
        {
          HorizontalSplitter hsplitter = new HorizontalSplitter(m_splitter);
          Button button1 = new Button(hsplitter);
          button1.SetText("vertical up");
          Button button2 = new Button(hsplitter);
          button2.SetText("vertical down");
          hsplitter.SetPanel(0, button1);
          hsplitter.SetPanel(1, button2);
          m_splitter.SetPanel(1, hsplitter);
        }
        Button button3 = new Button(m_splitter);
        button3.SetText("Quad 3");
        m_splitter.SetPanel(2, button3);
        Button button4 = new Button(m_splitter);
        button4.SetText("Quad 4");
        m_splitter.SetPanel(3, button4);
        
        NumericUpDown nup = new NumericUpDown(page1);
        nup.SetPosition(350, 25);

        
        StatusBar statusBar = new StatusBar(page0);
        _lblMouseCoords = new Label(statusBar);
        _lblMouseCoords.AutoSizeToContents=false;
        _lblMouseCoords.SetText( "Mouse : ");
        _lblMouseCoords.SizeToContents();
        statusBar.AddControl(_lblMouseCoords, true);
        statusBar.SendToBack();
        //ctrl.Selected += NodeSelected;
       // ctrl.Expanded += NodeExpanded;
       // ctrl.Collapsed += NodeCollapsed;
        
      }
      
      if(parent is GwenControlCanvas)
      {
        GwenControlCanvas canvas = parent;
        canvas.MouseMovedHandler.add(new GwenControlEventHandler(MouseMoveEventHandler));
      }
      
      //listbox.MaximumSize = new Point(110, 100);
      //listbox.SizeToContents();     
     //if(listbox.Bounds.height > 100) listbox.SetSize(listbox.Bounds.width, 100);
      
     
     // _timer = new Timer.periodic(new Duration(seconds: 1), timerCallback);
   }
   
   void buttonClickHandler_showMsgBox(GwenControlBase control, GwenEventArgs args)
   {
      MessageBox msgbox = new MessageBox(Parent, "Hello, MessageBox!", "(Awesome Title)");
      
   }
   
   void MouseMoveEventHandler(GwenControlBase control, GwenEventArgs args)
   {
      if(args is GwenMouseEventArgs)
      {
        GwenMouseEventArgs margs = args;
        OnMouseMoved(margs.MouseX, margs.MouseY, 0, 0);
      }
   }
   
   void OnMouseMoved(int x, int y, int dx, int dy)
   {
     _lblMouseCoords.SetText("Mouse [$x, $y] ");
     Rectangle contentSize = _lblMouseCoords.CalcContentSize();
     if( (contentSize.width > _lblMouseCoords.Width) || (contentSize.height > _lblMouseCoords.Height))
     {
       _lblMouseCoords.SetSize(contentSize.width, contentSize.height);
       _lblMouseCoords.Parent.Invalidate();
     }
     if(Parent is GwenControlCanvas)
     {
       GwenControlCanvas canvas = Parent;
       canvas.Skin.Renderer.notifyRedrawRequested();
     }
   }
/*   
   void timerCallback(Timer timer)
   {
      if(Parent != null)
      {
        if(_cvsr.IsSkinTextureLoaded)
        {
           if( Parent is GwenControlCanvas)
           {
              (Parent as GwenControlCanvas).RenderCanvas();
           }
        }
      }
   }
   */
}