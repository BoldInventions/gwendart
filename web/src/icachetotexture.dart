part of gwendart;

abstract class ICacheToTexture
{
   void initialize();
   void shutDown();
   void setupCacheTexture(GwenControlBase control);
   void finishCacheTexture(GwenControlBase control);
   void drawCachedControlTexture(GwenControlBase control);
   void createControlCacheTexture(GwenControlBase control);
   void updateControlCacheTexture(GwenControlBase control);
   void setRenderer(GwenRendererBase renderer);
}