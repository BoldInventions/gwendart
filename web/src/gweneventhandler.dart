part of gwendart;

abstract class GwenEventHandler
{
   void Invoke(GwenControlBase controlBase, var arguments);
}

typedef void AcceleratorHandlerFunction(GwenControlBase control, GwenEventArgs args);
typedef void GwenHandlerFunction(GwenControlBase control, GwenEventArgs args);

class AcceleratorEventHandler extends GwenEventHandler
{
   final AcceleratorHandlerFunction _handler;
  
   void Invoke(GwenControlBase controlBase, [var arg=null])
   {
     
   }
   
   AcceleratorEventHandler( AcceleratorHandlerFunction handler ) : _handler = handler
   {
     
   }
}

class GwenControlEventHandler extends GwenEventHandler
{
//   final GwenControlBase _controlToCall;
   final GwenHandlerFunction _func;
   
   GwenControlEventHandler(/*GwenControlBase controlToCall, */ GwenHandlerFunction func) : /*_controlToCall=controlToCall,*/ _func=func
   {
     
   }
   
   void Invoke(GwenControlBase control, GwenEventArgs args)
   {
     _func(control, args);
   }
}

class GwenEventHandlerList extends GwenEventHandler
{
   final List<GwenEventHandler> _list;
   GwenEventHandler HandlerAddedNotifyHandler=null;
   GwenEventHandler HandlerRemovedNotifyHandler=null;
   
   factory GwenEventHandlerList()
   {
      return new GwenEventHandlerList._internal();
   }
   
   GwenEventHandlerList._internal() : _list=new List<GwenEventHandler>()
       {
     
       }
   
   void Invoke(GwenControlBase controlBase, var arguments)
   {
     for(GwenEventHandler handler in _list)
     {
       handler.Invoke(controlBase, arguments);
     }
   }
   
   void add(GwenEventHandler handler) 
   { 
     if(_list.contains(handler))
     {
       throw new ArgumentError("Err - this handler already added.");
     }
     _list.add(handler);
     if(null != HandlerAddedNotifyHandler) HandlerAddedNotifyHandler.Invoke(null, handler);
   }
   
   void addFromList(List<GwenEventHandler> list)
   {
     for(GwenEventHandler handler in list)
     {
       add(handler);
     }
   }
   
   void remove(GwenEventHandler handler)
   {
     if(_list.contains(handler))
     {
       _list.remove(handler);
       if(null != HandlerRemovedNotifyHandler) HandlerRemovedNotifyHandler.Invoke(null, handler);
     }
   }
   
   void clear()
   {
     _list.clear();
   }
   
   GwenEventHandlerList operator +(GwenEventHandler handler)
       {
          GwenEventHandlerList newList = new GwenEventHandlerList();
          newList.addFromList(this._list);
          newList.add(handler);
          clear();
          return newList;
       }
   
   GwenEventHandlerList operator -(GwenEventHandler handler)
   {
     GwenEventHandlerList newList = new GwenEventHandlerList();
     newList.addFromList(this._list);
     newList.remove(handler);
     clear();
     return newList;
   }
   
}