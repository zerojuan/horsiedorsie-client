package com.tada.clopclop.test.type.dfcomponents
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.horseequip.tool.EquipHorse;
	import com.tada.clopclop.ui.components.IComponent;
	
	import fl.controls.ComboBox;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	

	public class HLookPanel extends Sprite implements IComponent
	{
		private var _skinBG:View3DPanel;
		private var _buttonReset:SkinResetBtn;	
		
		private var _equipHorse:EquipHorse;
		private var _view:View3D;
		
		private var _combo:ComboBox;
		
		public function HLookPanel(view:View3D)
		{	
			_view = view;
			initialization();		
			setSkinBG();
			setProperties();			
			
			setComboList();		
		}	
		
		private function initialization():void{
			_skinBG = new View3DPanel;			
			_buttonReset = new SkinResetBtn;
			_equipHorse = new EquipHorse(_view);	
			
			_combo = new ComboBox;
		}
		
		private function setSkinBG():void{
			addChild(_skinBG);
			addChild(_buttonReset);
			addChild(_view);
			addChild(_combo);
		}		
		private function setProperties():void{
			this.width = _skinBG.width;
			this.height = _skinBG.height;
			
			//set size
			_buttonReset.x = (this.width /2) - (_buttonReset.width /2);
			_buttonReset.y = 0;
			
			_view.x = this.width /2;
			_view.y = (this.height /4) * 3;
			
			_combo.x = (this.width /2) - (_combo.width /2)
			_combo.y = this.height
		}
		
		
		
		private function setComboList():void{
			var comboList:Array =[];			
			
			_combo.addItem({data:1, label:"kabayo 1"});
			_combo.addItem({data:2, label:"kabayo 2"});
			_combo.addItem({data:3, label:"kabayo 3"});
		}
		
		public function setEquipHorse(BE:String, part:String, type:int):void{
			var _BE:String = BE;
			var _part:String = part;
			var _type:int = type;
			
			_equipHorse.itemEquip(_BE,_part,_type);
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