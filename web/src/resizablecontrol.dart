part of gwendart;


class ResizableEventHandler extends GwenEventHandler
{
  final ResizableControl _control;

  void Invoke(GwenControlBase control, var args)
  {
    _control.OnResized(control, args);
  }
  
  ResizableEventHandler(ResizableControl control) : _control = control
  {
    
  }
}


class ResizableControl extends GwenControlBase
{
   bool ClampMovement;
   final List<Resizer> _resizer;
  
   GwenEventHandlerList Resized = new GwenEventHandlerList();
   ResizableEventHandler _onResizeHandler;

   
   void OnResized(GwenControlBase control, GwenEventArgs args)
   {
      Resized.Invoke(this, GwenEventArgs.Empty);
   }
   
   Resizer GetResizer(int i)
   {
     return _resizer[i];
   }
   
   void DisableResizing()
   {
     for(int i=0; i<10; i++)
     {
       if(i==0) continue;
       if(i==5) continue;
       if(null != _resizer[i])
       {
         _resizer[i].MouseInputEnabled =false;
         _resizer[i].IsHidden=true;
         Padding = new GwenPadding(_resizer[i].Width, _resizer[i].Width, _resizer[i].Width, _resizer[i].Width);
       }
     }
   }
   
   void EnableResizing()
   {
     for(int i=0; i<10; i++)
     {
       if(i==0) continue;
       if(i==5) continue;
       if(null != _resizer[i])
       {
         _resizer[i].MouseInputEnabled =true;
         _resizer[i].IsHidden=false;
         Padding = new GwenPadding(0, 0, 0, 0);
       }
     }
   }
   
  ResizableControl(GwenControlBase parent) : _resizer = new List<Resizer>(),  super(parent)
  {
    ClampMovement=false;
    MinimumSize = new Point(5, 5);
    _onResizeHandler = new ResizableEventHandler(this);
    for(int i=0; i<10; i++)
    {
      switch(i)
      {
        case 2:
      _resizer[2] = new Resizer(this);
      _resizer[2].Dock = Pos.Bottom;
      _resizer[2].ResizeDir = Pos.Bottom;
      _resizer[2].Resized.add(_onResizeHandler);;
      _resizer[2]._Target = this;
      break;

        case 1:
      _resizer[1] = new Resizer(_resizer[2]);
      _resizer[1].Dock = Pos.Left;
      _resizer[1].ResizeDir = Pos.Bottom | Pos.Left;
      _resizer[1].Resized.add(_onResizeHandler);;
      _resizer[1]._Target = this;
      break;

        case 3:
      _resizer[3] = new Resizer(_resizer[2]);
      _resizer[3].Dock = Pos.Right;
      _resizer[3].ResizeDir = Pos.Bottom | Pos.Right;
      _resizer[3].Resized.add(_onResizeHandler);;
      _resizer[3]._Target = this;
      break;

        case 8:
      _resizer[8] = new Resizer(this);
      _resizer[8].Dock = Pos.Top;
      _resizer[8].ResizeDir = Pos.Top;
      _resizer[8].Resized.add(_onResizeHandler);;
      _resizer[8]._Target = this;
      break;

        case 7:
      _resizer[7] = new Resizer(_resizer[8]);
      _resizer[7].Dock = Pos.Left;
      _resizer[7].ResizeDir = Pos.Left | Pos.Top;
      _resizer[7].Resized.add(_onResizeHandler);;
      _resizer[7]._Target = this;
      break;

        case 9:
      _resizer[9] = new Resizer(_resizer[8]);
      _resizer[9].Dock = Pos.Right;
      _resizer[9].ResizeDir = Pos.Right | Pos.Top;
      _resizer[9].Resized.add(_onResizeHandler);;
      _resizer[9]._Target = this;
      break;

        case 4:
      _resizer[4] = new Resizer(this);
      _resizer[4].Dock = Pos.Left;
      _resizer[4].ResizeDir = Pos.Left;
      _resizer[4].Resized.add(_onResizeHandler);;
      _resizer[4]._Target = this;
      break;

        case 6:
      _resizer[6] = new Resizer(this);
      _resizer[6].Dock = Pos.Right;
      _resizer[6].ResizeDir = Pos.Right;
      _resizer[6].Resized.add(_onResizeHandler);;
      _resizer[6]._Target = this;
      break;
        default:
          break;
      }
    }
    
    
  }
}