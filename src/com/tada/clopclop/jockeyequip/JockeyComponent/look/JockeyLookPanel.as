package com.tada.clopclop.jockeyequip.JockeyComponent.look
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.jockeyequip.tool.EquipJockey;
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import com.tada.clopclop.horseequip.tool.ComboBoxClop;
	

	public class JockeyLookPanel extends Sprite implements IComponent
	{
		
		private var _view:View3D;
		private var _loader:Loader;
		
		
		//set skin and combobox
		private var _skinBG:View3DPanel= new View3DPanel;	
		private var _buttonReset:SkinResetBtn = new SkinResetBtn;;		
		private var _friendBox:SkinFriendBoxBorderedShort = new SkinFriendBoxBorderedShort;
		
		
		public function JockeyLookPanel(view:View3D)
		{	
			_view = view;
			initialization();		
			setSkinBG();
			setProperties();			
			
			//test
			setLoader("http://swebie.com/sites/default/files/120x100_28.png", .5,.5);	
			setLoaderPoint(new Point(0,17));
		}	
		private function setLoaderPoint(_point:Point):void{
			_loader.x = _point.x;
			_loader.y = _point.y;
		}
		
		public function setLoader(urlPic:String,_scaleX:Number, _scaleY:Number):void{
			_loader.load(new URLRequest(urlPic));	
			
			_loader.scaleX = _scaleX
			_loader.scaleY = _scaleY
		}
		
		private function initialization():void{	
			_loader = new Loader;
			
		
		}
		
		private function setSkinBG():void{
			addChild(_skinBG);
			addChild(_buttonReset);			addChild(_view);
		
			addChild(_friendBox);
			addChild(_loader);
		}		
		
		private function setProperties():void{
			this.width = _skinBG.width;
			this.height = _skinBG.height;
			
			//set size
			_buttonReset.x = (this.width /2) - (_buttonReset.width /2);
			_buttonReset.y = 0;
			
			//set equipHorse
			_view.x = this.width /2;
			_view.y = (this.height /4) * 3;
			//set friendbox
			_friendBox.x = -10;
			
			//set loader	
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