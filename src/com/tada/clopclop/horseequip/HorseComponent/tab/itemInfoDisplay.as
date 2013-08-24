package com.tada.clopclop.horseequip.HorseComponent.tab
{
	import com.tada.utils.debug.Logger;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;

	public class itemInfoDisplay extends Sprite
	{		
		private var _iconURL:String;	
		private var _loader:Loader;
		
		public function itemInfoDisplay(url:String, X:int, Y:int)
		{			
			_iconURL = url;		
			_loader = new Loader;
			
			setTimeout(function():void {  _loader.load(new URLRequest(_iconURL)); }, 1);				
			//_loader.load(new URLRequest(_iconURL));
			
			_loader.x = X;
			_loader.y = Y;
			
			_loader.addEventListener(Event.COMPLETE, onComplete);		
		}
		
		private function onComplete(evt:Event):void{
			Logger.print(this, "On Load complete");
			trace("LOAD COMPLETE");
			
			//_loader.load(new URLRequest(_iconURL));
			
		}
		
		public function addItemIcon(iconParent:MovieClip):void{	 
			//set loader coordinates			
			iconParent.addChild(_loader);			
		}		
		
		public function removeItemIcon():void{		
			if(_loader.parent !=null){				
				_loader.parent.removeChild(_loader);
			}			
		}	
		
	}
}