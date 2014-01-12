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
      Label label = new Label(this);
      label.SetPosition(200, 50);
      label.SetText("Hello, Label!");
      /*
      Button button = new Button(this);
      button.SetSize(24, 24);
      button.SetText("ok");
      button.SetPosition(300, 10);
      button.MouseInputEnabled=true;
      button.KeyboardInputEnabled=true;
   
      WindowControl window = new WindowControl(this, "My Window");
      window.SetSize(300, 100);
      window.SetPosition(1, 15);
      
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
      */
      /*
      ScrollControl scrollControl = new ScrollControl(this);
      scrollControl.SetBounds(250, 1, 200, 230);
      Button but1 = new Button(scrollControl);
      but1.SetText("Twice as big");
      but1.SetBounds(0, 0, 400, 430);
      */
     
      ListBox listbox = new ListBox(this);
      listbox.AddRowString("Item One", "item1");
      listbox.AddRowString("Item Two", "item2");
      listbox.AddRowString("Item THree", "item3");
      listbox.SetPosition(350, 15);

      listbox.AddRowString("Item FOUR", "4");
      listbox.AddRowString("ITEM FIVE", "5");
      listbox.AddRowString("Item six", "6");
      listbox.AddRowString("Item seven", "7");
      listbox.AddRowString("ITEM eight", "8");
      listbox.AddRowString("Item nine", "9");
      listbox.SetSize(120, 120);
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