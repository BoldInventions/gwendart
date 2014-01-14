import 'dart:html';
import 'src/gwendart.dart';

class TestDockBase extends DockBase
{
  static const String SkinImageFilename = "DefaultSkin.png";
   GwenControlBase _lastControl;
   double Fps;
   String Note;
//   Timer _timer;
   final CanvasRenderer _cvsr;
   
   TestDockBase(CanvasRenderer cvsr, 
       GwenControlBase parent, int width, int height) : _cvsr=cvsr, super(parent)
   {
      Dock = Pos.Fill;
      SetSize(width, height);
      
      MenuStrip menu = new MenuStrip(this);
      MenuItem root = menu.AddItem("File");
      root.MyMenu.AddItem("Load", "test16.png");
      root.MyMenu.AddItem("Save");
      root.MyMenu.AddItem("Save As..");
      root.MyMenu.AddItem("Exit");
      
      MenuItem editroot = menu.AddItem("Edit");
      MenuItem editSweetMode = editroot.MyMenu.AddItem("Sweet Mode");
      editSweetMode.IsCheckable = true;
      editSweetMode.IsChecked = true;
      MenuItem editChalky = editroot.MyMenu.AddItem("Chalky");
      editChalky.IsCheckable = true;
      
      Label label = new Label(this);
      label.SetPosition(200, 50);
      label.SetText("Hello, Label!");
      
      Button button = new Button(this);
      button.SetSize(24, 24);
      button.SetText("ok");
      button.SetPosition(485, 40);
      button.MouseInputEnabled=true;
      button.KeyboardInputEnabled=true;
   
      WindowControl window = new WindowControl(this, "My Window");
      window.SetSize(220, 100);
      window.SetPosition(1, 5);
      
      TextBox textBox = new TextBox(this);
      textBox.Text = "Hello";
      textBox.AutoSizeToContents = false;
      textBox.SetPosition(13, 490);
      
      LabeledCheckBox ckbox = new LabeledCheckBox(this);
      ckbox.Text = "Awesomeness";
      ckbox.SetPosition(12, 470);
      
     // GroupBox gb = new GroupBox(this);
      //gb.Text = "Group Box!";
     // gb.SetBounds(1, 350, 220, 150);
      RadioButtonGroup rbGroup = new RadioButtonGroup(this);
      rbGroup.SetText("Options!");
      rbGroup.AddOption("option 1", "opName1");
      rbGroup.AddOption("Optioh 2", "opName2");
      rbGroup.AddOption("option 3", "opName3");
      rbGroup.SetPosition(260, 350);
      
      LabeledRadioButton radio = new LabeledRadioButton(this);
      radio.Text = "Radio Button!";
      radio.SetPosition(120, 440);
      
      
      ScrollControl scrollControl = new ScrollControl(this);
      scrollControl.SetBounds(250, 30, 100, 130);
      Button but1 = new Button(scrollControl);
      but1.SetText("Twice as big");
      but1.SetBounds(0, 0, 200, 260);
      
     
      ListBox listbox = new ListBox(this);
      listbox.AddRowString("Item One", "item1");
      listbox.AddRowString("Item Two", "item2");
      listbox.AddRowString("Item THree", "item3");
      listbox.SetPosition(350, 350);

      listbox.AddRowString("Item FOUR", "4");
      listbox.AddRowString("ITEM FIVE", "5");
      listbox.AddRowString("Item six", "6");
      listbox.AddRowString("Item seven", "7");
      listbox.AddRowString("ITEM eight", "8");
      listbox.AddRowString("Item nine", "9");
      listbox.SetSize(120, 120);
      
      ComboBox combo = new ComboBox(this);
      combo.SetPosition(5, 170);
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
        TreeControl ctrl = new TreeControl(this);

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


        ctrl.SetBounds(1, 130, 200, 100);
        ctrl.ExpandAll();
        

        
        CrossSplitter m_splitter = new CrossSplitter(this);
        m_splitter.SetBounds(0, 230, 200, 200);
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
        
        NumericUpDown nup = new NumericUpDown(this);
        nup.SetPosition(350, 25);
        

        //ctrl.Selected += NodeSelected;
       // ctrl.Expanded += NodeExpanded;
       // ctrl.Collapsed += NodeCollapsed;
        
      }
      
      //listbox.MaximumSize = new Point(110, 100);
      //listbox.SizeToContents();     
     //if(listbox.Bounds.height > 100) listbox.SetSize(listbox.Bounds.width, 100);
      
     
     // _timer = new Timer.periodic(new Duration(seconds: 1), timerCallback);
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