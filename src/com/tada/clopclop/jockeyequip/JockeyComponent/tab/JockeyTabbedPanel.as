package com.tada.clopclop.jockeyequip.JockeyComponent.tab
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.tada.clopclop.dataproviders.CharacterDataProvider;
	import com.tada.clopclop.horseequip.HorseComponent.tab.itemInfoDisplay;
	import com.tada.clopclop.horseequip.tool.EquipBox;
	import com.tada.clopclop.jockeyequip.JockeyComponent.JockeyEquipEvent;
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class JockeyTabbedPanel extends Sprite implements IComponent
	{
		//cons main buttons
		public static const _STORAGE:String = "storage";
		public static const _SHOP:String = "shop";
		
		public static const _NEW:String = "N";
		public static const _BODY:String = "B";
		public static const _EQUIP:String = "E";
		
		//const body
		public static const _HAIR:String = "Hair";
		public static const _EYEBROW:String = "EyeBrow";
		public static const _EYES:String = "Eye";
		public static const _MOUTH:String = "Mouth";
		public static const _SKIN:String = "Skin";	
		//const equip
		public static const _TOP:String = "Top";
		public static const _BOTTOM:String = "Bottom";
		public static const _HAT:String = "Hat";
		public static const _SHOES:String = "Shoes";
		public static const _ACC:String = "Acc";	
		
		public static const _LEFT:String = "left";	
		public static const _RIGHT:String = "right";
		
		//const new
		public static const _NEWITEM:String = "NewItem";	
		
		//equipJockey parameter
		public var _mesh:int = 0;
		public var _part:String = _HAIR ;
		public var _type:int = 0;
		
		//buttons
		private var _equipBox:Array = [];
		
		//skins
		private var _skinBG:SkinBottomBackground;
		
		private var _left:BtnRightBlue;
		private var _right:BtnRightBlue;
		
		//button 1
		private var _jockeyShop:MovieClip;
		private var _jockeyStorage:MovieClip;
		
		//buttons 2		
		private var _jockeyBody:MovieClip;
		private var _jockeyEquip:MovieClip;
		private var _jockeyNew:MovieClip;
			
		private var _bNew:Boolean = false;
		private var _bBody:Boolean = false;
		private var _bEquip:Boolean = false;
		
		private var _bShop:Boolean = false;
		private var _bStorage:Boolean= false;			
		
		//coin and cash skin calcu
		private var _coinCalcu:SkinCalculator;
		private var _cashCalcu:SkinCalculator;
		
		private var _iconCoin:IconCoinSmall;
		private var _iconCash:IconCash;
			
		//set all Button ui for tabbed component
		private var shopStorage:Array = [
			new BtnShop1Depth,
			new BtnMyStorage1Depth
			];
		private var newBodyEquip:Array = [
			new BtnNew2Depth,
			new BtnJockeyBody2Depth,
			new BtnJockeyEquipment2Depth
			];
		private var bodyItem:Array = [
			new BtnJockeyHair3Depth,
			new BtnJockeyEyeBrow3Depth,
			new BtnJockeyEyes3Depth,
			new BtnJockeyMouth3Depth,			
			new BtnJockeySkin3Depth
			];
		private var equipItem:Array = [
			new BtnJockeyTop3Depth,
			new BtnJockeyBottom3Depth,
			new BtnJockeyHat3Depth,
			new BtnJockeyShoes3Depth,
			new BtnJockeyAccesories3Depth
			];
		
		//set equipbox icon
		private var _currentIconIndex:int;
		
		private var _itemInfo:Array= [];
		
		//body
		private var _hairArray:Array = [];
		private var _eyebrowArray:Array = [];		
		private var _eyesArray:Array = [];	
		private var _mouthArray:Array = [];	
		private var _skinArray:Array = [];	
		
		//Equipment
		
		private var _topArray:Array = [];	
		private var _bottomArray:Array = [];	
		private var _hatArray:Array = [];
		private var _shoesArray:Array = [];
		private var _accArray:Array = [];
		
		//new item URL
		private var _newArray:Array = [];	
		
		private var _characterDataProvider:CharacterDataProvider
		
		public function JockeyTabbedPanel(characterDataProvider:CharacterDataProvider)
		{			
			_characterDataProvider = characterDataProvider;
			
			intialization();
			setSkinBG();
			defaultBtnBoolean();			
			setTabEquipBox();
			fillUrl();
			setProperties();				
			removeAllBodyEquipIcons();
			addListeners();				
		}
		
		
		private function fillUrl():void{
			var arr:Array = [];
			var queryArray:Array = [];
			
			var arrAll:Array = [];
			var arrNew:Array = [];
			
			queryArray["_categoryCharacter"] = 1;
			arrAll = _characterDataProvider.getModelsByCategory(queryArray);	
			
			//add to query only old items
			queryArray["_itemNew"] = 0;
			arr = _characterDataProvider.getModelsByCategory(queryArray);
			
			//add to query only new
			queryArray["_itemNew"] = 1;
			arrNew = _characterDataProvider.getModelsByCategory(queryArray);	
			
			for(var num:int = 0; num < arr.length; num++){				
				trace("ALL " + arr[num]._categoryEquip);				
				trace("ALL " + arr[num]._thumbnailUrl );
				
				//equipment
				if(arr[num]._categoryEquip ==0 ){						
					_hatArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip ==1 ){						
					_topArray.push("./assets" + arr[num]._thumbnailUrl);
				}		
				if(arr[num]._categoryEquip ==2 ){						
					_bottomArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip ==3 ){						
					_shoesArray.push("./assets" + arr[num]._thumbnailUrl);
				}		
				if(arr[num]._categoryEquip ==4 ){						
					_accArray.push("./assets" + arr[num]._thumbnailUrl);
				}		
				
				//body
				if(arr[num]._categoryEquip ==5 ){						
					_hairArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip ==6 ){						
					_eyesArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip ==7 ){						
					_eyebrowArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip ==8 ){						
					_mouthArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip ==9 ){						
					_skinArray.push("./assets" + arr[num]._thumbnailUrl);
				}				
			}				
			
			//set newArray URL
			for(var i:int = 0; i< arrNew.length; i++){
				_newArray.push("./assets" + arrNew[i]._thumbnailUrl);
			}
		}
		
		private function intialization():void{						
			//skin
			_skinBG = new SkinBottomBackground;
			
			_left = new BtnRightBlue;
			_right = new BtnRightBlue;
			
			_coinCalcu = new SkinCalculator;
			_cashCalcu = new SkinCalculator;
			
			_iconCoin = new IconCoinSmall;
			_iconCash = new IconCash;	
			
			//set button1
			_jockeyShop = shopStorage[0];
			_jockeyStorage = shopStorage[1];
			
			//set button2			
			_jockeyNew = newBodyEquip[0];	
			_jockeyBody = newBodyEquip[1];
			_jockeyEquip = newBodyEquip[2];				
		}
		
		private function defaultBtnBoolean():void{
			
			_bNew = false;
			_bBody = false;
			_bEquip = false;
			
			_bShop = false;
			_bStorage= false;	
			
			
			_jockeyShop.gotoAndStop(1);
			_jockeyStorage.gotoAndStop(1);
			
			_jockeyNew.gotoAndStop(1);
			_jockeyBody.gotoAndStop(1);
			_jockeyEquip.gotoAndStop(1);
		}
		
		private function addBodyIcons():void{
			for(var num:int = 0; num < bodyItem.length; num++){
				_skinBG.addChild(bodyItem[num]);
			}
		}
		private function addEquipIcons():void{			
			for(var num:int = 0; num < equipItem.length; num++){
				_skinBG.addChild(equipItem[num]);
			}
		}
		private function removeAllBodyEquipIcons():void{
			
			for(var num:int = 0; num < bodyItem.length; num++){
				if(bodyItem[num].parent != null){
					_skinBG.removeChild(bodyItem[num]);			
				}
			}
			for(var num2:int = 0; num2 <equipItem.length; num2++){
				if(equipItem[num2].parent != null){
					_skinBG.removeChild(equipItem[num2]);			
				}
			}
		}		
		//shop
		private function onShopClick(e:MouseEvent):void{			
			switchButtonType(_SHOP);
		}			
		private function onShopOut(e:MouseEvent):void{
			if(_bShop == false)
				_jockeyShop.gotoAndStop(1);				
		}		
		private function onShopOver(e:MouseEvent):void{
			if(_bShop == false)
				_jockeyShop.gotoAndStop(2);			
		}			
		//storage
		private function onStorageClick(e:MouseEvent):void{
			switchButtonType(_STORAGE);
		}			
		private function onStorageOut(e:MouseEvent):void{
			if(_bStorage == false)
				_jockeyStorage.gotoAndStop(1);				
		}		
		private function onStorageOver(e:MouseEvent):void{
			if(_bStorage == false)
				_jockeyStorage.gotoAndStop(2);			
		}		
		//new
		private function onNewClick(e:MouseEvent):void{
			switchButtonType(_NEW);
		}				
		private function onNewOut(e:MouseEvent):void{
			if(_bNew == false)
				_jockeyNew.gotoAndStop(1);				
		}		
		private function onNewOver(e:MouseEvent):void{
			if(_bNew == false)
				_jockeyNew.gotoAndStop(2);			
		}		
		//body
		private function onBodyClick(e:MouseEvent):void{
			switchButtonType(_BODY);
		}				
		private function onBodyOut(e:MouseEvent):void{
			if(_bBody == false)
				_jockeyBody.gotoAndStop(1);					
		}		
		private function onBodyOver(e:MouseEvent):void{
			if(_bBody == false)
				_jockeyBody.gotoAndStop(2);		
		}
		
		//equip
		private function onEquipClick(e:MouseEvent):void{			
			switchButtonType(_EQUIP);
		}		
		
		private function onEquipOut(e:MouseEvent):void{
			if(_bEquip == false)
				_jockeyEquip.gotoAndStop(1);				
		}		
		private function onEquipOver(e:MouseEvent):void{
			if(_bEquip == false)
				_jockeyEquip.gotoAndStop(2);		
		}	
		
		private function switchButtonType(type:String):void{
			removeAllBodyEquipIcons();			
			defaultBtnBoolean();		
			
			_currentIconIndex = 0;
			removeIcons();		
			switch(type){
				case _SHOP:
					//addShopIcons();
					_bShop = true;
					_jockeyShop.gotoAndStop(3);					
					break;
				
				case _STORAGE:
					//addStorageIcons();
					_bStorage = true;
					_jockeyStorage.gotoAndStop(3);
					break;
				
				case _NEW:
					//addNewIcons();
					_bNew = true;
					_jockeyNew.gotoAndStop(3);
					switchIconType(_NEWITEM);
					break;
				
				case _BODY:
					addBodyIcons();
					_bBody = true;
					_jockeyBody.gotoAndStop(3);			
					switchIconType(_HAIR);
					break;
				
				case _EQUIP:
					addEquipIcons();		
					_bEquip = true;
					_jockeyEquip.gotoAndStop(3);				
					switchIconType(_TOP);
					break;						
			}			
		}
		
		private function setSkinBG():void{
			addChild(_skinBG);	
			
			_skinBG.addChild(_left);
			_skinBG.addChild(_right);				
			
			setCoinCash();
			//set button
			setButton1();			
			setButton2();
			setButton3();
					
		}
		
		private function setCoinCash():void{	
			//_iconCoin.y;
			_iconCash.y = 10;
			
			_coinCalcu.x = 20;
			_coinCalcu.y = 10;
			_cashCalcu.x = _coinCalcu.width + 20;
			_cashCalcu.y = 10;
			
			_skinBG.addChild(_coinCalcu);
			_skinBG.addChild(_cashCalcu);	
			
			_coinCalcu.addChild(_iconCoin);
			_cashCalcu.addChild(_iconCash);
		}
		
		public function setTabEquipBox():void
		{			
			for (var num:int = 0;num < 5;num++)
			{				
				_equipBox[num] = new EquipBox;				
				_skinBG.addChild(_equipBox[num])
				_equipBox[num].x = (num * 100) + 40 ;
				
				_equipBox[num].y = 40;	
				_equipBox[num].removeAllIcons();
			}		
			
			//set listener
			
			_equipBox[0].addEventListener(MouseEvent.CLICK, onEquipBox0);
			_equipBox[1].addEventListener(MouseEvent.CLICK, onEquipBox1);
			_equipBox[2].addEventListener(MouseEvent.CLICK, onEquipBox2);
			_equipBox[3].addEventListener(MouseEvent.CLICK, onEquipBox3);
			_equipBox[4].addEventListener(MouseEvent.CLICK, onEquipBox4);	
			
		}
		
		private function setButton1():void{
			_jockeyShop.x = 10;
			_jockeyShop.y = 10;
			_jockeyStorage.x = _jockeyShop.width + 10;
			_jockeyStorage.y = 10;		
			
			addChild(_jockeyShop);
			addChild(_jockeyStorage);
		} 
		
		private function setButton2():void{
			// set properties
			_jockeyEquip.x = this.width - (_jockeyEquip.width + 10);			
			_jockeyBody.x = this.width - (_jockeyEquip.width + _jockeyBody.width + 20);
			_jockeyNew.x =  this.width - (_jockeyEquip.width + _jockeyBody.width + _jockeyNew.width + 30);			
			
			//add button2
			addChild(_jockeyEquip);
			addChild(_jockeyBody);
			addChild(_jockeyNew);
		}
		
		private function setButton3():void{
			
		}
		
		private function setProperties():void{
			this.width = _skinBG.width;
			this.height = _skinBG.height;			
			
			_left.x = 20;
			_left.y = (_skinBG.height /2) + _left.height;	
			_left.rotationZ = 180;			
			
			_right.x = _skinBG.width - 30;
			_right.y = _skinBG.height /2;
						
			_skinBG.y = _jockeyEquip.height;
			
			//button3 Coordinate
			var _posX:int = 0;			
			for(var num:int = bodyItem.length -1; num>=0; num-- ){
				_posX += bodyItem[num].width - 8;				
				bodyItem[num].x = _skinBG.width - (_posX + 20);				
				equipItem[num].x = _skinBG.width - (_posX + 20);
			}			
			_jockeyNew.gotoAndStop(3);
			switchButtonType(_NEW);
		}
		
		//set icomponent implementation		
		public function addListeners():void{
			_jockeyShop.addEventListener(MouseEvent.MOUSE_OVER, onShopOver);
			_jockeyShop.addEventListener(MouseEvent.MOUSE_OUT, onShopOut);	
			_jockeyShop.addEventListener(MouseEvent.CLICK, onShopClick);
			_jockeyShop.mouseChildren = false;
			
			_jockeyStorage.addEventListener(MouseEvent.MOUSE_OVER, onStorageOver);
			_jockeyStorage.addEventListener(MouseEvent.MOUSE_OUT, onStorageOut);	
			_jockeyStorage.addEventListener(MouseEvent.CLICK, onStorageClick);
			_jockeyStorage.mouseChildren = false;
			
			_jockeyNew.addEventListener(MouseEvent.MOUSE_OVER, onNewOver);
			_jockeyNew.addEventListener(MouseEvent.MOUSE_OUT, onNewOut);	
			_jockeyNew.addEventListener(MouseEvent.CLICK, onNewClick);
			_jockeyNew.mouseChildren = false;
			
			_jockeyBody.addEventListener(MouseEvent.MOUSE_OVER, onBodyOver);
			_jockeyBody.addEventListener(MouseEvent.MOUSE_OUT, onBodyOut);	
			_jockeyBody.addEventListener(MouseEvent.CLICK, onBodyClick);
			_jockeyBody.mouseChildren = false;
			
			_jockeyEquip.addEventListener(MouseEvent.MOUSE_OVER, onEquipOver);
			_jockeyEquip.addEventListener(MouseEvent.MOUSE_OUT, onEquipOut);	
			_jockeyEquip.addEventListener(MouseEvent.CLICK, onEquipClick);
			_jockeyEquip.mouseChildren = false;
						
			//left right button
			_left.addEventListener(MouseEvent.CLICK, onLeftClick);
			_right.addEventListener(MouseEvent.CLICK, onRightClick);	
			
			//button 3	
			for(var num:int = 0; num< bodyItem.length; num++){
				bodyItem[num].addEventListener(MouseEvent.CLICK, onBodyEquip);
			}
			for(var num2:int = 0; num2< equipItem.length; num2++){
				equipItem[num2].addEventListener(MouseEvent.CLICK, onBodyEquip);
			}
			
		}	
		
		private function onBodyEquip(e:MouseEvent):void{
			//body
			if(e.target == bodyItem[0]){
				switchIconType(_HAIR);	
			}
			if(e.target == bodyItem[1]){
				switchIconType(_EYEBROW);
			}
			if(e.target == bodyItem[2]){
				switchIconType(_EYES);	
			}
			if(e.target == bodyItem[3]){				
				switchIconType(_MOUTH);	
			}
			if(e.target == bodyItem[4]){
				switchIconType(_SKIN);
			}		
			
			//equipment
			if(e.target == equipItem[0]){
				switchIconType(_TOP);	
			}
			if(e.target == equipItem[1]){
				switchIconType(_BOTTOM);
			}
			if(e.target == equipItem[2]){
				switchIconType(_HAT);
			}
			if(e.target == equipItem[3]){				
				switchIconType(_SHOES);	
			}
			if(e.target == equipItem[4]){
				switchIconType(_ACC);	
			}
		}
		
		private function onEquipBox0(e:MouseEvent):void{
			_type = _currentIconIndex;
			dispatchEvent(new JockeyEquipEvent(JockeyEquipEvent.CLICKED_BOX0));
		}		
		private function onEquipBox1(e:MouseEvent):void{
			_type = _currentIconIndex+1;
			dispatchEvent(new JockeyEquipEvent(JockeyEquipEvent.CLICKED_BOX1));
		}
		private function onEquipBox2(e:MouseEvent):void{
			_type = _currentIconIndex+2;
			dispatchEvent(new JockeyEquipEvent(JockeyEquipEvent.CLICKED_BOX2));
		}
		private function onEquipBox3(e:MouseEvent):void{
			_type = _currentIconIndex+3;
			dispatchEvent(new JockeyEquipEvent(JockeyEquipEvent.CLICKED_BOX3));
		}
		private function onEquipBox4(e:MouseEvent):void{
			_type = _currentIconIndex+4;
			dispatchEvent(new JockeyEquipEvent(JockeyEquipEvent.CLICKED_BOX4));
		}			
		
		private function onLeftClick(e:MouseEvent):void{
			switchLeftRight(_LEFT);
		}
		
		private function onRightClick(e:MouseEvent):void{
			switchLeftRight(_RIGHT);
		}
		
		private function switchLeftRight(dir:String):void{			
			switch(dir){
				case _LEFT:
					if(_currentIconIndex>0){
						_currentIconIndex -=5;	
					}
					break;
				case _RIGHT:					
					if(_currentIconIndex<_itemInfo.length - 5){
						_currentIconIndex +=5;
					}
					break;
				
			}
			removeIcons();
			displayIcons();
		}
		
		private function switchIconType(part:String):void{			
			
			switch(part){
				case _HAIR:			
					_part = _HAIR;					
					break;
				
				case _EYEBROW:	
					_part = _EYEBROW;						
					break;
				case _EYES:	
					_part = _EYES;					
					break;
				case _MOUTH:
					_part = _MOUTH;							
					break;
				case _SKIN:					
					_part = _SKIN;					
					break;	
				
				//equipment
				case _TOP:	
					_part = _TOP;					
					break;
				case _BOTTOM:
					_part = _BOTTOM;				
					break;
				case _HAT:
					_part = _HAT;					
					break;
				case _SHOES:
					_part = _SHOES;				
					break;
				case _ACC:
					_part = _ACC;				
					break;
				
				//new item
				case _NEWITEM:	
					_part = _NEWITEM;	
					break;
				
			}
			switchIcon(_part);
		}
		
		private function switchIcon(_part:String):void{
			var num:int;
			//current equipbox icon index
			_currentIconIndex = 0;
			
			removeIcons();
			popAllInfoIcon();		
			
			switch(_part){
				case _HAIR:
					
					for( num = 0; num < _hairArray.length; num++){					
						_itemInfo.push(new itemInfoDisplay(_hairArray[num], 15,15));			
					}			
					break;
				
				case _EYEBROW:
						
					for( num = 0; num < _eyebrowArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_eyebrowArray[num], 15,15));			
					}		
					
					break;
				case _EYES:
						
					for( num = 0; num < _eyesArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_eyesArray[num], 15,15));			
					}		
					break;
				case _MOUTH:				
					for( num = 0; num < _mouthArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_mouthArray[num], 15,15));			
					}	
					break;
				case _SKIN:					
					for( num = 0; num < _skinArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_skinArray[num], 15,15));			
					}		
					break;
				
				//Equipment
				case _TOP:
				
					for( num = 0; num < _topArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_topArray[num], 15,15));			
					}					
					break;
				case _BOTTOM:
				
					for( num = 0; num < _bottomArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_bottomArray[num], 15,15));			
					}		
					break;
				case _HAT:						
					for( num = 0; num < _hatArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_hatArray[num], 15,15));			
					}		
					break;
				case _SHOES:
					
					for( num = 0; num < _shoesArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_shoesArray[num], 15,15));			
					}		
					break;
				case _ACC:						
					for( num = 0; num < _accArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_accArray[num], 15,15));			
					}		
					break;	
				//new item
				case _NEWITEM:
					
					for( num = 0; num < _newArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_newArray[num], 15,15));			
					}		
					break;		
			}			
			displayIcons();
		}				
		
		private function displayIcons():void{				
			for(var num:int = _currentIconIndex; num < _itemInfo.length && num < _currentIconIndex + 5;num++){
				_itemInfo[num].addItemIcon(_equipBox[num - _currentIconIndex]);
			}
			trace(_itemInfo.length);
		}
		
		private function removeIcons():void{			
			if (_itemInfo) {
				trace("remove icons");
				for(var num:int = 0; num < _itemInfo.length;num++){
					_itemInfo[num].removeItemIcon();
				}				
			}		
		}
		
		private function popAllInfoIcon():void{
			if (_itemInfo) {			
				for(var num:int = _itemInfo.length; num > 0;num--){
					_itemInfo.pop();
				}	
			}
		}
		public function removeListeners():void{			
			_jockeyShop.removeEventListener(MouseEvent.MOUSE_OVER, onShopOver);
			_jockeyShop.removeEventListener(MouseEvent.MOUSE_OUT, onShopOut);	
			_jockeyShop.removeEventListener(MouseEvent.CLICK, onShopClick);
			_jockeyShop.mouseChildren = false;
			
			_jockeyStorage.removeEventListener(MouseEvent.MOUSE_OVER, onStorageOver);
			_jockeyStorage.removeEventListener(MouseEvent.MOUSE_OUT, onStorageOut);	
			_jockeyStorage.removeEventListener(MouseEvent.CLICK, onStorageClick);
			_jockeyStorage.mouseChildren = false;
			
			_jockeyNew.removeEventListener(MouseEvent.MOUSE_OVER, onNewOver);
			_jockeyNew.removeEventListener(MouseEvent.MOUSE_OUT, onNewOut);	
			_jockeyNew.removeEventListener(MouseEvent.CLICK, onNewClick);
			_jockeyNew.mouseChildren = false;
			
			_jockeyBody.removeEventListener(MouseEvent.MOUSE_OVER, onBodyOver);
			_jockeyBody.removeEventListener(MouseEvent.MOUSE_OUT, onBodyOut);	
			_jockeyBody.removeEventListener(MouseEvent.CLICK, onBodyClick);
			_jockeyBody.mouseChildren = false;
			
			_jockeyEquip.removeEventListener(MouseEvent.MOUSE_OVER, onEquipOver);
			_jockeyEquip.removeEventListener(MouseEvent.MOUSE_OUT, onEquipOut);	
			_jockeyEquip.removeEventListener(MouseEvent.CLICK, onEquipClick);
			_jockeyEquip.mouseChildren = false;
			
			//left right button
			_left.removeEventListener(MouseEvent.CLICK, onLeftClick);
			_right.removeEventListener(MouseEvent.CLICK, onRightClick);	
			
			//button 3	
			for(var num:int = 0; num< bodyItem.length; num++){
				bodyItem[num].removeEventListener(MouseEvent.CLICK, onBodyEquip);
			}
			for(var num2:int = 0; num2< equipItem.length; num2++){
				equipItem[num2].removeEventListener(MouseEvent.CLICK, onBodyEquip);
			}
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