part of gwendart;

class KeyData
{
   final List<bool> KeyState;
   final List<double> NextRepeat;
   GwenControlBase Target;
   bool LeftMouseDown;
   bool RightMouseDown;
   
   
   KeyData() : KeyState = new List<bool>(GwenKey.Count.value), NextRepeat= new List<double>(GwenKey.Count.value)
       {
              Target = null;
              LeftMouseDown = false;
              RightMouseDown = false;
       }
}