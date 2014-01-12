part of gwendart;

class TableRow extends GwenControlBase
{
  static const int MaxColumns=5;
  int _columnCount;
  bool _evenRow;
  List<Label> _columns;
  Label _GetColumn(int index)
  {
    return _columns[index];
  }
  
  GwenEventHandlerList Selected=new GwenEventHandlerList();
  
  
  int get ColumnCount => _columnCount;
  
  set ColumnCount(int value) { SetColumnCount(value); }
  
  bool get EvenRow => _evenRow;
  set EvenRow(bool value) { _evenRow=value;  }
  
  String get Text => GetText(0);
  set Text (String value) { SetCellText(0, value); }
  
  TableRow(GwenControlBase parent) : super(parent)
  {
    _columns = new List<Label>(MaxColumns);
    _columnCount=0;
    KeyboardInputEnabled = false;
    _evenRow = false;
  }
  
  /// <summary>
  /// Sets the number of columns.
  /// </summary>
  /// <param name="columnCount">Number of columns.</param>
  void SetColumnCount(int columnCount)
  {
    if (columnCount == _columnCount) return;

    if (columnCount >= MaxColumns)
      throw new ArgumentError("Invalid column count, $columnCount");

    for (int i = 0; i < MaxColumns; i++)
    {
      if (i < columnCount)
      {
        if (null == _columns[i])
        {
          _columns[i] = new Label(this);
          _columns[i].Padding = GwenPadding.Three;
          _columns[i].Margin = new GwenMargin(0, 0, 2, 0); // to separate them slightly
          _columns[i].AutoSizeToContents = false;
          if (i == columnCount - 1)
          {
            // last column fills remaining space
            _columns[i].Dock = Pos.Fill;
          }
          else
          {
            _columns[i].Dock = Pos.Left;
          }
        }
      }
      else if (null != _columns[i])
      {
        RemoveChild(_columns[i], true);
        _columns[i] = null;
      }

      _columnCount = columnCount;
    }
  }
  

  /// <summary>
  /// Sets the column width (in pixels).
  /// </summary>
  /// <param name="column">Column index.</param>
  /// <param name="width">Column width.</param>
  void SetColumnWidth(int column, int width)
  {
    if (null == _columns[column]) 
      return;
    if (_columns[column].Width == width) 
      return;

    _columns[column].Width = width;
  }

  /// <summary>
  /// Sets the text of a specified cell.
  /// </summary>
  /// <param name="column">Column number.</param>
  /// <param name="text">Text to set.</param>
  void SetCellText(int column, String text)
  {
    if (null == _columns[column]) 
      return;

    _columns[column].Text = text;
  }

  /// <summary>
  /// Sets the contents of a specified cell.
  /// </summary>
  /// <param name="column">Column number.</param>
  /// <param name="control">Cell contents.</param>
  /// <param name="enableMouseInput">Determines whether mouse input should be enabled for the cell.</param>
  void SetCellContents(int column, GwenControlBase control,[ bool enableMouseInput = false])
  {
    if (null == _columns[column]) 
      return;

    control.Parent = _columns[column];
    _columns[column].MouseInputEnabled = enableMouseInput;
  }

  /// <summary>
  /// Gets the contents of a specified cell.
  /// </summary>
  /// <param name="column">Column number.</param>
  /// <returns>Control embedded in the cell.</returns>
  GwenControlBase GetCellContents(int column)
  {
    return _columns[column];
  }

  void OnRowSelected()
  {
    if (Selected != null)
      Selected.Invoke(this, new ItemSelectedEventArgs(this));
  }

  /// <summary>
  /// Sizes all cells to fit contents.
  /// </summary>
  void SizeToContents()
  {
    int width = 0;
    int height = 0;

    for (int i = 0; i < _columnCount; i++)
    {
      if (null == _columns[i]) 
        continue;

      // Note, more than 1 child here, because the 
      // label has a child built in ( The Text )
      if (_columns[i].Children.length > 1)
      {
        _columns[i].SizeToChildren();
      }
      else
      {
        _columns[i].SizeToContents();
      }
      
      //if (i == _columnCount - 1) // last column
      //    _columns[i].Width = Parent.Width - width; // fill if not autosized

      width += _columns[i].Width + _columns[i].Margin.Left + _columns[i].Margin.Right;
      height = max(height, _columns[i].Height + _columns[i].Margin.Top + _columns[i].Margin.Bottom);
    }

    SetSize(width, height);
  }

  /// <summary>
  /// Sets the text color for all cells.
  /// </summary>
  /// <param name="color">Text color.</param>
  void SetTextColor(Color color)
  {
    for (int i = 0; i < _columnCount; i++)
    {
      if (null == _columns[i]) continue;
      _columns[i].TextColor = color;
    }
  }

  /// <summary>
  /// Returns text of a specified row cell (default first).
  /// </summary>
  /// <param name="column">Column index.</param>
  /// <returns>Column cell text.</returns>
  String GetText([int column = 0])
  {
    return _columns[column].Text;
  }

  /// <summary>
  /// Handler for Copy event.
  /// </summary>
  /// <param name="from">Source control.</param>
  void OnCopy(GwenControlBase from, GwenEventArgs args)
  {
    Neutral.SetClipboardText(this.Text);
  }
  
}