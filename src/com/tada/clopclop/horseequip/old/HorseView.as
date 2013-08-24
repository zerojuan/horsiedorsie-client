package com.tada.clopclop.horseequip.old
{
	import com.away3d.containers.View3D;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.tada.clopclop.events.NavigationEvent;
	import com.tada.clopclop.horseequip.tool.EquipHorse;
	import com.tada.clopclop.toolsets.character.horse.HorseGR;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	import com.tada.engine.TEngine;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.tada.clopclop.horseequip.itemInfo;
	
	//import popUpUI_fla.horse_summary_UI_status_bar_max_animate_18;
	
	//import socialUI_fla.horse_equip_btn_over_mc_43;
	//import socialUI_fla.horse_equip_btn_over_txt_mc_motion_46;

	[SWF(height = "860", width= "700")]	
	
	public class HorseView extends Sprite
	{	
		//array that holds the movie clip D4ItemButton
		private var equipBox:Array = [];
		
		private var boxIconArray:Array = [];
		//assets UI
		public var HorseEquip:HorseEquipUISet;			
		
		private var iconEye:Array = [];		
		private var iconMane:Array = [];
		private var iconMouth:Array = [];
		private var index:int;
		
		private var itemInformation:Array = [];
		
		public var name1:String = "";
		public var name2:String = "";		
		public var type:int = 0;
		
		private var _EquipHorse:EquipHorse;
		private var view:View3D;
		
		private var buttonIndex:Array = [];
		
		//starting index of current button array
		private var currentIndex:int = 0;
		
		private var _horseGR:HorseGR = HorseGR.getInstance();
		private var HorseController:HorseEquipController;
		
		private var buyMC:BuyEquip;
		private var sellMC:SellEquip;
	
		public function HorseView(view3d:View3D,horseEquipController:HorseEquipController)
		{			
			
			HorseController = horseEquipController;		
			
			view = view3d;	
			
			instantiation();
			//initializeSprite(view3d);
			
			visibility(false);
			
			SetDefaultUI();						
			
			setD4ItemButton();
			//setAllIconVisible();
			setAllIconHide();			
			seticonIndex();				
			addListeners();				
		}		
		
		private function onAssetXMLLoaded(evt:HorseEvent):void{
			_horseGR.removeOnXMLLoaded(onAssetXMLLoaded);			
		}
				
		private function instantiation():void{			
			HorseEquip = new HorseEquipUISet;
			addChild(HorseEquip);		
			
			HorseEquip.x = 0;
			HorseEquip.y = 50;
			
			buyMC = new BuyEquip;		
		}	
		
		
		//set ASSETS		
		private function maneButton(e:MouseEvent):void{	
			currentIndex = 0;
			seticonIndex();
		
			removeAllIcons();
			popAllArray();			
			
			itemInformation.push(new itemInfo(new HBMane01, "eye1"));
			itemInformation.push(new itemInfo(new HBMane02, "eye2"));
			itemInformation.push(new itemInfo(new HBMane03, "eye3"));
			itemInformation.push(new itemInfo(new HBMane04, "eye4"));
			itemInformation.push(new itemInfo(new HBMane05, "eye5"));
			itemInformation.push(new itemInfo(new HBMane06, "eye6"));
			itemInformation.push(new itemInfo(new HBMane07, "eye7"));
			itemInformation.push(new itemInfo(new HBMane08, "eye8"));
			itemInformation.push(new itemInfo(new HBMane09, "eye9"));
			itemInformation.push(new itemInfo(new HBMane10, "eye10"));
			itemInformation.push(new itemInfo(new HBMane11, "eye11"));
			itemInformation.push(new itemInfo(new HBMane12, "eye12"));			
		
			//removeAllIcons();
			addAllIcons();
			name2 = "Mane";
		}
		
		private function eyeButton(e:MouseEvent):void{	
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();		
			
			itemInformation.push(new itemInfo(new HBEye01, "eye1"));
			itemInformation.push(new itemInfo(new HBEye02, "eye2"));
			itemInformation.push(new itemInfo(new HBEye03, "eye3"));
			itemInformation.push(new itemInfo(new HBEye04, "eye4"));
			itemInformation.push(new itemInfo(new HBEye05, "eye5"));
			itemInformation.push(new itemInfo(new HBEye06, "eye6"));
			itemInformation.push(new itemInfo(new HBEye07, "eye7"));
			itemInformation.push(new itemInfo(new HBEye08, "eye8"));
			itemInformation.push(new itemInfo(new HBEye09, "eye9"));
			itemInformation.push(new itemInfo(new HBEye10, "eye10"));
			itemInformation.push(new itemInfo(new HBEye11, "eye11"));
			itemInformation.push(new itemInfo(new HBEye12, "eye12"));
			itemInformation.push(new itemInfo(new HBEye13, "eye13"));
			itemInformation.push(new itemInfo(new HBEye14, "eye14"));		
				
			//removeAllIcons();
			addAllIcons();	
			name2 = "Eye";
		}
		
		private function mouthButton(e:MouseEvent):void{			
			currentIndex = 0;
			seticonIndex();
			removeAllIcons();
			popAllArray();
			
			
			itemInformation.push(new itemInfo(new HBMouth01, "eye1"));
			itemInformation.push(new itemInfo(new HBMouth02, "eye2"));
			itemInformation.push(new itemInfo(new HBMouth03, "eye3"));
			itemInformation.push(new itemInfo(new HBMouth04, "eye4"));
			itemInformation.push(new itemInfo(new HBMouth05, "eye5"));
			itemInformation.push(new itemInfo(new HBMouth06, "eye6"));	
			
			//removeAllIcons();
			addAllIcons();	
			name2 = "Mouth";
		}
		
		private function skinButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
		
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new HBSkin01, "eye1"));
			itemInformation.push(new itemInfo(new HBSkin02, "eye2"));
			itemInformation.push(new itemInfo(new HBSkin03, "eye3"));
			itemInformation.push(new itemInfo(new HBSkin04, "eye4"));
			itemInformation.push(new itemInfo(new HBSkin05, "eye5"));
			itemInformation.push(new itemInfo(new HBSkin06, "eye6"));	
			itemInformation.push(new itemInfo(new HBSkin07, "eye6"));
			itemInformation.push(new itemInfo(new HBSkin08, "eye6"));
			
			
			addAllIcons();			
			name2 = "Skin";
		}
		
		private function saddleButton(e:MouseEvent):void{			
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();		
			
			itemInformation.push(new itemInfo(new HESaddle01, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle02, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle03, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle04, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle05, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle06, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle07, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle08, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle09, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle10, "eye1"));
			itemInformation.push(new itemInfo(new HESaddle11, "eye1"));
			
			//removeAllIcons();
			addAllIcons();	
			name2 = "Saddle";
		}
		
		private function bridleButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();			
			
			itemInformation.push(new itemInfo(new HEBridle01, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle02, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle03, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle04, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle05, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle06, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle07, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle08, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle09, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle10, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle11, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle12, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle13, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle14, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle15, "eye1"));
			itemInformation.push(new itemInfo(new HEBridle16, "eye1"));
			
			//removeAllIcons();
			addAllIcons();	
			name2 = "Bridle";
		}
		
		private function wingsButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			popAllArray();
			removeAllIcons();
			
			itemInformation.push(new itemInfo(new HEWing01, "eye1"));			
			addAllIcons();	
			name2 = "Wing";
		}
		
		private function addAllIcons():void{			
			
			for(var i:int = currentIndex ; i < itemInformation.length; i++){
				itemInformation[i].addItemIcon();				
			}
			
			for(var x:int = 0 ; x < equipBox.length; x++){
				if(itemInformation[x]!=null ){
					equipBox[x].itemHolder.Image.addChild(itemInformation[currentIndex + x]);
				}				
			}				
		}
			
		private function removeAllIcons():void{
			for(var i:int = 0 ; i < itemInformation.length; i++){
				itemInformation[i].removeItemIcon();				
			}
		}
		
		private function buttonBox0(e:MouseEvent):void{		
			//_EquipHorse.itemEquip(name1, name2, buttonIndex[0]);			
			trace(name1 + " " + name2 + " " + buttonIndex[0] + " " + itemInformation.length);
			type = buttonIndex[0];	
			
			updateTexture(0);			
		}
		private function buttonBox1(e:MouseEvent):void{			
			//_EquipHorse.itemEquip(name1, name2, buttonIndex[1]);
			trace(name1 + " " + name2 + " " + buttonIndex[1]+ " " + itemInformation.length);
			type = buttonIndex[1];
			updateTexture(1);
			
		}
		private function buttonBox2(e:MouseEvent):void{		
			//_EquipHorse.itemEquip(name1, name2, buttonIndex[2]);
			trace(name1 + " " + name2 + " " + buttonIndex[2]+ " " + itemInformation.length);
			type = buttonIndex[2];
			updateTexture(2);
		}
		private function buttonBox3(e:MouseEvent):void{			
			//_EquipHorse.itemEquip(name1, name2, buttonIndex[3]);
			trace(name1 + " " + name2 + " " + buttonIndex[3]+ " " + itemInformation.length);
			type = buttonIndex[3];
			updateTexture(3);
		}
		private function buttonBox4(e:MouseEvent):void{
			
			//_EquipHorse.itemEquip(name1, name2, buttonIndex[4]);
			trace(name1 + " " + name2 + " " + buttonIndex[4]+ " " + itemInformation.length);
			type = buttonIndex[4];
			updateTexture(4);
		}
		
		private function rightButton(e:MouseEvent):void{
			if(currentIndex < itemInformation.length - 5){
				currentIndex++;
			}
			seticonIndex();		
			removeAllIcons(); //mark test
			addAllIcons();
		}
		private function leftButton(e:MouseEvent):void{
			if(currentIndex > 0){
				currentIndex--;
			}
			seticonIndex();		
			removeAllIcons();
			
			addAllIcons();
		}
		
		private function addListeners():void{			
			HorseEquip.closeDown.addEventListener(MouseEvent.CLICK, close);	
			HorseEquip.done.addEventListener(MouseEvent.CLICK, done);	
			
			HorseEquip.scrollLeft.addEventListener(MouseEvent.CLICK, leftButton);
			HorseEquip.scrollRight.addEventListener(MouseEvent.CLICK, rightButton);
			
			equipBox[0].addEventListener(MouseEvent.CLICK, buttonBox0);
			equipBox[1].addEventListener(MouseEvent.CLICK, buttonBox1);
			equipBox[2].addEventListener(MouseEvent.CLICK, buttonBox2);
			equipBox[3].addEventListener(MouseEvent.CLICK, buttonBox3);
			equipBox[4].addEventListener(MouseEvent.CLICK, buttonBox4);
			
			HorseEquip.newi_sub_1_button.addEventListener(MouseEvent.CLICK, horseClickNew);	
			HorseEquip.body_sub_1_button.addEventListener(MouseEvent.CLICK, horseClickBody);	
			HorseEquip.equipment_sub_1_button.addEventListener(MouseEvent.CLICK, horseClickEquip);	
			
			HorseEquip.eyes_sub_2_button.addEventListener(MouseEvent.CLICK, eyeButton);
			HorseEquip.mane_sub_2_button.addEventListener(MouseEvent.CLICK, maneButton);
			HorseEquip.mouth_sub_2_button.addEventListener(MouseEvent.CLICK, mouthButton);
			HorseEquip.skin_sub_2_button.addEventListener(MouseEvent.CLICK, skinButton);
			
			HorseEquip.saddle_sub_2_button.addEventListener(MouseEvent.CLICK, saddleButton);
			HorseEquip.bridle_sub_2_button.addEventListener(MouseEvent.CLICK, bridleButton);
			HorseEquip.wings_sub_2_button.addEventListener(MouseEvent.CLICK, wingsButton);	
			
			buyMC.yes.addEventListener(MouseEvent.CLICK, onBuyYes);	
			buyMC.no.addEventListener(MouseEvent.CLICK, onBuyNo);	
		}		
		
		private function SetEquipBodyUI():void{
			HorseEquip.head_sub_2_button.visible = false;
			HorseEquip.saddle_sub_2_button.visible = false;
			HorseEquip.bridle_sub_2_button.visible = false;
			HorseEquip.wings_sub_2_button.visible = false;
			HorseEquip.accessory_sub_2_button.visible = false;		
			
			HorseEquip.mane_sub_2_button.visible = false;
			HorseEquip.eyes_sub_2_button.visible = false;
			HorseEquip.mouth_sub_2_button.visible = false;
			HorseEquip.skin_sub_2_button.visible = false;
			HorseEquip.pattern_sub_2_button.visible = false;
			HorseEquip.pattern_sub_2_button.visible = false
		}
		
		private function SetEquipUI():void{
			HorseEquip.head_sub_2_button.visible = true;
			HorseEquip.saddle_sub_2_button.visible = true;
			HorseEquip.bridle_sub_2_button.visible = true;
			HorseEquip.wings_sub_2_button.visible = true;
			HorseEquip.accessory_sub_2_button.visible = true;		
			
			HorseEquip.mane_sub_2_button.visible = false;
			HorseEquip.eyes_sub_2_button.visible = false;
			HorseEquip.mouth_sub_2_button.visible = false;
			HorseEquip.skin_sub_2_button.visible = false;
			HorseEquip.pattern_sub_2_button.visible = false;				
		}
		
		private function SetBodyUI():void{
			HorseEquip.head_sub_2_button.visible = false;
			HorseEquip.saddle_sub_2_button.visible = false;
			HorseEquip.bridle_sub_2_button.visible = false;
			HorseEquip.wings_sub_2_button.visible = false;
			HorseEquip.accessory_sub_2_button.visible = false;		
			
			HorseEquip.mane_sub_2_button.visible = true;
			HorseEquip.eyes_sub_2_button.visible = true;
			HorseEquip.mouth_sub_2_button.visible = true;
			HorseEquip.skin_sub_2_button.visible = true;
			HorseEquip.pattern_sub_2_button.visible = true;
		}
		
		private function SetUI():void{
			HorseEquip.newi_sub_1_button.visible = true;
			HorseEquip.body_sub_1_button.visible = true;
			HorseEquip.equipment_sub_1_button.visible = true;
		}
		
		private function SetDefaultUI():void{
			HorseEquip.newi_sub_1_animate.visible = false;
			HorseEquip.body_sub_1_animate.visible = false;
			HorseEquip.equipment_sub_1_animate.visible = false;			
			SetEquipBodyUI();
		}
		
		private function close(e:MouseEvent):void{	
			TweenLite.to(HorseEquip, 0, {x:0, y:50, alpha:1, ease:Expo.easeOut});						
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.HORSE_EQUIP_DONE));
		}
		
		private function done(e:MouseEvent):void{		
			TweenLite.to(HorseEquip, 1, {x:0, y:50, alpha:1, ease:Expo.easeOut});
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.HORSE_EQUIP_DONE));			
		}
		
		private function horseClickNew(e:MouseEvent):void{			
			trace("new");
			SetDefaultUI();
			SetUI();
		
			removeAllIcons();
			HorseEquip.newi_sub_1_button.visible = false;
			HorseEquip.newi_sub_1_animate.visible = true;
		}
		
		private function horseClickBody(e:MouseEvent):void{				
			trace("body");		
			
			SetDefaultUI();
			SetUI();
			SetBodyUI();
			
			removeAllIcons();
			HorseEquip.body_sub_1_button.visible = false;
			HorseEquip.body_sub_1_animate.visible = true;
			
			name1 = "B";
		}
		private function horseClickEquip(e:MouseEvent):void{			
			trace("equip");
			SetDefaultUI();
			SetUI();
			SetEquipUI();
			
			removeAllIcons();
			HorseEquip.equipment_sub_1_button.visible = false;
			HorseEquip.equipment_sub_1_animate.visible = true;
			
			name1 = "E";
		}
		
		private function setAllIconVisible():void{
			for(var x:int = 0; x < 5; x++){
				equipBox[x].itemHolder.iconLimited.visible = true;
			
				equipBox[x].itemHolder.iconCheck.visible = true;
				
				equipBox[x].itemHolder.iconMyStorage.visible = true;
				equipBox[x].itemHolder.iconLock.visible = true;
				equipBox[x].itemHolder.iconNew.visible = true;
				equipBox[x].itemHolder.iconShadow.visible = true;
			}
		}
		
		private function setAllIconHide():void{
			for(var x:int = 0; x < 5; x++){
				equipBox[x].itemHolder.iconLimited.visible = false;
				
				equipBox[x].itemHolder.iconCheck.visible = false;
				
				equipBox[x].itemHolder.iconMyStorage.visible = false;
				equipBox[x].itemHolder.iconLock.visible = false;
				equipBox[x].itemHolder.iconNew.visible = false;
				equipBox[x].itemHolder.iconShadow.visible = false;
			}
		}
		
		private function setD4ItemButton():void
		{			
			for (var x:int = 0;x < 5;x++)
			{				
				equipBox[x] = new D4ItemButton;				
				HorseEquip.addChild(equipBox[x])
				equipBox[x].x = (x * 100) + 65;
				equipBox[x].y = 430;
			}			
		}
		
		private function seticonIndex():void{
			for(x = currentIndex; x< equipBox.length + currentIndex; x++){
				buttonIndex[x - currentIndex] = x;
			}
		}	
		
		private function popAllArray():void{			
			
			for(var a:int = itemInformation.length - 1 ; 0 < itemInformation.length; a--){
				itemInformation.pop();			
			}	
		}		
		
		public function visibility(value:Boolean):void{			
				visible = value;				
				if(value){
					TweenLite.to(HorseEquip, 1, {x:60, y:50, alpha:1, ease:Expo.easeOut});
				}				
		}
		
		private function onBuyYes(e:MouseEvent):void{
			if(buyMC.parent != null){
				HorseEquip.removeChild(buyMC);
			}
		}
		
		private function onBuyNo(e:MouseEvent):void{
			if(buyMC.parent != null){
				HorseEquip.removeChild(buyMC);
			}
		}
		
		public function updateTexture(equipBoxIndex:int):void{						
			HorseController.update();
			
			HorseEquip.addChild(buyMC);				
			buyMC.x = equipBox[equipBoxIndex].x ;
			buyMC.y = equipBox[equipBoxIndex].y - 100;
			
		}
	}
}