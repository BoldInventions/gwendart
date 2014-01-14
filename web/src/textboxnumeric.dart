part of gwendart;

class TextBoxNumeric extends TextBox
{
   double _value;
   TextBoxNumeric(GwenControlBase parent) : super(parent)
   {
     AutoSizeToContents = false;
     SetText("0", false);
   }
   
   double get Value => _value;
   set Value (double d) { 
     _value = d; 
     this.Text = d.toString();
   }
   
   bool IsTextAllowed2(String str)
   {
     bool bRet = true;
     if( (str=="") || (str == "-")) return true;
     try
     {
       double.parse(str);
     } catch(err)
     {
       bRet=false;
     }
     return bRet;
   }
   
   static String stringInsert(String str, int position, String strToInsert)
   {
      int strlen= str.length;
      if(strToInsert.length == 0) return str + "";
      if(position<=0)
      {
        return strToInsert + str;
      }
      if(position >= strlen)
      {
        return str + strToInsert;
      }
      return str.substring(0, position) + strToInsert + str.substring(position);
   }
   
   bool IsTextAllowed(String str, int position)
   {
     String newText = stringInsert(this.Text, position, str);
     return IsTextAllowed2(str);
   }
   
   void OnTextChanged()
   {
     if(this.Text==null || this.Text == "-")
     {
       _value = 0.0;
     } else
     {
       try
       {
         _value = double.parse(this.Text);
       } catch(err)
       {
         _value = 0.0;
       }
     }
   }
   
   void SetText(String str, [bool doEvents=true])
   {
     if(IsTextAllowed2(str))
     {
       super.SetText(str, doEvents);
     }
   }
}