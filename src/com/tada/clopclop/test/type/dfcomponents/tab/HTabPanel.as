package com.tada.clopclop.test.type.dfcomponents.tab
{
	import com.tada.clopclop.test.type.dfcomponents.itemInfoDisplay;
	import com.tada.clopclop.ui.components.ButtonTypeComponent;
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;

	public class HTabPanel extends Sprite implements IComponent
	{
	
		private var _itemInfo:itemInfoDisplay;
		private var _buttonCompo:ButtonTypeComponent;
		
		//buttons
		private var _equipBox:Array = [];
		
		//skins
		private var _skinBG:SkinBottomBackground;
		
		//buttons		
		private var _left:BtnLeftBlue;
		private var _right:BtnRightBlue;
		
		private var _horseBody:BtnHorseBody2Depth;
		private var _horseEquip:BtnHorseEquipment2Depth;
		private var _horseNew:BtnNew2Depth;
		
		private var _horseShop:BtnShop1Depth;
		private var _horseStorage:BtnMyStorage1Depth;	
		
		private var _bNew:Boolean = false;
		private var _bBody:Boolean = false;
		private var _bEquip:Boolean = false;
		
		private var _bShop:Boolean = false;
		private var _bStorage:Boolean= false;		
		
		public function HTabPanel()
		{
			intialization();
			setSkinBG();
			setProperties();	
			
			defaultBtnBoolean();
			addListener();
		}
		
		private function intialization():void{						
			//skin
			_skinBG = new SkinBottomBackground;
			
			//set button2
			_left = new BtnLeftBlue;
			_right = new BtnRightBlue;
			
			_horseBody = new BtnHorseBody2Depth;
			_horseEquip = new BtnHorseEquipment2Depth;
			_horseNew = new BtnNew2Depth;	
			
			_horseShop = new BtnShop1Depth;
			_horseStorage = new BtnMyStorage1Depth;
		}
		
		private function defaultBtnBoolean():void{
			
			_bNew = false;
			_bBody = false;
			_bEquip = false;
			
			_bShop = false;
			_bStorage= false;	
			
			
			_horseShop.gotoAndStop(1);
			_horseStorage.gotoAndStop(1);
			
			_horseNew.gotoAndStop(1);
			_horseBody.gotoAndStop(1);
			_horseEquip.gotoAndStop(1);
		}
		
		private function addListener():void{
			_horseShop.addEventListener(MouseEvent.MOUSE_OVER, onShopOver);
			_horseShop.addEventListener(MouseEvent.MOUSE_OUT, onShopOut);	
			_horseShop.addEventListener(MouseEvent.CLICK, onShopClick);
			_horseShop.mouseChildren = false;
			
			_horseStorage.addEventListener(MouseEvent.MOUSE_OVER, onStorageOver);
			_horseStorage.addEventListener(MouseEvent.MOUSE_OUT, onStorageOut);	
			_horseStorage.addEventListener(MouseEvent.CLICK, onStorageClick);
			_horseStorage.mouseChildren = false;
			
			_horseNew.addEventListener(MouseEvent.MOUSE_OVER, onNewOver);
			_horseNew.addEventListener(MouseEvent.MOUSE_OUT, onNewOut);	
			_horseNew.addEventListener(MouseEvent.CLICK, onNewClick);
			_horseNew.mouseChildren = false;
			
			_horseBody.addEventListener(MouseEvent.MOUSE_OVER, onBodyOver);
			_horseBody.addEventListener(MouseEvent.MOUSE_OUT, onBodyOut);	
			_horseBody.addEventListener(MouseEvent.CLICK, onBodyClick);
			_horseBody.mouseChildren = false;
			
			_horseEquip.addEventListener(MouseEvent.MOUSE_OVER, onEquipOver);
			_horseEquip.addEventListener(MouseEvent.MOUSE_OUT, onEquipOut);	
			_horseEquip.addEventListener(MouseEvent.CLICK, onEquipClick);
			_horseEquip.mouseChildren = false;
		}	
		
		//shop
		private function onShopClick(e:MouseEvent):void{
			defaultBtnBoolean();
			_bShop = true;
			_horseShop.gotoAndStop(3);
		}		
		
		private function onShopOut(e:MouseEvent):void{
			if(_bShop == false)
				_horseShop.gotoAndStop(1);		
			
		}		
		private function onShopOver(e:MouseEvent):void{
			if(_bShop == false)
				_horseShop.gotoAndStop(2);			
		}
		
		//storage
		private function onStorageClick(e:MouseEvent):void{
			defaultBtnBoolean();
			_bStorage = true;
			_horseStorage.gotoAndStop(3);
		}		
		
		private function onStorageOut(e:MouseEvent):void{
			if(_bStorage == false)
				_horseStorage.gotoAndStop(1);		
			
		}		
		private function onStorageOver(e:MouseEvent):void{
			if(_bStorage == false)
				_horseStorage.gotoAndStop(2);			
		}
		
		//new
		private function onNewClick(e:MouseEvent):void{
			defaultBtnBoolean();
			_bNew = true;
			_horseNew.gotoAndStop(3);
		}		
		
		private function onNewOut(e:MouseEvent):void{
			if(_bNew == false)
				_horseNew.gotoAndStop(1);		
			
		}		
		private function onNewOver(e:MouseEvent):void{
			if(_bNew == false)
				_horseNew.gotoAndStop(2);			
		}
		
		//body
		private function onBodyClick(e:MouseEvent):void{
			defaultBtnBoolean();
			_bBody = true;
			_horseBody.gotoAndStop(3);
		}		
		
		private function onBodyOut(e:MouseEvent):void{
			if(_bBody == false)
				_horseBody.gotoAndStop(1);		
			
		}		
		private function onBodyOver(e:MouseEvent):void{
			if(_bBody == false)
				_horseBody.gotoAndStop(2);			
		}
		
		//equip
		private function onEquipClick(e:MouseEvent):void{
			defaultBtnBoolean();
			_bEquip = true;
			_horseEquip.gotoAndStop(3);
		}		
		
		private function onEquipOut(e:MouseEvent):void{
			if(_bEquip == false)
				_horseEquip.gotoAndStop(1);		
			
		}		
		private function onEquipOver(e:MouseEvent):void{
			if(_bEquip == false)
				_horseEquip.gotoAndStop(2);			
		}
		
		
		
		private function setSkinBG():void{
			addChild(_skinBG);	
			
			_skinBG.addChild(_left);
			_skinBG.addChild(_right);
			
			//set button
			setButton1();			
			setButton2();
			setButton3();
			setEquipBox();			
		}
		
		private function setEquipBox():void
		{			
			for (var num:int = 0;num < 5;num++)
			{				
				_equipBox[num] = new EquipBox;				
				_skinBG.addChild(_equipBox[num])
				_equipBox[num].x = (num * 100) + 40 ;
				
				_equipBox[num].y = (40);
			
			}			
		}
		private function setButton1():void{
			_horseShop.x = 10;
			_horseShop.y = 10;
			_horseStorage.x = _horseShop.width + 10;
			_horseStorage.y = 10;		
			
			addChild(_horseShop);
			addChild(_horseStorage);
		} 
		
		private function setButton2():void{
			// set properties
			_horseEquip.x = this.width - (_horseEquip.width + 10);			
			_horseBody.x = this.width - (_horseEquip.width + _horseBody.width + 20);
			_horseNew.x =  this.width - (_horseEquip.width + _horseBody.width + _horseNew.width + 30);			
			
			//add button2
			addChild(_horseEquip);
			addChild(_horseBody);
			addChild(_horseNew);
		}
		
		private function setButton3():void{
			
		}
		
		private function setProperties():void{
			this.width = _skinBG.width;
			this.height = _skinBG.height;			
			
			_left.x = 10;
			_left.y = _skinBG.height /2;			
			
			_right.x = _skinBG.width - 30;
			_right.y = _skinBG.height /2;
			
			//this.x = this.parent.width- this.width / 2;
			//this.y = 100;
			
			_skinBG.y = _horseEquip.height;
		}
		
		//set icomponent implementation		
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