package com.tada.clopclop.test.type.dfcomponents
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.horseequip.HorseComponent.tab.itemInfoDisplay;
	import com.tada.clopclop.horseequip.tool.ComboBoxClop;
	import com.tada.clopclop.horseequip.tool.EquipBox;
	import com.tada.clopclop.jockeyequip.JockeyComponent.JockeyEquipmentFrame;
	import com.tada.clopclop.jockeyequip.JockeyComponent.MatchPanel.MatchPanel;
	import com.tada.clopclop.jockeyequip.JockeyComponent.look.JockeyLookPanel;
	import com.tada.clopclop.jockeyequip.JockeyComponent.tab.JockeyTabbedPanel;
	import com.tada.clopclop.jockeyequip.tool.EquipJockey;
	import com.tada.clopclop.test.type.dfcomponents.event.JockeyEquipEvent;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.ui.UIMainFrame;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF (width = "700", height = "700", backgroundColor = "0xF4A0AA")] 
	public class JockeyFrameController extends UIMainFrame		
	{		
		private var _parent:DisplayObjectContainer;
		
		private var _view:View3D;
		private var _camera:CameraHover;
		
		private var _lookPanel:JockeyLookPanel;
		private var _tabPanel:JockeyTabbedPanel;
		private var _matchPanel:MatchPanel
		
		private var _combo:ComboBoxClop;
		
		private var _BE:String;
		private var _part:String;
		private var _type:int;
		
		//set jockey asset
		private var _equipJockey:EquipJockey;
		
		//buttons
		private var _equipBox:Array = [];
		
		//set equipbox icon
		private var _currentIconIndex:int;
		
		private var _itemInfo:Array= [];
		private var _hairArray:Array = [		
			"./assets/jockeyParts/hair_01.png",
			"./assets/jockeyParts/hair_02.png",
			"./assets/jockeyParts/hair_03.png"
			
		];
		private var _eyebrowArray:Array = [			
			"./assets/jockeyParts/eyebrow_01.png",
			"./assets/jockeyParts/eyebrow_02.png",
			"./assets/jockeyParts/eyebrow_03.png",
			"./assets/jockeyParts/eyebrow_04.png",
			"./assets/jockeyParts/eyebrow_05.png",
			"./assets/jockeyParts/eyebrow_06.png",
			"./assets/jockeyParts/eyebrow_07.png",
			"./assets/jockeyParts/eyebrow_08.png",
			"./assets/jockeyParts/eyebrow_09.png",
			"./assets/jockeyParts/eyebrow_10.png",
			"./assets/jockeyParts/eyebrow_11.png"
			
		];
		
		private var _eyesArray:Array = [			
			"./assets/jockeyParts/eye_01.png",	
			"./assets/jockeyParts/eye_02.png",	
			"./assets/jockeyParts/eye_03.png",	
			"./assets/jockeyParts/eye_04.png",	
			"./assets/jockeyParts/eye_05.png",	
			"./assets/jockeyParts/eye_06.png",	
			"./assets/jockeyParts/eye_07.png",	
			"./assets/jockeyParts/eye_08.png",	
			"./assets/jockeyParts/eye_09.png",	
			"./assets/jockeyParts/eye_10.png",	
			"./assets/jockeyParts/eye_11.png",	
			"./assets/jockeyParts/eye_12.png",	
			"./assets/jockeyParts/eye_13.png"	
		];	
		private var _mouthArray:Array = [
			"./assets/jockeyParts/mouth_01.png",
			"./assets/jockeyParts/mouth_02.png",
			"./assets/jockeyParts/mouth_03.png",
			"./assets/jockeyParts/mouth_04.png",
			"./assets/jockeyParts/mouth_05.png",
			"./assets/jockeyParts/mouth_06.png",
			"./assets/jockeyParts/mouth_07.png",
			"./assets/jockeyParts/mouth_08.png",
			"./assets/jockeyParts/mouth_09.png",
			"./assets/jockeyParts/mouth_10.png",
			"./assets/jockeyParts/mouth_11.png",
			"./assets/jockeyParts/mouth_12.png",
			"./assets/jockeyParts/mouth_13.png",
			"./assets/jockeyParts/mouth_14.png"		
		];	
		private var _skinArray:Array = [
			"./assets/jockeyParts/skin_01.png",
			"./assets/jockeyParts/skin_02.png",
			"./assets/jockeyParts/skin_03.png"
		];	
		
		//Equipment
		
		private var _topArray:Array = [	
			"./assets/jockeyItems/top_01.png",	
			"./assets/jockeyItems/top_02.png",	
			"./assets/jockeyItems/top_03.png",	
			"./assets/jockeyItems/top_04.png",	
			"./assets/jockeyItems/top_05.png",	
			"./assets/jockeyItems/top_06.png",	
			"./assets/jockeyItems/top_07.png",	
			"./assets/jockeyItems/top_08.png",	
			"./assets/jockeyItems/top_09.png",	
			"./assets/jockeyItems/top_10.png",	
			"./assets/jockeyItems/top_11.png",	
			"./assets/jockeyItems/top_12.png",	
			"./assets/jockeyItems/top_13.png",	
			"./assets/jockeyItems/top_14.png",	
			"./assets/jockeyItems/top_15.png",	
			"./assets/jockeyItems/top_16.png",	
			"./assets/jockeyItems/top_18.png",	
			"./assets/jockeyItems/top_19.png"			
		];	
		private var _bottomArray:Array = [
			"./assets/jockeyItems/bottom_01.png",
			"./assets/jockeyItems/bottom_02.png",
			"./assets/jockeyItems/bottom_03.png",
			"./assets/jockeyItems/bottom_04.png",
			"./assets/jockeyItems/bottom_05.png",
			"./assets/jockeyItems/bottom_06.png",
			"./assets/jockeyItems/bottom_07.png",
			"./assets/jockeyItems/bottom_08.png",
			"./assets/jockeyItems/bottom_09.png",
			"./assets/jockeyItems/bottom_10.png",
			"./assets/jockeyItems/bottom_11.png",
			"./assets/jockeyItems/bottom_12.png",
			"./assets/jockeyItems/bottom_13.png",
			"./assets/jockeyItems/bottom_14.png",
			"./assets/jockeyItems/bottom_15.png",
			"./assets/jockeyItems/bottom_16.png",
			"./assets/jockeyItems/bottom_17.png"		
		];	
		private var _hatArray:Array = [
			"./assets/jockeyItems/hat_01.png",
			"./assets/jockeyItems/hat_02.png",
			"./assets/jockeyItems/hat_03.png",
			"./assets/jockeyItems/hat_04.png",
			"./assets/jockeyItems/hat_05.png",
			"./assets/jockeyItems/hat_06.png",
			"./assets/jockeyItems/hat_07.png",
			"./assets/jockeyItems/hat_08.png",
			"./assets/jockeyItems/hat_09.png",
			"./assets/jockeyItems/hat_10.png",
			"./assets/jockeyItems/hat_11.png",
			"./assets/jockeyItems/hat_12.png",
			"./assets/jockeyItems/hat_13.png",
			"./assets/jockeyItems/hat_14.png",
			"./assets/jockeyItems/hat_15.png",
			"./assets/jockeyItems/hat_16.png",
			"./assets/jockeyItems/hat_17.png",
			"./assets/jockeyItems/hat_18.png",
			"./assets/jockeyItems/hat_19.png",
			"./assets/jockeyItems/hat_20.png"
		];
		private var _shoesArray:Array = [
			"./assets/jockeyItems/shoes_01.png",
			"./assets/jockeyItems/shoes_02.png",
			"./assets/jockeyItems/shoes_03.png"
		];
		private var _accArray:Array = [
			"./assets/jockeyItems/accessory_01.png",
			"./assets/jockeyItems/accessory_02.png",
			"./assets/jockeyItems/accessory_03.png",
			"./assets/jockeyItems/accessory_04.png",
			"./assets/jockeyItems/accessory_05.png"
		];
		
		public function JockeyFrameController(_topLayer:DisplayObjectContainer)
		{
			super(new SkinFrame, new LabelHorseEquipment);
			
			//_topLayer:DisplayObjectContainer			
			_parent = _topLayer;				
		}
		public function visibility(_value:Boolean):void{
			if(_value){
				showUI(_parent);
			}
			else{
				hideUI();
			}
		}	
		public function startJockeyEquipController():void{	
			initialization();		
			setProperties();							
			setEquipBox();			
			addListener();
			displayComponent();		
			
			addComboItem("test additem#1");
			
		}
		
		private function initialization():void{				
			_camera = new CameraHover(stage);
			_camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);
			_camera.fov = 60;
			_view = new View3D;
			_view.camera = _camera;	
			
			_equipJockey = new EquipJockey(_view);
			
			_lookPanel = new JockeyLookPanel(_view);
			_tabPanel = new JockeyTabbedPanel;		
			_matchPanel = new MatchPanel;
			
			//set combo
			_combo = new ComboBoxClop(new SkinComboBoxJockeyTop,new SkinComboBoxJockeMid,new SkinComboBoxJockeyBottom,new SkinComboBoxJockeyHighlight,new BtnNameArrowUp);
					
		}		
		
		private function displayComponent():void{
			addComponent("TabPanel", _tabPanel, (this.width /2) - (_tabPanel.width / 2), this.height - (_tabPanel.height  + 70));
			addComponent("LookPanel", _lookPanel, 50, 40);
			addComponent("MatchPanel",_matchPanel, _lookPanel.width + _lookPanel.x + 10, 70);
			//_jockeyFrame.addComponent("ComboBox", _combo, ((_lookPanel.width/2) - (_combo.width/2))+ 50, (_lookPanel.height -_combo.height/2 ) + 40);
			
	
		}
		
		//methods for lookpanel and combobox
		public function setEquipJockey(BE:String, part:String, type:int):void{
			var _BE:String = BE;
			var _part:String = part;
			var _type:int = type;
			
			_equipJockey.itemEquip(_BE,_part,_type);
		}
		
		private function addComboItem(item:String):void{			
			_combo.addItem(item);			
		}
		
		private function setProperties():void{
			
		}
		
		private function addListener():void{			
			this.addEventListener(Event.ENTER_FRAME, onEnter);	
			
			//jockey body icons
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_HAIR, onHair);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_EYEBROW, onEyeBrow);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_EYES, onEyes);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_MOUTH, onMouth);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_SKIN, onSkin);
			
			//jockey equip icons
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_TOP, onTop);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOTTOM, onBottom);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_HAT, onHat);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_SHOES, onShoes);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_ACC, onAcc);
			
			//left right icons
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_LEFT, onLeft);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_RIGHT, onRight);
			
			//equipbox
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX0, onBox0);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX1, onBox1);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX2, onBox2);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX3, onBox3);
			_tabPanel.addEventListener(JockeyEquipEvent.CLICKED_BOX4, onBox4);
		}	
		
		private function onBox0(e:JockeyEquipEvent):void{
			_type = _currentIconIndex;
			setEquipJockey(_BE, _part, _type);		
		}		
		private function onBox1(e:JockeyEquipEvent):void{
			_type = _currentIconIndex+1;
			setEquipJockey(_BE, _part, _type);
		}
		private function onBox2(e:JockeyEquipEvent):void{
			_type =  _currentIconIndex+2;
			setEquipJockey(_BE, _part, _type);
		}
		private function onBox3(e:JockeyEquipEvent):void{
			_type =  _currentIconIndex+3;	
			setEquipJockey(_BE, _part, _type);
		}
		private function onBox4(e:JockeyEquipEvent):void{
			_type =  _currentIconIndex+4;
			setEquipJockey(_BE, _part, _type);
		}
		
		private function onLeft(e:JockeyEquipEvent):void{
			
			if(_currentIconIndex>0){
				_currentIconIndex -=5;	
			}
			
			removeIcons();
			displayIcons();		
		}
		
		private function onRight(e:JockeyEquipEvent):void{
			
			if(_currentIconIndex<_itemInfo.length - 5){
				_currentIconIndex +=5;
			}
			removeIcons();
			displayIcons();
		}
		
		private function setEquipBox():void{
			for (var num:int = 0;num < 5;num++)
			{				
				_equipBox[num] = new EquipBox;			
			}			
			_tabPanel.setTabEquipBox(_equipBox);
		}
		
		private function onHair(e:JockeyEquipEvent):void{	
			_part = JockeyEquipEvent.CLICKED_HAIR;			
			switchIcon(_part);
		}
		private function onEyeBrow(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_EYEBROW;		
			switchIcon(_part);
		}
		private function onEyes(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_EYES;		
			switchIcon(_part);
		}
		private function onMouth(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_MOUTH;		
			switchIcon(_part);
		}
		private function onSkin(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_SKIN;		
			switchIcon(_part);
		}
		
		//Equipment
		private function onTop(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_TOP;		
			switchIcon(_part);
		}
		private function onBottom(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_BOTTOM;		
			switchIcon(_part);
		}
		private function onHat(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_HAT;		
			switchIcon(_part);
		}
		private function onShoes(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_SHOES;		
			switchIcon(_part);
		}
		private function onAcc(e:JockeyEquipEvent):void{
			_part = JockeyEquipEvent.CLICKED_ACC;		
			switchIcon(_part);
		}
		
		private function switchIcon(_part:String):void{
			var num:int;
			//current equipbox icon index
			_currentIconIndex = 0;
			
			removeIcons();
			popAllInfoIcon();		
			
			switch(_part){
				case JockeyEquipEvent.CLICKED_HAIR:
					_BE = "B";		
					for( num = 0; num < _hairArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_hairArray[num], 15,15));			
					}			
					break;
				
				case JockeyEquipEvent.CLICKED_EYEBROW:
					_BE = "B";		
					for( num = 0; num < _eyebrowArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_eyebrowArray[num], 15,15));			
					}		
					
					break;
				case JockeyEquipEvent.CLICKED_EYES:
					_BE = "B";		
					for( num = 0; num < _eyesArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_eyesArray[num], 15,15));			
					}		
					break;
				case JockeyEquipEvent.CLICKED_MOUTH:
					_BE = "B";		
					for( num = 0; num < _mouthArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_mouthArray[num], 15,15));			
					}	
					break;
				case JockeyEquipEvent.CLICKED_SKIN:
					_BE = "B";		
					for( num = 0; num < _skinArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_skinArray[num], 15,15));			
					}		
					break;
				
				//Equipment
				case JockeyEquipEvent.CLICKED_TOP:
					_BE = "E";		
					for( num = 0; num < _topArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_topArray[num], 15,15));			
					}					
					break;
				case JockeyEquipEvent.CLICKED_BOTTOM:
					_BE = "E";		
					for( num = 0; num < _bottomArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_bottomArray[num], 15,15));			
					}		
					break;
				case JockeyEquipEvent.CLICKED_HAT:
					_BE = "E";		
					for( num = 0; num < _hatArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_hatArray[num], 15,15));			
					}		
					break;
				case JockeyEquipEvent.CLICKED_SHOES:
					_BE = "E";		
					for( num = 0; num < _shoesArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_shoesArray[num], 15,15));			
					}		
					break;
				case JockeyEquipEvent.CLICKED_ACC:
					_BE = "E";		
					for( num = 0; num < _accArray.length; num++){
						_itemInfo.push(new itemInfoDisplay(_accArray[num], 15,15));			
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
		
		private function onEnter(e:Event):void{
			_view.render();				
		}	
	}
}