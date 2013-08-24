package com.tada.clopclop.jockeyequip
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.events.NavigationEvent;
	import com.tada.clopclop.horseequip.itemInfo;
	import com.tada.engine.TEngine;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class JockeyView extends Sprite
	{
		//array that holds the movie clip D4ItemButton
		private var equipBox:Array = [];
		private var itemInformation:Array = [];
		
		private var JockeyEquip:JockeyEquipUI;
		
		private var view:View3D;
		
		public var name1:String = "";
		public var name2:String = "";		
		public var type:int = 0;
		
		private var currentIndex:int = 0;		
		private var buttonIndex:Array = [];
		
		private var JockeyController:JockeyEquipController;	
		
		private var buyMC:BuyEquip;
		private var sellMC:SellEquip;
		
		public function JockeyView(view3d:View3D,jockeyEquipController:JockeyEquipController)
		{
			JockeyController = jockeyEquipController;	
			
			view = view3d;	
			
			instantiation();			
			setD4ItemButton();
			setAllIconHide();
			SetDefaultUI();		
		
			//setAllIconVisible();					
			seticonIndex();								
			addListeners();		
		}
		
		private function eyeButton(e:MouseEvent):void{				
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JBEye01, "eye2"));
			itemInformation.push(new itemInfo(new JBEye02, "eye2"));
			itemInformation.push(new itemInfo(new JBEye03, "eye3"));
			itemInformation.push(new itemInfo(new JBEye04, "eye4"));
			itemInformation.push(new itemInfo(new JBEye05, "eye5"));
			itemInformation.push(new itemInfo(new JBEye06, "eye6"));
			itemInformation.push(new itemInfo(new JBEye07, "eye7"));
			itemInformation.push(new itemInfo(new JBEye08, "eye8"));
			itemInformation.push(new itemInfo(new JBEye09, "eye9"));
			itemInformation.push(new itemInfo(new JBEye10, "eye10"));
			itemInformation.push(new itemInfo(new JBEye11, "eye11"));
			itemInformation.push(new itemInfo(new JBEye12, "eye12"));
			itemInformation.push(new itemInfo(new JBEye13, "eye13"));	
			
			addAllIcons();
			name2 = "Eye";
		}
		
		private function skinButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JBSkin01, "eye1"));
			itemInformation.push(new itemInfo(new JBSkin02, "eye2"));
			itemInformation.push(new itemInfo(new JBSkin03, "eye3"));		
			
			addAllIcons();
			name2 = "Skin";
		}
		
		private function hairButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JBHair01, "eye1"));
			itemInformation.push(new itemInfo(new JBHair02, "eye2"));
			itemInformation.push(new itemInfo(new JBHair03, "eye3"));	
			
			addAllIcons();
			name2 = "Hair";
		}
		
		private function eyebrowsButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JBEyeBrow01, "eye2"));
			itemInformation.push(new itemInfo(new JBEyeBrow02, "eye2"));
			itemInformation.push(new itemInfo(new JBEyeBrow03, "eye3"));
			itemInformation.push(new itemInfo(new JBEyeBrow04, "eye4"));
			itemInformation.push(new itemInfo(new JBEyeBrow05, "eye5"));
			itemInformation.push(new itemInfo(new JBEyeBrow06, "eye6"));
			itemInformation.push(new itemInfo(new JBEyeBrow07, "eye7"));
			itemInformation.push(new itemInfo(new JBEyeBrow08, "eye8"));
			itemInformation.push(new itemInfo(new JBEyeBrow09, "eye9"));
			itemInformation.push(new itemInfo(new JBEyeBrow10, "eye10"));
			itemInformation.push(new itemInfo(new JBEyeBrow11, "eye11"));
			
			addAllIcons();
			name2 = "EyeBrow";
		}
		
		private function mouthButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JBMouth01, "eye1"));
			itemInformation.push(new itemInfo(new JBMouth02, "eye2"));
			itemInformation.push(new itemInfo(new JBMouth03, "eye3"));
			itemInformation.push(new itemInfo(new JBMouth04, "eye4"));
			itemInformation.push(new itemInfo(new JBMouth05, "eye5"));
			itemInformation.push(new itemInfo(new JBMouth06, "eye6"));	
			
			itemInformation.push(new itemInfo(new JBMouth07, "eye1"));
			itemInformation.push(new itemInfo(new JBMouth08, "eye2"));
			itemInformation.push(new itemInfo(new JBMouth09, "eye3"));
			itemInformation.push(new itemInfo(new JBMouth10, "eye4"));
			itemInformation.push(new itemInfo(new JBMouth11, "eye5"));
			itemInformation.push(new itemInfo(new JBMouth12, "eye6"));	
			
			itemInformation.push(new itemInfo(new JBMouth13, "eye5"));
			itemInformation.push(new itemInfo(new JBMouth14, "eye6"));	
			
			addAllIcons();
			name2 = "Mouth";
		}
		
		private function accButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JEAcc01, ""));	
			itemInformation.push(new itemInfo(new JEAcc02, ""));	
			itemInformation.push(new itemInfo(new JEAcc03, ""));	
			itemInformation.push(new itemInfo(new JEAcc04, ""));	
			
			addAllIcons();
		}
				
		private function headButton(e:MouseEvent):void{		
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JEHat01, ""));
			itemInformation.push(new itemInfo(new JEHat02, ""));
			itemInformation.push(new itemInfo(new JEHat03, ""));
			itemInformation.push(new itemInfo(new JEHat04, ""));
			itemInformation.push(new itemInfo(new JEHat05, ""));
			itemInformation.push(new itemInfo(new JEHat06, ""));
			itemInformation.push(new itemInfo(new JEHat07, ""));
			itemInformation.push(new itemInfo(new JEHat08, ""));
			itemInformation.push(new itemInfo(new JEHat09, ""));
			itemInformation.push(new itemInfo(new JEHat10, ""));
			itemInformation.push(new itemInfo(new JEHat11, ""));
			itemInformation.push(new itemInfo(new JEHat12, ""));
			itemInformation.push(new itemInfo(new JEHat13, ""));
			itemInformation.push(new itemInfo(new JEHat14, ""));
			itemInformation.push(new itemInfo(new JEHat15, ""));
			itemInformation.push(new itemInfo(new JEHat16, ""));
			itemInformation.push(new itemInfo(new JEHat17, ""));
			itemInformation.push(new itemInfo(new JEHat18, ""));
			itemInformation.push(new itemInfo(new JEHat19, ""));
			itemInformation.push(new itemInfo(new JEHat20, ""));
			
			addAllIcons();
			name2 = "Hat";
		}
		
		private function shoesButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();			
			popAllArray();
			
			itemInformation.push(new itemInfo(new JEShoes01, ""));
			itemInformation.push(new itemInfo(new JEShoes02, ""));
			itemInformation.push(new itemInfo(new JEShoes03, ""));
			
			addAllIcons();
			name2 = "Shoes";
		}
		
		private function topButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JETop01, ""));
			itemInformation.push(new itemInfo(new JETop02, ""));
			itemInformation.push(new itemInfo(new JETop03, ""));
			itemInformation.push(new itemInfo(new JETop04, ""));
			itemInformation.push(new itemInfo(new JETop05, ""));
			itemInformation.push(new itemInfo(new JETop06, ""));
			itemInformation.push(new itemInfo(new JETop07, ""));
			itemInformation.push(new itemInfo(new JETop08, ""));
			itemInformation.push(new itemInfo(new JETop09, ""));
			itemInformation.push(new itemInfo(new JETop10, ""));
			itemInformation.push(new itemInfo(new JETop11, ""));
			itemInformation.push(new itemInfo(new JETop12, ""));
			itemInformation.push(new itemInfo(new JETop13, ""));
			itemInformation.push(new itemInfo(new JETop14, ""));
			itemInformation.push(new itemInfo(new JETop15, ""));
			itemInformation.push(new itemInfo(new JETop16, ""));
			itemInformation.push(new itemInfo(new JETop17, ""));
			itemInformation.push(new itemInfo(new JETop18, ""));
			itemInformation.push(new itemInfo(new JETop19, ""));			
			
			addAllIcons();
			name2 = "Top";
		}
		
		private function bottomButton(e:MouseEvent):void{
			currentIndex = 0;
			seticonIndex();
			
			removeAllIcons();
			popAllArray();
			
			itemInformation.push(new itemInfo(new JEBottom01, ""));
			itemInformation.push(new itemInfo(new JEBottom02, ""));
			itemInformation.push(new itemInfo(new JEBottom03, ""));
			itemInformation.push(new itemInfo(new JEBottom04, ""));
			itemInformation.push(new itemInfo(new JEBottom05, ""));
			itemInformation.push(new itemInfo(new JEBottom06, ""));
			itemInformation.push(new itemInfo(new JEBottom07, ""));
			itemInformation.push(new itemInfo(new JEBottom08, ""));
			itemInformation.push(new itemInfo(new JEBottom09, ""));
			itemInformation.push(new itemInfo(new JEBottom10, ""));
			itemInformation.push(new itemInfo(new JEBottom11, ""));
			itemInformation.push(new itemInfo(new JEBottom12, ""));
			itemInformation.push(new itemInfo(new JEBottom13, ""));
			itemInformation.push(new itemInfo(new JEBottom14, ""));
			itemInformation.push(new itemInfo(new JEBottom15, ""));
			itemInformation.push(new itemInfo(new JEBottom16, ""));
			itemInformation.push(new itemInfo(new JEBottom17, ""));
			
			
			
			addAllIcons();
			name2 = "Bottom";
		}
		
		private function jockeyClickNew(e:MouseEvent):void{
			trace("new");
			SetDefaultUI();
			SetUI();
			
			removeAllIcons();			
			JockeyEquip.jockeyEquipmentMove.newi_sub_1_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.newi_sub_1_animate.visible = true;
			
		}
		
		private function jockeyClickBody(e:MouseEvent):void{
			trace("body");	
			SetDefaultUI();
			SetUI();
			SetBodyUI();
			
			removeAllIcons();
			
			JockeyEquip.jockeyEquipmentMove.body_sub_1_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.body_sub_1_animate.visible = true;
			
			name1 = "B";
		}
		
		private function jockeyClickEquip(e:MouseEvent):void{
			trace("equip");
			SetDefaultUI();
			SetUI();
			SetEquipUI();
			
			removeAllIcons();
			
			JockeyEquip.jockeyEquipmentMove.equipment_sub_1_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.equipment_sub_1_animate.visible = true;
			
			name1 = "E";
		}
		
		private function addListeners():void{				
				
			JockeyEquip.jockeyEquipmentMove	.scrollLeft.addEventListener(MouseEvent.CLICK, leftButton);
			JockeyEquip.jockeyEquipmentMove	.scrollRight.addEventListener(MouseEvent.CLICK, rightButton);
			
			JockeyEquip.jockeyEquipmentMove.close.addEventListener(MouseEvent.CLICK, close);	
			JockeyEquip.jockeyEquipmentMove.done.addEventListener(MouseEvent.CLICK, done);
			
			equipBox[0].addEventListener(MouseEvent.CLICK, buttonBox0);
			equipBox[1].addEventListener(MouseEvent.CLICK, buttonBox1);
			equipBox[2].addEventListener(MouseEvent.CLICK, buttonBox2);
			equipBox[3].addEventListener(MouseEvent.CLICK, buttonBox3);
			equipBox[4].addEventListener(MouseEvent.CLICK, buttonBox4);
			
			JockeyEquip.jockeyEquipmentMove.skincolor_sub_2_button.addEventListener(MouseEvent.CLICK, skinButton);
			JockeyEquip.jockeyEquipmentMove.mouth_sub_2_button.addEventListener(MouseEvent.CLICK, mouthButton);
			JockeyEquip.jockeyEquipmentMove.eyes_sub_2_button.addEventListener(MouseEvent.CLICK, eyeButton);
			JockeyEquip.jockeyEquipmentMove.eyebrows_sub_2_button.addEventListener(MouseEvent.CLICK, eyebrowsButton);
			JockeyEquip.jockeyEquipmentMove.hair_sub_2_button.addEventListener(MouseEvent.CLICK, hairButton);
			
			JockeyEquip.jockeyEquipmentMove.accessory_sub_2_button.addEventListener(MouseEvent.CLICK, accButton);
			JockeyEquip.jockeyEquipmentMove.shoes_sub_2_button.addEventListener(MouseEvent.CLICK, shoesButton);
			JockeyEquip.jockeyEquipmentMove.head_sub_2_button.addEventListener(MouseEvent.CLICK, headButton);
			JockeyEquip.jockeyEquipmentMove.bottom_sub_2_button.addEventListener(MouseEvent.CLICK, bottomButton);
			JockeyEquip.jockeyEquipmentMove.top_sub_2_button.addEventListener(MouseEvent.CLICK, topButton);
			
			JockeyEquip.jockeyEquipmentMove.newi_sub_1_button.addEventListener(MouseEvent.CLICK, jockeyClickNew);
			JockeyEquip.jockeyEquipmentMove.body_sub_1_button.addEventListener(MouseEvent.CLICK, jockeyClickBody);
			JockeyEquip.jockeyEquipmentMove.equipment_sub_1_button.addEventListener(MouseEvent.CLICK, jockeyClickEquip);
			
			buyMC.yes.addEventListener(MouseEvent.CLICK, onBuyYes);	
			buyMC.no.addEventListener(MouseEvent.CLICK, onBuyNo);
		}
		
		private function instantiation():void{
			JockeyEquip = new JockeyEquipUI;
			addChild(JockeyEquip);
			
			buyMC = new BuyEquip;	
		}	
		
		private function close(e:MouseEvent):void{	
			//TweenLite.to(HorseEquip, 0, {x:0, y:50, alpha:1, ease:Expo.easeOut});
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.JOCKEY_EQUIP_DONE));			
		}
		
		private function done(e:MouseEvent):void{		
			//TweenLite.to(HorseEquip, 1, {x:0, y:50, alpha:1, ease:Expo.easeOut});
			TEngine.mainClass.dispatchEvent(new NavigationEvent(NavigationEvent.JOCKEY_EQUIP_DONE));			
		}
		
		private function SetDefaultUI():void{
			JockeyEquip.jockeyEquipmentMove.newi_sub_1_animate.visible = false;
			JockeyEquip.jockeyEquipmentMove.body_sub_1_animate.visible = false;
			JockeyEquip.jockeyEquipmentMove.equipment_sub_1_animate.visible = false;			
			SetEquipBodyUI();
		}
		
		private function SetUI():void{
			JockeyEquip.jockeyEquipmentMove.newi_sub_1_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.body_sub_1_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.equipment_sub_1_button.visible = true;
		}
		
		private function SetEquipBodyUI():void{
			JockeyEquip.jockeyEquipmentMove.accessory_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.shoes_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.head_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.bottom_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.top_sub_2_button.visible = false;
			
			JockeyEquip.jockeyEquipmentMove.skincolor_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.mouth_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.eyes_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.eyebrows_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.hair_sub_2_button.visible = false;
		}
		
		private function SetEquipUI():void{
			JockeyEquip.jockeyEquipmentMove.accessory_sub_2_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.shoes_sub_2_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.head_sub_2_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.bottom_sub_2_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.top_sub_2_button.visible = true;
			
			JockeyEquip.jockeyEquipmentMove.skincolor_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.mouth_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.eyes_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.eyebrows_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.hair_sub_2_button.visible = false;
		}
		
		private function SetBodyUI():void{
			JockeyEquip.jockeyEquipmentMove.accessory_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.shoes_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.head_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.bottom_sub_2_button.visible = false;
			JockeyEquip.jockeyEquipmentMove.top_sub_2_button.visible = false;
			
			JockeyEquip.jockeyEquipmentMove.skincolor_sub_2_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.mouth_sub_2_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.eyes_sub_2_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.eyebrows_sub_2_button.visible = true;
			JockeyEquip.jockeyEquipmentMove.hair_sub_2_button.visible = true;
			
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
				JockeyEquip.jockeyEquipmentMove.addChild(equipBox[x])
				equipBox[x].x = (x * 100) + 65;
				equipBox[x].y = 430;
			}			
		}
		
		private function popAllArray():void{			
			
			for(var a:int = itemInformation.length - 1 ; 0 < itemInformation.length; a--){
				itemInformation.pop();			
			}	
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
		
		private function seticonIndex():void{
			for(x = currentIndex; x< equipBox.length + currentIndex; x++){
				buttonIndex[x - currentIndex] = x;
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
		
		public function visibility(value:Boolean):void{			
			visible = value;				
			if(value){
				//TweenLite.to(JockeyEquip, 1, {x:60, y:50, alpha:1, ease:Expo.easeOut});
			}				
		}
		
		private function onBuyYes(e:MouseEvent):void{
			if(buyMC.parent != null){
				JockeyEquip.jockeyEquipmentMove.removeChild(buyMC);
			}
		}
		
		private function onBuyNo(e:MouseEvent):void{
			if(buyMC.parent != null){
				JockeyEquip.jockeyEquipmentMove.removeChild(buyMC);
			}
		}
		
		public function updateTexture(equipBoxIndex:int):void{						
			JockeyController.update();
			//dispatchEvent(new HorseEquipEvent(callBack, params));
			
			JockeyEquip.jockeyEquipmentMove.addChild(buyMC);			
			
			buyMC.x = equipBox[equipBoxIndex].x ;
			buyMC.y = equipBox[equipBoxIndex].y - 100;
			trace(buyMC.x);
		}
		
	}
}