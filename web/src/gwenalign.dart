part of gwendart;



    /// <summary>
    /// Utility class for manipulating control's position according to its parent. Rarely needed, use control.Dock.
    /// </summary>
    class Align
    {
        /// <summary>
        /// Centers the control inside its parent.
        /// </summary>
        /// <param name="control">Control to center.</param>
        static void Center(GwenControlBase control)
        {
            GwenControlBase parent = control.Parent;
            if (parent == null) 
                return;
            control.SetPositionDbl(
                parent.Padding.Left + (((parent.Width - parent.Padding.Left - parent.Padding.Right) - control.Width)/2),
                (parent.Height - control.Height)/2);
        }

        /// <summary>
        /// Moves the control to the left of its parent.
        /// </summary>
        /// <param name="control"></param>
        static void AlignLeft(GwenControlBase control)
        {
            GwenControlBase parent = control.Parent;
            if (null == parent) return;

            control.SetPosition(parent.Padding.Left, control.Y);
        }

        /// <summary>
        /// Centers the control horizontally inside its parent.
        /// </summary>
        /// <param name="control"></param>
        static void CenterHorizontally(GwenControlBase control)
        {
            GwenControlBase parent = control.Parent;
            if (null == parent) return;


            control.SetPositionDbl(parent.Padding.Left + (((parent.Width - parent.Padding.Left - parent.Padding.Right) - control.Width) / 2), control.Y.toDouble());
        }

        /// <summary>
        /// Moves the control to the right of its parent.
        /// </summary>
        /// <param name="control"></param>
        static void AlignRight(GwenControlBase control)
        {
            GwenControlBase parent = control.Parent;
            if (null == parent) return;


            control.SetPosition(parent.Width - control.Width - parent.Padding.Right, control.Y);
        }

        /// <summary>
        /// Moves the control to the top of its parent.
        /// </summary>
        /// <param name="control"></param>
        static void AlignTop(GwenControlBase control)
        {
            control.SetPosition(control.X, 0);
        }

        /// <summary>
        /// Centers the control vertically inside its parent.
        /// </summary>
        /// <param name="control"></param>
        static void CenterVertically(GwenControlBase control)
        {
            GwenControlBase parent = control.Parent;
            if (null == parent) return;

            control.SetPosition(control.X, ((parent.Height - control.Height) / 2).toInt());
        }

        /// <summary>
        /// Moves the control to the bottom of its p  /// </summary>
        /// <param name="control"></param>
        static void AlignBottom(GwenControlBase control)
        {
            GwenControlBase parent = control.Parent;
            if (null == parent) return;

            control.SetPosition(control.X, parent.Height - control.Height);
        }

        /// <summary>
        /// Places the control below other control (left aligned), taking margins into account.
        /// </summary>
        /// <param name="control">Control to place.</param>
        /// <param name="anchor">Anchor control.</param>
        /// <param name="spacing">Optional spacing.</param>
        static void PlaceDownLeft(GwenControlBase control, GwenControlBase anchor, [int spacing = 0])
        {
            control.SetPosition(anchor.X, anchor.Bottom + spacing);
        }

        /// <summary>
        /// Places the control to the right of other control (bottom aligned), taking margins into account.
        /// </summary>
        /// <param name="control">Control to place.</param>
        /// <param name="anchor">Anchor control.</param>
        /// <param name="spacing">Optional spacing.</param>
        static void PlaceRightBottom(GwenControlBase control, GwenControlBase anchor, [int spacing = 0])
        {
            control.SetPosition(anchor.Right + spacing, anchor.Y - control.Height + anchor.Height);
        }
    }

