part of gwendart;



class CssCursor
{
   static const Default  = const CssCursor._("auto");
   static const Auto = const CssCursor._("auto");
   static const Pointer = const CssCursor._("pointer");
   static const Text = const CssCursor._("text");
   static const Wait = const CssCursor._("wait");
   static const CrossHair = const CssCursor._("crosshair");
   static const Help = const CssCursor._("help");
   static const Move = const CssCursor._("move");
   static const Copy = const CssCursor._("copy");
   static const None = const CssCursor._("none");
   static const NotAllowed = const CssCursor._("not-allowed");
   static const ZoomIn = const CssCursor._("zoom-in");
   static const ZoomOut = const CssCursor._("zoom-out");
   static const SizeNS = const CssCursor._("ns-resize");
   static const SizeWE = const CssCursor._("ew-resize");
   static const SizeNWSE = const CssCursor._("nwse-resize");
   static const SizeNESW = const CssCursor._("nesw-resize");
   static const NoDrop = const CssCursor._("no-drop");
   static const SizeAll = const CssCursor._("move");
   final String Name;
   
   const CssCursor._(this.Name);
}