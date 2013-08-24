package com.tada.clopclop.test.type.dfcomponents
{
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class HTabPanel extends Sprite implements IComponent
	{
		private var _skinBG:SkinBottomBackground;
		
		public function HTabPanel()
		{
			intialization();
			setSkinBG();
			setProperties();
			
		
		}
		
		private function intialization():void{
			_skinBG = new SkinBottomBackground;
			
		}
		
		private function setSkinBG():void{
			addChild(_skinBG);
		}
		
		private function setProperties():void{
			this.width = _skinBG.width;
			this.height = _skinBG.height;
			
			//this.x = this.parent.width- this.width / 2;
			//this.y = 380;
		}
		
		public function addListeners():void{
			
		}
		
		public function removeListeners():void{
			
		}
		
		public function setPosition(x:Number, y:Number):void{
			this.x = x;
			this.y = y;
		}		
		
		public function getPosition():Point{
			return new Point(x,y);
		}
		
		public function get displayObject():DisplayObject{
			return this;
		}
		
	}
}