part of gwendart;

abstract class GwenTexture
{
  String get Name;
  set Name(String);
  Object get RenderData;
  set RenderData(Object);
  bool get Failed;
  set Failed(bool);
  int get Width;
  set Width(int);
  int get Height;
  set Height(int);
  bool get HasData;
  set HasData(bool);
  final GwenRendererBase _renderer;
  
  factory GwenTexture(GwenRendererBase renderer)
  {
     return new CanvasTexture(renderer);
  }
  
  GwenTexture._internal(GwenRendererBase renderer) : _renderer = renderer
  {
    Width=4;
    Height=4;
    Failed = false;
  }
  
  void load(String name)
  {
    Name=name;   
    _renderer.loadTexture(this);
  }
  
  void loadRaw(int width, int height, var pixelData)
  {
    Width = width;
    Height = height;
    _renderer.loadTextureRaw(this, pixelData);
  }
  
  void loadStream(var stream)
  {
    _renderer.loadTextureStream(this, stream);
  }
}