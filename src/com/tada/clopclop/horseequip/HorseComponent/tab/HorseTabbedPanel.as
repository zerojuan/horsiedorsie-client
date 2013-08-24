package com.tada.clopclop.horseequip.HorseComponent.tab
{
	//setEquipHorse(_BE, _part, _type);	
	
	import com.tada.clopclop.datamodels.Character;
	import com.tada.clopclop.dataproviders.CharacterDataProvider;
	import com.tada.clopclop.horseequip.HorseComponent.HorseEquipEvent;
	import com.tada.clopclop.horseequip.tool.EquipBox;
	import com.tada.clopclop.ui.components.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class HorseTabbedPanel extends Sprite implements IComponent
	{		
		//cons main buttons
		public static const _STORAGE:String = "storage";
		public static const _SHOP:String = "shop";
		
		public static const _NEW:String = "N";
		public static const _BODY:String = "B";
		public static const _EQUIP:String = "E";
		
		//const body
		public static const _MANE:String = "Mane";
		public static const _EYES:String = "Eye";
		public static const _MOUTH:String = "Mouth";
		public static const _PATTERN:String = "Pattern";
		public static const _SKIN:String = "Skin";
		
		//const equip
		public static const _HEAD:String = "Head";
		public static const _BRIDLE:String = "Bridle";
		public static const _SADDLE:String = "Saddle";
		public static const _WING:String = "Wing";
		public static const _ACC:String = "Acc";	
		
		//const new
		public static const _NEWITEM:String = "NewItem";	
		
		public static const _LEFT:String = "left";	
		public static const _RIGHT:String = "right";	
		
		
		//buttons
		private var _equipBox:Array = [];
		
		//skins
		private var _skinBG:SkinBottomBackground;
		
		private var _left:BtnRightBlue;
		private var _right:BtnRightBlue;
		
		//button 1
		private var _horseShop:MovieClip;
		private var _horseStorage:MovieClip;
		
		//buttons 2		
		private var _horseBody:MovieClip;
		private var _horseEquip:MovieClip;
		private var _horseNew:MovieClip;
			
		private var _bNew:Boolean = false;
		private var _bBody:Boolean = false;
		private var _bEquip:Boolean = false;
		
		private var _bShop:Boolean = false;
		private var _bStorage:Boolean= false;		
		
		//equipHorse parameter
		public var _mesh:int = 0;
		public var _part:String = _MANE;
		public var _type:int = 0;
		
		//set equipbox icon
		private var _currentIconIndex:int;
		
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
			new BtnHorseBody2Depth,
			new BtnHorseEquipment2Depth
			];
		private var bodyItem:Array = [
			new BtnHorseMane3Depth,
			new BtnHorseEyes3Depth,
			new BtnHorseMouth3Depth,
			new BtnHorsePattern3Depth,
			new BtnHorseSkin3Depth
			];
		private var equipItem:Array = [
			new BtnHorseHead3Depth,
			new BtnHorseBridle3Depth,
			new BtnHorseSaddle3Depth,
			new BtnHorseWings3Depth,
			new BtnHorseAccessory3Depth
			];
		
		private var _itemInfo:Array= [];
				
		//body URL
		private var _maneArray:Array = [];
		private var _eyesArray:Array = [];		
		private var _mouthArray:Array = [];	
		private var _skinArray:Array = [];			
		private var _patternArray:Array = [];
		
		//equipment URL
		private var _headArray:Array = [];		
		private var _bridleArray:Array = [];
		private var _saddleArray:Array = [];	
		private var _wingArray:Array = [];
		private var _accArray:Array = [];
		
		//new item URL
		private var _newArray:Array = [];		
		
		private var _characterDataProvider:CharacterDataProvider;
		
		public function HorseTabbedPanel(characterDataProvider:CharacterDataProvider)
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
			
			queryArray["_categoryCharacter"] = 0;					
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
				
				if(arr[num]._categoryEquip == 0 ){						
					_headArray.push("./assets" + arr[num]._thumbnailUrl);					
				}
				if(arr[num]._categoryEquip == 1 ){				
					_saddleArray.push("./assets" + arr[num]._thumbnailUrl);					
				}
				if(arr[num]._categoryEquip == 2 ){												
					_bridleArray.push("./assets" + arr[num]._thumbnailUrl);						
				}
				if(arr[num]._categoryEquip == 3 ){						
					_wingArray.push("./assets" + arr[num]._thumbnailUrl);
				}				
				if(arr[num]._categoryEquip == 5 ){						
					_maneArray.push("./assets" + arr[num]._thumbnailUrl);
				}	
				if(arr[num]._categoryEquip == 6 ){						
					_eyesArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip == 7 ){						
					_mouthArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip == 8 ){						
					_patternArray.push("./assets" + arr[num]._thumbnailUrl);
				}
				if(arr[num]._categoryEquip == 9 ){						
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
			_horseShop = shopStorage[0];
			_horseStorage = shopStorage[1];
			
			//set button2			
			_horseNew = newBodyEquip[0];	
			_horseBody = newBodyEquip[1];
			_horseEquip = newBodyEquip[2];
		
		}
		
		private function defaultBtnBoolean():void{
			
			_bNew = false;
			_bBody = false;
			_bEquip = false;
			
			var char:Character = _characterDataProvider.getModelById(1) as Character;
			
			_bShop = false;
			_bStorage= false;	
			
			_horseShop.gotoAndStop(1);
			_horseStorage.gotoAndStop(1);
			
			_horseNew.gotoAndStop(1);
			_horseBody.gotoAndStop(1);
			_horseEquip.gotoAndStop(1);
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
				_horseShop.gotoAndStop(1);		
			
		}		
		private function onShopOver(e:MouseEvent):void{
			if(_bShop == false)
				_horseShop.gotoAndStop(2);			
		}
		
		//storage
		private function onStorageClick(e:MouseEvent):void{			
			switchButtonType(_STORAGE);
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
			switchButtonType(_NEW);
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
			switchButtonType(_BODY);
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
			switchButtonType(_EQUIP);
		}		
		
		private function onEquipOut(e:MouseEvent):void{
			if(_bEquip == false)
				_horseEquip.gotoAndStop(1);		
			
		}		
		private function onEquipOver(e:MouseEvent):void{
			if(_bEquip == false)
				_horseEquip.gotoAndStop(2);			
		}
		
		private function switchButtonType(buttonType:String):void{
			removeAllBodyEquipIcons();			
			defaultBtnBoolean();		
			
			_currentIconIndex = 0;
			removeIcons();				
			switch(buttonType){
				case _SHOP:
					//addShopIcons();
					_bShop = true;
					_horseShop.gotoAndStop(3);	
					break;
				
				case _STORAGE:
					//addStorageIcons();
					_bStorage = true;
					_horseStorage.gotoAndStop(3);
					break;
				
				case _NEW:
					//addNewIcons();
					_bNew = true;
					_horseNew.gotoAndStop(3);
					switchIconType(_NEWITEM);
					break;
				
				case _BODY:
					addBodyIcons();
					
					_bBody = true;
					_horseBody.gotoAndStop(3);					
					switchIconType(_MANE);	
					break;
				
				case _EQUIP:
					addEquipIcons();		
					_bEquip = true;
					_horseEquip.gotoAndStop(3);						
					switchIconType(_HEAD);	
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
				
				//trace(_equipBox[num]);
			}	
			
			//set listener
			_equipBox[0].addEventListener(MouseEvent.CLICK, onEquipBox0);
			_equipBox[1].addEventListener(MouseEvent.CLICK, onEquipBox1);
			_equipBox[2].addEventListener(MouseEvent.CLICK, onEquipBox2);
			_equipBox[3].addEventListener(MouseEvent.CLICK, onEquipBox3);
			_equipBox[4].addEventListener(MouseEvent.CLICK, onEquipBox4);	
			
			//for(var num1:int = 0; num1<_equipBox.length; num1++){
			//	_equipBox[num1].addEventListener(MouseEvent.CLICK,onEquipBox);
				
			//}
		}
		
		private function onEquipBox(e:MouseEvent):void{
			for(var num:int = 0; num < onEquipBox.length; num++){				
				if(e.target == _equipBox[num] as MovieClip){					
				}
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
			
			_left.x = 20;
			_left.y = (_skinBG.height /2) + _left.height;	
			_left.rotationZ = 180;
			
			
			_right.x = _skinBG.width - 30;
			_right.y = _skinBG.height /2;
			
			//this.x = this.parent.width- this.width / 2;
			//this.y = 100;
			
			_skinBG.y = _horseEquip.height;
			
			//set icon coordinate			
			var _posX:int = 0;			
			for(var num:int = bodyItem.length -1; num>=0; num-- ){
				_posX += bodyItem[num].width - 8;				
				bodyItem[num].x = _skinBG.width - (_posX + 20);					
				equipItem[num].x = _skinBG.width - (_posX + 20);
			}
			
			//set new button tab
			_horseNew.gotoAndStop(3);
			switchButtonType(_NEW);
		}
		
		//set icomponent implementation		
		public function addListeners():void{
			//button 1
			
			//var _horseShop:ButtonTypeComponent = new ButtonTypeComponent(new BtnShop1Depth,onShopClick);			
			//addComponent();
			_horseShop.addEventListener(MouseEvent.MOUSE_OVER, onShopOver);
			_horseShop.addEventListener(MouseEvent.MOUSE_OUT, onShopOut);	
			_horseShop.addEventListener(MouseEvent.CLICK, onShopClick);
			_horseShop.mouseChildren = false;
			
			_horseStorage.addEventListener(MouseEvent.MOUSE_OVER, onStorageOver);
			_horseStorage.addEventListener(MouseEvent.MOUSE_OUT, onStorageOut);	
			_horseStorage.addEventListener(MouseEvent.CLICK, onStorageClick);
			_horseStorage.mouseChildren = false;
			
			//button 2
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
		
			if(e.target == bodyItem[0]){
				switchIconType(_MANE);		
			}
			if(e.target == bodyItem[1]){
				switchIconType(_EYES);	
			}
			if(e.target == bodyItem[2]){
				switchIconType(_MOUTH);	
			}
			if(e.target == bodyItem[3]){				
				switchIconType(_PATTERN);
			}
			if(e.target == bodyItem[4]){
				switchIconType(_SKIN);
			}		
			
			//equipment
			if(e.target == equipItem[0]){
				switchIconType(_HEAD);
			}
			if(e.target == equipItem[1]){
				switchIconType(_BRIDLE);
			}
			if(e.target == equipItem[2]){
				switchIconType(_SADDLE);	
			}
			if(e.target == equipItem[3]){				
				switchIconType(_WING);	
			}
			if(e.target == equipItem[4]){
				switchIconType(_ACC);
			}
		}
		
		private function onEquipBox0(e:MouseEvent):void{
			_type = _currentIconIndex;
			dispatchEvent(new HorseEquipEvent(HorseEquipEvent.CLICKED_BOX0));
		}		
		private function onEquipBox1(e:MouseEvent):void{
			_type = _currentIconIndex+1;
			dispatchEvent(new HorseEquipEvent(HorseEquipEvent.CLICKED_BOX1));
		}
		private function onEquipBox2(e:MouseEvent):void{
			_type = _currentIconIndex+2;
			dispatchEvent(new HorseEquipEvent(HorseEquipEvent.CLICKED_BOX2));
		}
		private function onEquipBox3(e:MouseEvent):void{
			_type = _currentIconIndex+3;
			dispatchEvent(new HorseEquipEvent(HorseEquipEvent.CLICKED_BOX3));
		}
		private function onEquipBox4(e:MouseEvent):void{
			_type = _currentIconIndex+4;
			dispatchEvent(new HorseEquipEvent(HorseEquipEvent.CLICKED_BOX4));
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
				case _MANE:										
					_part = _MANE;				
					break;
				
				case _EYES:		
					_part = _EYES;						
					break;
				case _MOUTH:	
					_part = _MOUTH;				
					break;
				case _PATTERN:	
					_part = _PATTERN;				
					break;
				case _SKIN:		
					_part = _SKIN;						
					break;				
				case _HEAD:		
					_part = _HEAD;					
					break;
				case _BRIDLE:
					_part = _BRIDLE;				
					break;
				case _SADDLE:
					_part = _SADDLE;					
					break;
				case _WING:
					_part = _WING;
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
			trace("NEW TEST");
			var num:int;
			//current equipbox icon index
			_currentIconIndex = 0;
			
			removeIcons();
			popAllInfoIcon();		
			
			switch(_part){
				case _MANE:					
					for( num = 0; num < _maneArray.length; num++){						
						_itemInfo.push(new itemInfoDisplay(_maneArray[num], 15,15));			
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
				case _PATTERN:
					
					for( num = 0; num < _patternArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_patternArray[num], 15,15));			
					}	
					break;
				case _SKIN:
					
					for( num = 0; num < _skinArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_skinArray[num], 15,15));			
					}		
					break;
				
				//Equipment
				case _HEAD:
					
					for( num = 0; num < _headArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_headArray[num], 15,15));			
					}		
					break;
				case _BRIDLE:
					
					for( num = 0; num < _bridleArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_bridleArray[num], 15,15));			
					}		
					break;
				case _SADDLE:					
					
					for( num = 0; num < _saddleArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_saddleArray[num], 15,15));			
					}		
					break;
				case _WING:
					
					for( num = 0; num < _wingArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_wingArray[num], 15,15));			
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
			
			_horseShop.removeEventListener(MouseEvent.MOUSE_OVER, onShopOver);
			_horseShop.removeEventListener(MouseEvent.MOUSE_OUT, onShopOut);	
			_horseShop.removeEventListener(MouseEvent.CLICK, onShopClick);
			_horseShop.mouseChildren = false;
			
			_horseStorage.removeEventListener(MouseEvent.MOUSE_OVER, onStorageOver);
			_horseStorage.removeEventListener(MouseEvent.MOUSE_OUT, onStorageOut);	
			_horseStorage.removeEventListener(MouseEvent.CLICK, onStorageClick);
			_horseStorage.mouseChildren = false;
			
			//button 2
			_horseNew.removeEventListener(MouseEvent.MOUSE_OVER, onNewOver);
			_horseNew.removeEventListener(MouseEvent.MOUSE_OUT, onNewOut);	
			_horseNew.removeEventListener(MouseEvent.CLICK, onNewClick);
			_horseNew.mouseChildren = false;
			
			_horseBody.removeEventListener(MouseEvent.MOUSE_OVER, onBodyOver);
			_horseBody.removeEventListener(MouseEvent.MOUSE_OUT, onBodyOut);	
			_horseBody.removeEventListener(MouseEvent.CLICK, onBodyClick);
			_horseBody.mouseChildren = false;
			
			_horseEquip.removeEventListener(MouseEvent.MOUSE_OVER, onEquipOver);
			_horseEquip.removeEventListener(MouseEvent.MOUSE_OUT, onEquipOut);	
			_horseEquip.removeEventListener(MouseEvent.CLICK, onEquipClick);
			_horseEquip.mouseChildren = false;	
			
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