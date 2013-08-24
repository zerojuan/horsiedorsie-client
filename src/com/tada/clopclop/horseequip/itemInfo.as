package com.tada.clopclop.horseequip
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class itemInfo extends Sprite
	{		
		private var _icon:MovieClip;
		private var _iconBox:Array = [];
		private var _name:String;
		
		public function itemInfo(icon:MovieClip, name:String)
		{			
			_icon = new MovieClip;			
			_icon = icon;	
			_name = name;
		}
		public function addItemIcon():void{
			if(_icon){
				addChild(_icon);
			}
			
		}		
		
		public function removeItemIcon():void{
			trace(_icon.parent);
			if(_icon.parent !=null){
				
				removeChild(_icon);
			}			
		}		
	}
}