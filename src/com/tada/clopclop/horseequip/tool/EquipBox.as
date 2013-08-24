package com.tada.clopclop.horseequip.tool
{
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class EquipBox extends MovieClip implements IComponent
	{
		private var _iconLock:IconItemLock;
		private var _iconCheck:IconCheck;
		private var _iconStorage:IconMyStorage;
		private var _iconNew:IconNew;
		private var _iconLimited:IconLimited;
		
		//total frames 4
		private var _equipBox:BtnFrameEquipmentItemButtons;
		
		public function EquipBox()
		{			
			initialization();
			setSkinBG();
			setProperties();			
			
			addListeners();
		}
		private function initialization():void{
			_iconLock= new IconItemLock;
			_iconCheck = new IconCheck;
			_iconStorage = new IconMyStorage;
			_iconNew = new IconNew;
			_iconLimited= new IconLimited;	
			
			_equipBox = new BtnFrameEquipmentItemButtons;			
			
			
			
		}
		private function setProperties():void{
			
			_equipBox.buttonMode = true;
			_equipBox.stop();
			//set coordinate
			_iconLock.x = 69.85;
			_iconLock.y = 5.15;
			
			_iconCheck.x = 59.70;
			_iconCheck.y = 4.10;
			
			_iconStorage.x = -4.45;
			_iconStorage.y = -2.15;
			
			_iconNew.x = (_equipBox.width / 2) -(_iconNew.width / 2); //25.15
			_iconNew.y = 65.05;
			
			_iconLimited.x = (_equipBox.width / 2) -(_iconLimited.width / 2);
			_iconLimited.y = 64.95;			
		}
		
		public function setSkinBG():void{		
			addChild(_equipBox);			
			addAllIcons();				
		}
		
		public function addIconLock():void{
			_equipBox.addChild(_iconLock);
		}
		public function addIconCheck():void{
			_equipBox.addChild(_iconCheck);
		}
		public function addIconStorage():void{
			_equipBox.addChild(_iconStorage);
		}
		public function addIconLimited():void{
			_equipBox.addChild(_iconLimited);
		}
		public function addIconNew():void{
			_equipBox.addChild(_iconNew);
		}
		
		public function addAllIcons():void{
			_equipBox.addChild(_iconLock);
			_equipBox.addChild(_iconCheck);
			_equipBox.addChild(_iconStorage);			
			_equipBox.addChild(_iconLimited);
			_equipBox.addChild(_iconNew);			
		}
		
		public function removeAllIcons():void{
			if(_iconLock.parent !=null)
				_equipBox.removeChild(_iconLock);
			
			
			if(_iconCheck.parent !=null)
				_equipBox.removeChild(_iconCheck);
			
			
			if(_iconStorage.parent !=null)
				_equipBox.removeChild(_iconStorage);
			
			
			if(_iconLimited.parent !=null)
				_equipBox.removeChild(_iconLimited);
			
			
			if(_iconNew.parent !=null)
				_equipBox.removeChild(_iconNew);
			
			
		}
				
		//set icomponent implementation
		public function addListeners():void
		{
			//this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);			
		}
		
		
		public function removeListeners():void
		{
		}
		
		public function setPosition(X:Number, Y:Number):void
		{
		}
		
		public function getPosition():Point
		{
			return null;
		}
		
		public function get displayObject():DisplayObject
		{
			return null;
		}
	}
}