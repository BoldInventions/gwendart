part of gwendart;

class TextBox extends Label
{
    bool _selectAll=false;
    int _cursorPos=0;
    int _cursorEnd=0;
    Rectangle m_SelectionBounds=new Rectangle(0,0,0,0);
    Rectangle m_CaretBounds=new Rectangle(0,0,0,0);
    double m_LastInputTime=0.0;
    
    bool get AccelOnlyFocus => true;
    bool get NeedsInputChars => true;
    
    bool get SelectAllOnFocus => _selectAll;
    set SelectAllOnFocus (bool value)
    {
      _selectAll = value;
      if(value) OnSelectAll(this, GwenEventArgs.Empty);
    }
    
    bool get HasSelection => _cursorPos!=_cursorEnd;
    
    GwenEventHandlerList TextChanged = new GwenEventHandlerList();
    
    GwenEventHandlerList SubmitPressed = new GwenEventHandlerList();
    
    int get CursorPos => _cursorPos;
    set CursorPos ( int value)
    {
      if(_cursorPos == value) return;
      _cursorPos = value;
      RefreshCursorBounds();
    }
    
    int get CursorEnd => _cursorEnd;
    set CursorEnd ( int value)
    {
      if(value == _cursorEnd) return;
      _cursorEnd = value;
      RefreshCursorBounds();
    }
    
    bool IsTextAllowed(String text, int position)
    {
      return true;
    }
    
    TextBox(GwenControlBase parent) : super(parent)
    {
      AutoSizeToContents = false;
      SetSize(200, 20);
      
      MouseInputEnabled = true;
      KeyboardInputEnabled=true;
      
      Alignment = new Pos(Pos.Left.value | Pos.CenterV.value);
      TextPadding = new GwenPadding(4, 2, 4, 2);
      
      _cursorPos = 0;
      _cursorEnd = 0;
      
      TextColor = new Color.argb(255, 50, 50, 50);
      
      IsTabable = true;
      
      // TODO: Implement Clipboard
      /*
      AddAccelerator("Ctrl + C", OnCopy);
      AddAccelerator("Ctrl + X", OnCut);
      AddAccelerator("Ctrl + V", OnPaste);
      AddAccelerator("Ctrl + A", OnSelectAll);
      */
      
      
    }

        /// <summary>
        /// Renders the focus overlay.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void RenderFocus(GwenSkinBase skin)
        {
            // nothing
        }

        /// <summary>
        /// Handler for text changed event.
        /// </summary>
        void OnTextChanged()
        {
            super.OnTextChanged();

            if (_cursorPos > TextLength) _cursorPos = TextLength;
            if (_cursorEnd > TextLength) _cursorEnd = TextLength;

            if (TextChanged != null)
                TextChanged.Invoke(this, GwenEventArgs.Empty);
        }

        /// <summary>
        /// Handler for character input event.
        /// </summary>
        /// <param name="chr">Character typed.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnChar(String chr)
        {
            super.OnChar(chr);

            if (chr == '\t') return false;

            InsertText(chr);
            return true;
        }

        static String insertIntoString(String orig, int pos, String strToInsert)
        {
          if(0>=pos)
          {
             return strToInsert + orig;
          }
          if(pos >= orig.length)
          {
            return orig + strToInsert;
          }
          return orig.substring(0, pos) + strToInsert + orig.substring(pos, orig.length);
        }
        /// <summary>
        /// Inserts text at current cursor position, erasing selection if any.
        /// </summary>
        /// <param name="text">Text to insert.</param>
        void InsertText(String text)
        {
            // TODO: Make sure fits (implement maxlength)

            if (HasSelection)
            {
                EraseSelection();
            }

            if (_cursorPos > TextLength)
                _cursorPos = TextLength;

            if (!IsTextAllowed(text, _cursorPos))
                return;

            String str = super.Text;
            //str = str.insert(_cursorPos, text);
            str = TextBox.insertIntoString(str, _cursorPos, text);
            SetText(str);

            _cursorPos += text.length;
            _cursorEnd = _cursorPos;

            RefreshCursorBounds();
        }

        /// <summary>
        /// Renders the control using specified skin.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void Render(GwenSkinBase skin)
        {
            super.Render(skin);

            if (ShouldDrawBackground)
                skin.DrawTextBox(this);

            if (!HasFocus) return;

            // Draw selection.. if selected..
            if (_cursorPos != _cursorEnd)
            {
                skin.Renderer.DrawColor = new Color.argb(200, 50, 170, 255);
                skin.Renderer.drawFilledRect(m_SelectionBounds);
            }

            // Draw caret
            double time = Neutral.GetTimeInSeconds() - m_LastInputTime;

            if ((time % 1.0) <= 0.5)
            {
                skin.Renderer.DrawColor = Color.Black;
                skin.Renderer.drawFilledRect(m_CaretBounds);
            }
        }

        void RefreshCursorBounds()
        {
            m_LastInputTime = Neutral.GetTimeInSeconds();

            MakeCaretVisible();

            Point pA = GetCharacterPosition(_cursorPos);
            Point pB = GetCharacterPosition(_cursorEnd);

            int left = min(pA.x, pB.x);
            int top = TextY-1;
            int width = max(pA.x, pB.x) - left;
            int height = TextHeight+2;
            m_SelectionBounds = new Rectangle(left, top, width, height);

            //m_CaretBounds.X = pA.X;
            //m_CaretBounds.Y = TextY - 1;
            //m_CaretBounds.Width = 1;
            //m_CaretBounds.Height = TextHeight + 2;
            m_CaretBounds = new Rectangle(pA.x, TextY - 1, 1, TextHeight+2);


            Redraw();
        }

        /// <summary>
        /// Handler for Paste event.
        /// </summary>
        /// <param name="from">Source control.</param>
        void OnPaste(GwenControlBase from, GwenEventArgs args)
        {
            super.OnPaste(from, args);
            InsertText(Neutral.GetClipboardText());
        }

        /// <summary>
        /// Handler for Copy event.
        /// </summary>
        /// <param name="from">Source control.</param>
        void OnCopy(GwenControlBase from, GwenEventArgs args)
        {
            if (!HasSelection) return;
            super.OnCopy(from, args);

            Neutral.SetClipboardText(GetSelection());
        }

        /// <summary>
        /// Handler for Cut event.
        /// </summary>
        /// <param name="from">Source control.</param>
        void OnCut(GwenControlBase from, GwenEventArgs args)
        {
            if (!HasSelection) return;
            super.OnCut(from, args);

            Neutral.SetClipboardText(GetSelection());
            EraseSelection();
        }

        /// <summary>
        /// Handler for Select All event.
        /// </summary>
        /// <param name="from">Source control.</param>
        void OnSelectAll(GwenControlBase from, GwenEventArgs args)
        {
            //super.OnSelectAll(from);
            _cursorEnd = 0;
            _cursorPos = TextLength;

            RefreshCursorBounds();
        }

        /// <summary>
        /// Handler invoked on mouse double click (left) event.
        /// </summary>
        /// <param name="x">X coordinate.</param>
        /// <param name="y">Y coordinate.</param>
        void OnMouseDoubleClickedLeft(int x, int y)
        {
            //super.OnMouseDoubleClickedLeft(x, y);
      OnSelectAll(this, GwenEventArgs.Empty);
        }

        /// <summary>
        /// Handler for Return keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyReturn(bool down)
        {
            super.OnKeyReturn(down);
            if (down) return true;

            OnReturn();

            // Try to move to the next control, as if tab had been pressed
            OnKeyTab(true);

            // If we still have focus, blur it.
            if (HasFocus)
            {
                Blur();
            }

            return true;
        }

        /// <summary>
        /// Handler for Backspace keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyBackspace(bool down)
        {
            super.OnKeyBackspace(down);

            if (!down) return true;
            if (HasSelection)
            {
                EraseSelection();
                return true;
            }

            if (_cursorPos == 0) return true;
        print( "textbox.OnKeyBackspace curpos: $_cursorPos");
            DeleteText(_cursorPos - 1, 1);

            return true;
        }

        /// <summary>
        /// Handler for Delete keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyDelete(bool down)
        {
            super.OnKeyDelete(down);
            if (!down) return true;
            if (HasSelection)
            {
                EraseSelection();
                return true;
            }

            if (_cursorPos >= TextLength) return true;

            DeleteText(_cursorPos, 1);

            return true;
        }

        /// <summary>
        /// Handler for Left Arrow keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyLeft(bool down)
        {
            super.OnKeyLeft(down);
            if (!down) return true;

            if (_cursorPos > 0)
                _cursorPos--;

            if (!InputHandler.IsShiftDown)
            {
                _cursorEnd = _cursorPos;
            }

            RefreshCursorBounds();
            return true;
        }

        /// <summary>
        /// Handler for Right Arrow keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyRight(bool down)
        {
            super.OnKeyRight(down);
            if (!down) return true;

            if (_cursorPos < TextLength)
                _cursorPos++;

            if (!InputHandler.IsShiftDown)
            {
                _cursorEnd = _cursorPos;
            }

            RefreshCursorBounds();
            return true;
        }

        /// <summary>
        /// Handler for Home keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyHome(bool down)
        {
            super.OnKeyHome(down);
            if (!down) return true;
            _cursorPos = 0;

            if (!InputHandler.IsShiftDown)
            {
                _cursorEnd = _cursorPos;
            }

            RefreshCursorBounds();
            return true;
        }

        /// <summary>
        /// Handler for End keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyEnd(bool down)
        {
            super.OnKeyEnd(down);
            _cursorPos = TextLength;

            if (!InputHandler.IsShiftDown)
            {
                _cursorEnd = _cursorPos;
            }

            RefreshCursorBounds();
            return true;
        }

        /// <summary>
        /// Returns currently selected text.
        /// </summary>
        /// <returns>Current selection.</returns>
        String GetSelection()
        {
            if (!HasSelection) return "";

            int start = min(_cursorPos, _cursorEnd);
            int end = max(_cursorPos, _cursorEnd);

            String str = super.Text;
            return str.substring(start, end - start);
        }
        static String removeFromString(String orig, int startPos, int length)
        {
          if(length <= 0) return orig;
          if(startPos >= orig.length)return orig;
          if(startPos <= 0) return orig.substring(length);
          if(startPos + length >= orig.length) return orig.substring(0, startPos); 
          int olen = orig.length;
          return orig.substring(0, startPos) + orig.substring(startPos+length, olen-1);
        }
        /// <summary>
        /// Deletes text.
        /// </summary>
        /// <param name="startPos">Starting cursor position.</param>
        /// <param name="length">Length in characters.</param>
        void DeleteText(int startPos, int length)
        {
            String str = super.Text;
      print ( "textbox.DeleteText('$str', $startPos, $length)");
            str = removeFromString(str, startPos, length);
      print ( "Result: $str");
            SetText(str);

            print( "_cursorPos: $_cursorPos, startPos: $startPos");
            if (_cursorPos > startPos)
            {
                _cursorEnd = _cursorPos - length;
                CursorPos = _cursorPos - length;
      print ( " Setting _cursorPos to $CursorPos");
            }
      print( " Settinng end to $_cursorPos");
            CursorEnd = _cursorPos;
            RefreshCursorBounds();
        }

        /// <summary>
        /// Deletes selected text.
        /// </summary>
        void EraseSelection()
        {
            int start = min(_cursorPos, _cursorEnd);
            int end = max(_cursorPos, _cursorEnd);

            DeleteText(start, end - start);

            // Move the cursor to the start of the selection, 
            // since the end is probably outside of the string now.
            _cursorPos = start;
            _cursorEnd = start;
        }

        /// <summary>
        /// Handler invoked on mouse click (left) event.
        /// </summary>
        /// <param name="x">X coordinate.</param>
        /// <param name="y">Y coordinate.</param>
        /// <param name="down">If set to <c>true</c> mouse button is down.</param>
        void OnMouseClickedLeft(int x, int y, bool down)
        {
            super.OnMouseClickedLeft(x, y, down);
            if (_selectAll)
            {
                OnSelectAll(this, GwenEventArgs.Empty);
                //m_SelectAll = false;
                return;
            }

            int c = GetClosestCharacter(x, y).x;

            if (down)
            {
                CursorPos = c;

                if (!InputHandler.IsShiftDown)
                    CursorEnd = c;

                InputHandler.MouseFocus = this;
            }
            else
            {
                if (InputHandler.MouseFocus == this)
                {
                    CursorPos = c;
                    InputHandler.MouseFocus = null;
                }
            }
        }

        /// <summary>
        /// Handler invoked on mouse moved event.
        /// </summary>
        /// <param name="x">X coordinate.</param>
        /// <param name="y">Y coordinate.</param>
        /// <param name="dx">X change.</param>
        /// <param name="dy">Y change.</param>
        void OnMouseMoved(int x, int y, int dx, int dy)
        {
            super.OnMouseMoved(x, y, dx, dy);
            if (InputHandler.MouseFocus != this) return;

            int c = GetClosestCharacter(x, y).x;

            CursorPos = c;
        }

        void MakeCaretVisible()
        {
            int caretPos = GetCharacterPosition(_cursorPos).x - TextX;

            // If the caret is already in a semi-good position, leave it.
            {
                int realCaretPos = caretPos + TextX;
                if (realCaretPos > Width * 0.1 && realCaretPos < Width * 0.9)
                    return;
            }

            // The ideal position is for the caret to be right in the middle
            int idealx = (-caretPos + Width * 0.5).toInt();

            // Don't show too much whitespace to the right
            if (idealx + TextWidth < Width - TextPadding.Right)
                idealx = -TextWidth + (Width - TextPadding.Right);

            // Or the left
            if (idealx > TextPadding.Left)
                idealx = TextPadding.Left;

            SetTextPosition(idealx, TextY);
        }

        /// <summary>
        /// Lays out the control's interior according to alignment, padding, dock etc.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void Layout(GwenSkinBase skin)
        {
            super.Layout(skin);

            RefreshCursorBounds();
        }

        /// <summary>
        /// Handler for the return key.
        /// </summary>
        void OnReturn()
        {
            if (SubmitPressed != null)
        SubmitPressed.Invoke(this, GwenEventArgs.Empty);
        }
}
