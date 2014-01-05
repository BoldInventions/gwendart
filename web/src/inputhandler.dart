part of gwendart;

class InputHandler
{
   static GwenControlBase HoveredControl;
   static GwenControlBase KeyboardFocus;
   static GwenControlBase MouseFocus;
   static const int MaxMouseButtons=5;
   static const double DoubleClickSpeed = 0.5;
   static const double KeyRepeatRate = 0.03;
   static const double KeyRepeatDelay = 0.5;
   static bool get IsLeftMouseDown => m_KeyData.LeftMouseDown;
   static bool get IsRightMouseDown => m_KeyData.RightMouseDown;
   static bool IsKeyDown(GwenKey key)
   {
     return m_KeyData.KeyState[key.value];
   }
   static bool get IsShiftDown => IsKeyDown(GwenKey.Shift);
   static bool get IsControlDown => IsKeyDown(GwenKey.Control);
   static Point MousePosition = new Point(0, 0);
   

   
   
   static bool DoSpecialKeys(GwenControlBase canvas, String chr)
   {
     if (null == KeyboardFocus) return false;
     if (KeyboardFocus.GetCanvas() != canvas) return false;
     if (!KeyboardFocus.IsVisible) return false;
     if (!IsControlDown) return false;

     if (chr == 'C' || chr == 'c')
     {
       KeyboardFocus.InputCopy(null);
       return true;
     }

     if (chr == 'V' || chr == 'v')
     {
       KeyboardFocus.InputPaste(null);
       return true;
     }

     if (chr == 'X' || chr == 'x')
     {
       KeyboardFocus.InputCut(null);
       return true;
     }

     if (chr == 'A' || chr == 'a')
     {
       KeyboardFocus.InputSelectAll(null);
       return true;
     }

     return false;
   }
   
   static bool HandleAccelerator(GwenControlBase canvas, String chr)
   {
     //Build the accelerator search string
     String accelString = "";
     if (IsControlDown)
       accelString += "CTRL+";
     if (IsShiftDown)
       accelString += "SHIFT+";
     // [omeg] todo: alt?

     accelString += chr;
     String acc = accelString;

     //Debug::Msg("Accelerator string :%S\n", accelString.c_str());)

     if (KeyboardFocus != null && KeyboardFocus.HandleAccelerator(acc))
       return true;

     if (MouseFocus != null && MouseFocus.HandleAccelerator(acc))
       return true;

     if (canvas.HandleAccelerator(acc))
       return true;

     return false;
   }
   
   static void OnMouseMoved(GwenControlBase canvas, int x, int y, int dx, int dy)
   {
     // Send input to canvas for study
     MousePosition = new Point(x, y);
     UpdateHoveredControl(canvas);
   }
   
   static void OnCanvasThink(GwenControlBase control)
   {
     if (MouseFocus != null && !MouseFocus.IsVisible)
       MouseFocus = null;

     if (KeyboardFocus != null && (!KeyboardFocus.IsVisible || !KeyboardFocus.KeyboardInputEnabled))
       KeyboardFocus = null;

     if (null == KeyboardFocus) return;
     if (KeyboardFocus.GetCanvas() != control) return;

     double time = Neutral.GetTimeInSeconds();

     //
     // Simulate Key-Repeats
     //
     for (int i = 0; i < GwenKey.Count; i++)
     {
       if (m_KeyData.KeyState[i] && m_KeyData.Target != KeyboardFocus)
       {
         m_KeyData.KeyState[i] = false;
         continue;
       }

       if (m_KeyData.KeyState[i] && time > m_KeyData.NextRepeat[i])
       {
         m_KeyData.NextRepeat[i] = Neutral.GetTimeInSeconds() + KeyRepeatRate;

         if (KeyboardFocus != null)
         {
           KeyboardFocus.InputKeyPressed(GwenKey.getKeyFromValue(i));
         }
       }
     }
   }
   
   static bool OnMouseClicked(GwenControlBase canvas, int mouseButton, bool down)
   {
     // If we click on a control that isn't a menu we want to close
     // all the open menus. Menus are children of the canvas.
     if (down && (null == HoveredControl || !HoveredControl.IsMenuComponent))
     {
       canvas.CloseMenus();
     }

     if (null == HoveredControl) return false;
     if (HoveredControl.GetCanvas() != canvas) return false;
     if (!HoveredControl.IsVisible) return false;
     if (HoveredControl == canvas) return false;

     if (mouseButton > MaxMouseButtons)
       return false;

     if (mouseButton == 0)
       m_KeyData.LeftMouseDown = down;
     else if (mouseButton == 1)
       m_KeyData.RightMouseDown = down;

     // Double click.
     // Todo: Shouldn't double click if mouse has moved significantly
     bool isDoubleClick = false;

     if (down &&
         _lastClickPos.x == MousePosition.x &&
         _lastClickPos.y == MousePosition.y &&
         (Neutral.GetTimeInSeconds() - ListLastClickTimes[mouseButton]) < DoubleClickSpeed)
     {
       isDoubleClick = true;
     }

     if (down && !isDoubleClick)
     {
       ListLastClickTimes[mouseButton] = Neutral.GetTimeInSeconds();
       _lastClickPos = new Point<int> (MousePosition.x, MousePosition.y);
     }

     if (down)
     {
       FindKeyboardFocus(HoveredControl);
     }

     HoveredControl.UpdateCursor();

     // This tells the child it has been touched, which
     // in turn tells its parents, who tell their parents.
     // This is basically so that Windows can pop themselves
     // to the top when one of their children have been clicked.
     if (down)
       HoveredControl.Touch();


     switch (mouseButton)
     {
       case 0:
         // TODO: DragAndDrop not implemented
         //if (DragAndDrop.OnMouseButton(HoveredControl, MousePosition.x, MousePosition.y, down))
         //  return true;

         if (isDoubleClick)
           HoveredControl.InputMouseDoubleClickedLeft(MousePosition.x, MousePosition.y);
         else
           HoveredControl.InputMouseClickedLeft(MousePosition.x, MousePosition.y, down);
         return true;
       

       case 1: 
       
         if (isDoubleClick)
           HoveredControl.InputMouseDoubleClickedRight(MousePosition.x, MousePosition.y);
         else
           HoveredControl.InputMouseClickedRight(MousePosition.x, MousePosition.y, down);
         return true;
       
     }

     return false;
   }

   static bool OnKeyEvent(GwenControlBase canvas, GwenKey key, bool down)
   {
     if (null == KeyboardFocus) return false;
     if (KeyboardFocus.GetCanvas() != canvas) return false;
     if (!KeyboardFocus.IsVisible) return false;

     int iKey = key.value;
     if (down)
     {
       if (!m_KeyData.KeyState[iKey])
       {
         m_KeyData.KeyState[iKey] = true;
         m_KeyData.NextRepeat[iKey] = Neutral.GetTimeInSeconds() + KeyRepeatDelay;
         m_KeyData.Target = KeyboardFocus;

         return KeyboardFocus.InputKeyPressed(key);
       }
     }
     else
     {
       if (m_KeyData.KeyState[iKey])
       {
         m_KeyData.KeyState[iKey] = false;

         // BUG BUG. This causes shift left arrow in textboxes
         // to not work. What is disabling it here breaking?
             //m_KeyData.Target = NULL;

         return KeyboardFocus.InputKeyPressed(key, false);
       }
     }

     return false;
   }

   static void UpdateHoveredControl(GwenControlBase inCanvas)
   {
     GwenControlBase hovered = inCanvas.GetControlAt(MousePosition.x, MousePosition.y);

     if (hovered != HoveredControl)
     {
       if (HoveredControl != null)
       {
         var oldHover = HoveredControl;
         HoveredControl = null;
         oldHover.InputMouseLeft();
       }

       HoveredControl = hovered;

       if (HoveredControl != null)
       {
         HoveredControl.InputMouseEntered();
       }
     }

     if (MouseFocus != null && MouseFocus.GetCanvas() == inCanvas)
     {
       if (HoveredControl != null)
       {
         var oldHover = HoveredControl;
         HoveredControl = null;
         oldHover.Redraw();
       }
       HoveredControl = MouseFocus;
     }
   }

   static void FindKeyboardFocus(GwenControlBase control)
   {
     if (null == control) return;
     if (control.KeyboardInputEnabled)
     {
       //Make sure none of our children have keyboard focus first - todo recursive
      // if (control.Children.Any(child => child == KeyboardFocus))
       for(GwenControlBase child in control.Children)
       {
          if(KeyboardFocus == child)
          {
              return;
          }
       }

       control.Focus();
       return;
     }

     FindKeyboardFocus(control.Parent);
     return;
   }
   
   static KeyData m_KeyData;
   static List<double> _lastClickTime = null;
   static List<double> get ListLastClickTimes 
   {
     if(null == _lastClickTime)
     {
       _lastClickTime = new List<double>(MaxMouseButtons);
       for(int i=0; i<MaxMouseButtons; i++) _lastClickTime[i] = 0.0;
     }
     return _lastClickTime;
   }
   static Point<int> _lastClickPos = new Point<int>(0, 0);
   
   
}
