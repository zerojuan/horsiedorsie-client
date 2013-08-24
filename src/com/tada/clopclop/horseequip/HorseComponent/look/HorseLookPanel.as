package com.tada.clopclop.horseequip.HorseComponent.look
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	

	public class HorseLookPanel extends Sprite implements IComponent
	{
		private var _skinBG:SkinView3DPanel;
		private var _buttonReset:BtnReset;		
		private var _view:View3D;	
		
		
		public function HorseLookPanel(view:View3D)
		{	
			_view = view;
			initialization();		
			setSkinBG();
			setProperties();				
		}	
		
		private function initialization():void{
			_skinBG = new SkinView3DPanel;			
			_buttonReset = new BtnReset;			
		
		}
		
		private function setSkinBG():void{
			addChild(_skinBG);
			addChild(_buttonReset);
			addChild(_view);			
		}		
		
		private function setProperties():void{
			this.width = _skinBG.width;
			this.height = _skinBG.height;
			
			//set size
			_buttonReset.x = (this.width /2) - (_buttonReset.width /2);
			_buttonReset.y = 0;
			
			_view.x = this.width /2;
			_view.y = (this.height /4) * 3;		
		}
		
		
		
		// implements IComponent
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