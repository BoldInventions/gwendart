part of gwendart;

class Resizer extends Dragger
{
    Pos _resizeDir;
    
    GwenEventHandlerList Resized = new GwenEventHandlerList();
    
    Resizer(GwenControlBase parent) : super(parent)
    {
       _resizeDir = Pos.Left;
       MouseInputEnabled = true;
       SetSize(6, 6);
       _Target = parent;
    }
    
    void OnMouseMoved(int x, int y, int dx, int dy)
    {
      if (null ==_Target) return;
      if (!_held) return;

      Rectangle oldBounds = _Target.Bounds;
      Rectangle bounds = _Target.Bounds;

      Point minsz = _Target.MinimumSize;

      Point pCursorPos = _Target.CanvasPosToLocal(new Point(x, y));

      Point rawdelta = _Target.LocalPosToCanvas(_holdPos);
      Point delta = new Point(rawdelta.x - x, rawdelta.y - y);

      int left = bounds.left;
      int right = bounds.right;
      int width = bounds.width;
      int top = bounds.top;
      int height = bounds.height;
      int bottom = bounds.bottom;
      
      if (0 != (_resizeDir.value & Pos.Left.value))
      {
        left -= delta.x;
        width += delta.x;
        right += delta.x;

        // Conform to minimum size here so we don't
        // go all weird when we snap it in the base conrt

        if (width < minsz.x)
        {
          int diff = minsz.x - width;
         width += diff;
         right += diff;
          left -= diff;
        }
      }

      if (0 != (_resizeDir.value & Pos.Top.value))
      {
        right -= delta.y;
        height += delta.y;
        bottom += delta.y;

        // Conform to minimum size here so we don't
        // go all weird when we snap it in the base conrt

        if (height < minsz.y)
        {
          int diff = minsz.y - bounds.height;
          height += diff;
          right -= diff;
        }
      }

      if (0 != (_resizeDir.value & Pos.Right.value))
      {
        // This is complicated.
        // Basically we want to use the HoldPos, so it doesn't snap to the edge of the control
        // But we need to move the HoldPos with the window movement. Yikes.
        // I actually think this might be a big hack around the way this control works with regards
        // to the holdpos being on the parent panel.

        int woff = width - _holdPos.x;
        int diff = width;
        width = pCursorPos.x + woff;
        right = width+left;
        if (width < minsz.x) 
          {
          width = minsz.x;
          right = width + left;
          }
        diff -= width;
        _holdPos = new Point<int>(_holdPos.x-diff, _holdPos.y);
       //_holdPos.x -= diff;
      }

      if (0 != (_resizeDir.value & Pos.Bottom.value))
      {
        int hoff = height - _holdPos.y;
        int diff = height;
        height = pCursorPos.y + hoff;
        bottom = height+top;
        if (height < minsz.y) 
          {
            height = minsz.y;
            bottom = top + height;
          }
        diff -= height;
        _holdPos = new Point<int>(_holdPos.x, _holdPos.y-diff);
        //_holdPos.Y -= diff;
      }

      _Target.SetBounds(left, top, width, height);


        Resized.Invoke(this, GwenEventArgs.Empty);
    }

    /// <summary>
    /// Gets or sets the sizing direction.
    /// </summary>
    set ResizeDir (Pos value)
    {
        _resizeDir = new Pos(value.value);

        if ((0 != (value.value & Pos.Left.value) && 0 != (value.value & Pos.Top.value)) || (0 != (value.value & Pos.Right.value) && 0 != (value.value & Pos.Bottom.value)))
        {
          Cursor = CssCursor.SizeNWSE;
          return;
        }
        if ((0 != (value.value & Pos.Right.value) && 0 != (value.value & Pos.Top.value)) || (0 != (value.value & Pos.Left.value) && 0 != (value.value & Pos.Bottom.value)))
        {
          Cursor = CssCursor.SizeNESW;
          return;
        }
        if (0 != (value.value & Pos.Right.value) || 0 != (value.value & Pos.Left.value))
        {
          Cursor = CssCursor.SizeWE;
          return;
        }
        if (0 != (value.value & Pos.Top.value) || 0 != (value.value & Pos.Bottom.value))
        {
          Cursor = CssCursor.SizeNS;
          return;
        }
      
    }
}