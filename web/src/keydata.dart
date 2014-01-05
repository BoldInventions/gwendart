part of gwendart;

class KeyData
{
   final List<bool> KeyState;
   final List<double> NextRepeat;
   GwenControlBase Target;
   bool LeftMouseDown;
   bool RightMouseDown;
   
   
   KeyData() : KeyState = new List<bool>(), NextRepeat= new List<double>()
       {
              Target = null;
              LeftMouseDown = false;
              RightMouseDown = false;
       }
}