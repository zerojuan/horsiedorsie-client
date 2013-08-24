package com.tada.clopclop.jockeyequip.old
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.common.EquipItemBoxModel;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import com.tada.clopclop.jockeyequip.tool.EquipJockey;
	
	public class JockeyEquipView extends Sprite
	{		
		private var _comboBox:JockeyComboBoxCustom;
		private var _comboArray:Array = new Array();
		private var _jockeyEquipUI:JockeyEquipUI;
		private var _comboButtons:JockeyComboBoxButtons;
		private var _comboJockey:Number = 30; //Math.floor((Math.random()*50)+5);
		private var _jockeyName:String;
		private var _scroll:Number=0;
		private var _barMove:Number;
		private var showNew:Boolean = true;
		private var partnership:uint
		private var currentPartnership:uint = 0
		private var currentBonusPartnership:uint = 0
		private var comboBoxElements:MovieClip
		private var _scrollBar:MovieClip;
		private var _scrollBarStart:Number;
		private var _scrollBarEnd:Number;
		private var _maxDistance:Number;
		public var _equipItemBox:EquipItemBoxModel
		private var _equipItemBoxPointer:Object
		
		private var _EquipJockey:EquipJockey;
		private var view:View3D;
		
		private var animateButtonArray:Array = [
			"shop_sub_0",
			"mystorage_sub_0",
			"newi_sub_1",
			"body_sub_1",
			"equipment_sub_1"
		]
		
		private var bodyButtonArray:Array = [
			"hair_sub_2",
			"eyebrows_sub_2",
			"eyes_sub_2",
			"mouth_sub_2",
			"skincolor_sub_2"
		]
		
		private var equipmentButtonArray:Array = [
			"top_sub_2",
			"bottom_sub_2",
			"head_sub_2",
			"shoes_sub_2",
			"accessory_sub_2"
		]
		
		public function JockeyEquipView(_view3D:View3D)
		{					
			view = _view3D;
		}
		public function initJockeyEquipView():void 
		{
			inheritJockeyEquipUI();
			
			initializePosition(0,0);	
			
			initializeComboBox();
			
			visibility(false);
			
			initializeObjects();
			
			initializeComboArray(_comboJockey);
			
			activateSubZero("shop_sub_0");
			
			activateSubOne("newi_sub_1");
			
			deActivate("mystorage_sub_0");
			
			deActivate("body_sub_1");
			
			deActivate("equipment_sub_1");
			
			initializeSprite();
			
			initializeEquipItemBox("jockey");			
			
			addListeners();
		}
		
		private function initializeSprite():void{
			addChild(view);
			_EquipJockey = new EquipJockey(view);
		}
		
		private function initializeEquipItemBox(type:String):void
		{
			_equipItemBox = new EquipItemBoxModel(type,_jockeyEquipUI.jockeyEquipmentMove, _EquipJockey);
			_equipItemBox.name = "_equipItemBox"
			_jockeyEquipUI.jockeyEquipmentMove.itemEquipmentHolder.addChild(_equipItemBox)
			_equipItemBoxPointer = _equipItemBox
			_equipItemBox.initEquipItemBoxModel();	
			
		}
		private function inheritJockeyEquipUI():void 
		{
			_jockeyEquipUI = new JockeyEquipUI;
			_jockeyEquipUI.name = "_jockeyEquipUI";
			addChild(_jockeyEquipUI);
		}
		private function activateSubZero(selected:String):void 
		{
			var selected_animate:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(selected + "_animate");
			var selected_button:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(selected + "_button");
			
			selected_animate.visible = true;
			selected_button.visible = false;
		}
		private function activateSubOne(selected:String):void 
		{
			var selected_animate:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(selected + "_animate");
			var selected_button:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(selected + "_button");
			
			selected_animate.visible = true;
			selected_button.visible = false;
		}
		private function deActivate(unselected:String):void
		{
			var unselected_animate:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(unselected+"_animate");
			var unselected_button:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(unselected+"_button");
			
			unselected_animate.visible = false;
			unselected_button.visible = true;
		}
		private function hideObj(unselected:String):void
		{
			var unselected_animate:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(unselected+"_animate");
			var unselected_button:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(unselected+"_button");
			
			unselected_animate.visible = false;
			unselected_button.visible = false;
		}
		private function initializeObjects():void 
		{
			resetBodyButtons(false);
			resetEquipmentButtons(false);
		}		
		private function initializeComboBox():void
		{
			//_comboBox = new JockeyComboBoxCustom;
			//_comboBox.name = "_comboBox";
			//_jockeyEquipUI.jockeyEquipmentMove.addChild(_comboBox);
			//_comboBox.x = 93.7;
			//_comboBox.y = 260.4;
		}
		private function initializeComboArray(n:Number):void
		{
			_comboButtons = new JockeyComboBoxButtons()
			for (var i:Number = 0;i<n;i++){
				
				_comboArray[i] = new JockeyComboBoxButtons()
				comboBoxElements = _comboArray[i]
				comboBoxElements.currentHighlight.visible = false;
				comboBoxElements.mouseChildren = false;
				_jockeyName = String("Horse: "+i);
				comboBoxElements.jockeyName.text = _jockeyName;
				comboBoxElements.addEventListener(MouseEvent.MOUSE_OVER,selectButton);
				comboBoxElements.addEventListener(MouseEvent.MOUSE_OUT,unSelectButton);
				comboBoxElements.addEventListener(MouseEvent.CLICK ,selectedButton);
				//_comboBox.arrayButtonsHolder.addChild(comboBoxElements);
				
				comboBoxElements.x = 0
				comboBoxElements.y = 23.05*i
				
			}
			_maxDistance = -23.05*(n-5);
			//_scrollBar = _comboBox.scrollBarWheel.scrollBarWheel;
			//_scrollBarStart = 5+(_scrollBar.height/2)*-1;
			//_scrollBarEnd = 64 + (_scrollBar.height)*-1;
			//_barMove = (60-(_scrollBar.height/2))/(n-4);
			//_scrollBar.y = _scrollBarStart;
		}
		private function resetBodyButtons(value:Boolean):void
		{
			for (var i:Number=0; i<bodyButtonArray.length; i++) 
			{
				var getAnimateButton:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName(bodyButtonArray[i] + "_button")
				getAnimateButton.visible = value
			}
		}
		private function resetEquipmentButtons(value:Boolean):void
		{
			for (var i:Number=0; i<equipmentButtonArray.length; i++) 
			{
				var getAnimateButton:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName( equipmentButtonArray[i] + "_button")
				getAnimateButton.visible = value
			}
		}
		public function visibility(value:Boolean):void 
		{
			visible = value
			//note: for controlling partnership
			if (visible)
			{
				randomStat();
				rollComboBox(true);
			}
		}
		private function randomStat():void
		{
			var trialBonus1: uint =(Math.round(Math.random()*100))
			var trialBonus2: uint =(Math.round(Math.random()*50))
			if ((trialBonus1 + trialBonus2) >= 100)
			{
				trialBonus2 = 100 - trialBonus1
			}
			setPartnershipBar(trialBonus1,trialBonus2)
		}		
		public function rollComboBox(value:Boolean):void
		{
			_comboBox.rollDown.visible = value;
			if (value == false){
				_scrollBar.y = _scrollBarStart;
				_comboBox.play();
			}else
				_comboBox.gotoAndStop(0);
		}
		
		private function addListeners():void 
		{
			//click listeners for done and close
			_jockeyEquipUI.jockeyEquipmentMove.done.addEventListener(MouseEvent.CLICK,clickDoneButton)
			_jockeyEquipUI.jockeyEquipmentMove.close.addEventListener(MouseEvent.CLICK,clickCloseButton)
			
			//click listeners for shop and storage
			_jockeyEquipUI.jockeyEquipmentMove.shop_sub_0_button.addEventListener(MouseEvent.CLICK,clickD1ShopButton)
			_jockeyEquipUI.jockeyEquipmentMove.mystorage_sub_0_button.addEventListener(MouseEvent.CLICK,clickD1MyStorageButton)
			
			//click listeners for equipments
			_jockeyEquipUI.jockeyEquipmentMove.newi_sub_1_button.addEventListener(MouseEvent.CLICK,clickD2NewButton)
			_jockeyEquipUI.jockeyEquipmentMove.body_sub_1_button.addEventListener(MouseEvent.CLICK,clickD2BodyButton)
			_jockeyEquipUI.jockeyEquipmentMove.equipment_sub_1_button.addEventListener(MouseEvent.CLICK,clickD2EquipmentButton)
			
			//click listeners for combobox
			//_comboBox.rollDown.addEventListener(MouseEvent.CLICK,clickComboBox)
			//_comboBox.scrollBarDown.addEventListener(MouseEvent.CLICK,clickScrollBarDown)
			//_comboBox.scrollBarUp.addEventListener(MouseEvent.CLICK,clickScrollBarUp)
			//_scrollBar.addEventListener(MouseEvent.MOUSE_DOWN,drag)
		}
		private function clickDoneButton(me:MouseEvent):void
		{
			var _clopClopMainController:Object = parent.getChildByName("_clopclopMainController");
			_clopClopMainController.visibilityUI("_jockeyEquipController",false)
			_clopClopMainController.visibilityUI("_socialController",true)
		}
		private function clickCloseButton(me:MouseEvent):void
		{
			clickDoneButton(me);
		}
		private function clickComboBox(me:MouseEvent):void
		{
			rollComboBox(false);
			/*_comboBox.play();
			_comboBox.rollDown.visible = false;*/
		}
		private function clickScrollBarDown(me:MouseEvent):void
		{
			_comboBox.arrayButtonsHolder.y -=23.05;
			_scrollBar.y += _barMove;
			if (_scrollBar.y >_scrollBarEnd)
			{
				_scrollBar.y = _scrollBarEnd;
				_comboBox.arrayButtonsHolder.y=_maxDistance
			}
		}
		private function clickScrollBarUp(me:MouseEvent):void
		{
			_comboBox.arrayButtonsHolder.y +=23.05;
			_scrollBar.y -= _barMove;
			if (_scrollBar.y < _scrollBarStart){
				_scrollBar.y = _scrollBarStart;
				_comboBox.arrayButtonsHolder.y=34.575;
			}
		}
		private function drag(e:MouseEvent):void
		{
			_scrollBar.addEventListener(MouseEvent.MOUSE_MOVE,moveScrollBar)
			_scrollBar.addEventListener(MouseEvent.MOUSE_UP,stpDrag)
		}
		private function upScrollWheel(e:MouseEvent):void
		{
			_scrollBar.removeEventListener(MouseEvent.MOUSE_MOVE,moveScrollBar)
			_scrollBar.removeEventListener(MouseEvent.MOUSE_UP,stpDrag)
		}
		private function stpDrag():void
		{
			_scrollBar.removeEventListener(MouseEvent.MOUSE_MOVE,moveScrollBar)
			_scrollBar.removeEventListener(MouseEvent.MOUSE_UP,stpDrag)
		}
		private function moveScrollBar(e:MouseEvent):void
		{
			//var boxy:Number = localToGlobal(box.y)
			var currentPos:Number = _scrollBar.y;
			var holder:Number = 0;
			if (_scrollBar.y >= (_scrollBarStart) && _scrollBar.y <= (_scrollBarEnd))
			{ 
				_scrollBar.y = mouseY -(_scrollBar.height/1.5)-331;
				if (holder == 0){
					holder = currentPos - _scrollBar.y;
				}
				indexScroll(holder);
			}
			else if (_scrollBar.y < _scrollBarStart) {
				_scrollBar.y = _scrollBarStart;
				_comboBox.arrayButtonsHolder.y=34.575;
				stpDrag();
			}
			else if (_scrollBar.y > _scrollBarEnd) {
				_scrollBar.y = _scrollBarEnd;
				_comboBox.arrayButtonsHolder.y=_maxDistance
				stpDrag();
			}
			_scrollBar.addEventListener(MouseEvent.MOUSE_OUT,upScrollWheel);
		}
		private function indexScroll(i:Number):void 
		{
			_comboBox.arrayButtonsHolder.y+=(23.05/1.5)*i;
		}
		private function selectButton(me:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(me.target);
			mc.currentHighlight.visible = true;
		}
		private function unSelectButton(me:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(me.target);
			mc.currentHighlight.visible = false;
		}
		private function selectedButton(me:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(me.target);
			_comboBox.currentSelection.jockeyName.text = String(mc.jockeyName.text);
			randomStat();
			_comboBox.gotoAndStop(1);
			_comboBox.rollDown.visible = true;
		}
		private function clickD1ShopButton(me:MouseEvent):void
		{
			activateSubZero("shop_sub_0");
			deActivate("mystorage_sub_0");
			activateSubOne("newi_sub_1");
			deActivate("body_sub_1");
			deActivate("equipment_sub_1");
			showNew = true;
			initializeObjects();
			_equipItemBoxPointer.d1Listeners(me)
		}
		private function clickD1MyStorageButton(me:MouseEvent):void
		{
			showNew = false;
			hideObj("newi_sub_1");
			deActivate("shop_sub_0");
			deActivate("equipment_sub_1");
			activateSubZero("mystorage_sub_0");
			activateSubOne("body_sub_1");
			resetBodyButtons(true);
			resetEquipmentButtons(false);
			_equipItemBoxPointer.d1Listeners(me)
		}
		private function clickD2NewButton(me:MouseEvent):void
		{
			activateSubOne("newi_sub_1");
			deActivate("body_sub_1");
			deActivate("equipment_sub_1");
			initializeObjects();
			_equipItemBoxPointer.d2Listeners(me)
		}
		private function clickD2BodyButton(me:MouseEvent):void
		{
			activateSubOne("body_sub_1");
			deActivate("equipment_sub_1");
			if (showNew == true) 
			{
				deActivate("newi_sub_1");
			}
			resetBodyButtons(true);
			resetEquipmentButtons(false);
			_equipItemBoxPointer.d2Listeners(me)
		}
		private function clickD2EquipmentButton(me:MouseEvent):void
		{
			activateSubOne("equipment_sub_1");
			deActivate("body_sub_1");
			if (showNew == true)
			{
				deActivate("newi_sub_1");
			}
			resetBodyButtons(false);
			resetEquipmentButtons(true);
			_equipItemBoxPointer.d2Listeners(me)
			
		}
		private function initializePosition(pos_x:Number,pos_y:Number):void
		{
			x = pos_x;
			y = pos_y;
		}
		public function setPartnershipBar(newPartnership:uint,newBonusPartnership:uint):void
		{
			partnership = setInterval(animatePartnershipBar,1,newPartnership,newBonusPartnership);	
		}
		private function animatePartnershipBar(newP:uint,newBonusP:uint):void
		{
			if (currentPartnership < newP)
			{
				currentPartnership += 1							
			}
			if (currentPartnership > newP)
			{
				currentPartnership -=1				
			}
			if (currentBonusPartnership < newBonusP)
			{
				currentBonusPartnership += 1				
			}
			if (currentBonusPartnership > newBonusP)
			{
				currentBonusPartnership -= 1
			}				
			else if (currentPartnership == newP)
			{
				clearInterval(partnership)
			}
			movePartnershipBar()
		}
		private function movePartnershipBar():void
		{
			var orange_Bar:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName("partnershipGaugeOrangeMC")
			var yellow_Bar:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName("partnershipGaugeYellowMC")
			var text_Bar:Object = _jockeyEquipUI.jockeyEquipmentMove.getChildByName("partnershipText")
			var bonus:uint = currentPartnership + currentBonusPartnership
			var additional:String =""
			if (bonus >= 100)
			{
				bonus = 100
			}
			if (currentBonusPartnership > 0)
			{
				additional = " + " + String(currentBonusPartnership)
			}
			orange_Bar.gotoAndStop(bonus)
			yellow_Bar.gotoAndStop(currentPartnership)
			text_Bar.gotoAndStop(currentPartnership)
			
			text_Bar.partnershipGaugeText.text = String(currentPartnership)+ additional 
		}
	}
}