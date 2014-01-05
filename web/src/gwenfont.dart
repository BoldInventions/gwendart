part of gwendart;

abstract class GwenFont
{
    String get FaceName;
    set FaceName(String);
    int get Size;
    set Size(int);
    bool get Smooth;
    set Smooth(bool);
    Object get RendererData;
    set RendererData(Object);
    double get RealSize;
    set RealSize(double);
    final GwenRendererBase _renderer;

    factory GwenFont(GwenRendererBase renderer, [String faceName="Arial", int size=10])
    {
      return new CanvasFont(renderer, faceName, size);
    }
    
    GwenFont._internal(GwenRendererBase renderer, [String faceName="Arial", int size=10]) : _renderer = renderer
        {
            FaceName = faceName;
            Size = size;
            Smooth = false;
        }
    String get CssString;
    
}