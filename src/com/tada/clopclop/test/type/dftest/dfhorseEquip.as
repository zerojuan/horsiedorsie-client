package com.tada.clopclop.test.type.dftest
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.toolsets.character.horse.HorseAnimation;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	
	import flash.display.Sprite;
	
	public class dfhorseEquip extends Sprite
	{
		private var horse:HorseAsset;				
		private var view:View3D;		
		
		public function dfhorseEquip(_view3d:View3D)
		{			
			view = _view3d;		
			view.x = 250;
			view.y = 255;			
			
			initialization();					
		}
		
		private function initialization():void{
			horse = new HorseAsset(view);	
			horse.changeAnimationByType(HorseAnimation.ANIM_IDLE02);
		}
		
		public function HorseEquip(BE:String, part:String, type:int):void{
			
			if(BE== "E"){
				switch(part){				
					case "Acc" :
						SelectAccType(type);	
						break;	
					case "Wing" :
						SelectAccType(type);	
						break;
					case "Head" :
						SelectAccType(type);	
						break;
					case "Briddle" :
						SelectAccType(type);	
						break;
					case "Saddle" :
						SelectAccType(type);	
						break;
				}	
			}
			
			if(BE== "B"){
				switch(part){				
					case "Eye" :
						SelectEyeType(type);	
						break;						
					case "Mouth" :
						SelectMouthType(type);	
						break;	
					case "Mouth" :
						SelectMouthType(type);	
						break;	
					case "Body" :
						SelectMouthType(type);	
						break;	
				}	
			}
		}
		
		
		
		private function SelectMouthType(type:int):void{
			switch(type){
				case 0:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 1:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 2:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 3:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 4:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 5:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 6:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 7:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 8:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 9:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 10:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 11:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 12:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
				
				case 13:
					horse.changeTextureByPart(HorseAsset.MOUTH_SET, type);	
					break;
			}
		}
				
		private function SelectEyeType(type:int):void{
			switch(type){
				case 0:						
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);					
					break;
				
				case 1:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 2:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 3:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 4:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 5:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 6:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 7:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 8:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 9:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 10:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 11:					
					horse.changeTextureByPart(HorseAsset.EYE_SET, type);						
					break;
				
				case 12:					
					horse.changeTextureByPart(HorseAsset.EYE_SET  , type);						
					break;
			}
		}
		
		private function SelectAccType(type:int):void{
			
			switch(type){
				case 0:
					if(horse.equipmentExists(HorseAsset.ACC_SET) == false){
						horse.addEquipment(HorseAsset.ACC_SET);
					}
					else{
						if(horse.equipmentVisibility(HorseAsset.ACC_SET) == true){
							horse.setSpecificEquipmentVisibility(HorseAsset.ACC_SET, false);	
						}
						else{
							horse.setSpecificEquipmentVisibility(HorseAsset.ACC_SET, true);
						}
					}					
					break;
			}			
		}		
	
		private function update():void{
			//if (_move && _isMouseMovable){			
			//	panAngle = _lastPanAngle + (_stage.mouseX - _lastX) * _mouseSpeed;
			//}
		}
	}
}