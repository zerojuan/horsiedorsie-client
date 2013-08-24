package com.tada.clopclop.test.type.dftest
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAnimation;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeyTopSet;
	
	import flash.display.Sprite;

	public class EquipJockey extends Sprite
	{
		private var jockey:JockeyAsset;				
		private var view:View3D;		
		
		public function EquipJockey(_view3d:View3D)
		{			
			view = _view3d;		
			view.x = 250;
			view.y = 255;			
			
			initialization();					
		}
		
		private function initialization():void{
			jockey = new JockeyAsset(view);		
			//jockey.changeAnimationByType(JockeyAnimation.ANIM_IDLE01);
		}
		
		public function JockeyEquip(BE:String, part:String, type:int):void{
			
			if(BE== "E"){
				switch(part){				
					case "Acc" :
						SelectAccType(type);	
					break;
					
					case "Top":
						SelectTopType(type);	
					break;
					
					case "Bottom":
						SelectBottomType(type);	
						break;
				}	
			}
			
			if(BE== "B"){
				switch(part){				
					case "Eye" :
						SelectEyeType(type);	
						break;	
					
					case "Skin" :
						SelectSkinType(type);	
						break;	
					case "EyeBrow" :
						SelectEyeBrowType(type);	
						break;	
					case "Mouth" :
						SelectMouthType(type);	
						break;	
				}	
			}
		}
		
		private function SelectEyeBrowType(type:int):void{		
			
			switch(type){
				case 0:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 1:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 2:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 3:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 4:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 5:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 6:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 7:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 8:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 9:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;
				
				case 10:
					jockey.changeTextureByPart(JockeyAsset.EYEBROW_SET, type);
					break;				
			}
		}
		
		private function SelectMouthType(type:int):void{
			switch(type){
				case 0:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 1:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 2:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 3:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 4:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 5:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 6:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 7:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 8:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 9:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 10:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 11:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 12:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
				
				case 13:
					jockey.changeTextureByPart(JockeyAsset.MOUTH_SET, type);	
					break;
			}
		}
		
		private function SelectSkinType(type:int):void{
			switch(type){
				case 0:
					jockey.changeTextureByPart(JockeyAsset.SKIN_SET, type);
					break;
				
				case 1:
					jockey.changeTextureByPart(JockeyAsset.SKIN_SET, type);
					break;
				
				case 2:
					jockey.changeTextureByPart(JockeyAsset.SKIN_SET, type);
					break;
				
				trace("Skin");
			}
		}
		
		private function SelectEyeType(type:int):void{
			switch(type){
				case 0:						
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);					
					break;
				
				case 1:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 2:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 3:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 4:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 5:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 6:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 7:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 8:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 9:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 10:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 11:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET, type);						
					break;
				
				case 12:					
					jockey.changeTextureByPart(JockeyAsset.EYE_SET  , type);						
					break;
			}
		}
		
		private function SelectAccType(type:int):void{
			
			switch(type){
				case 0:
					if(jockey.equipmentExists(JockeyAsset.ACC_SET) == false){
						jockey.addEquipment(JockeyAsset.ACC_SET);
					}
					else{
						if(jockey.equipmentVisibility(JockeyAsset.ACC_SET) == true){
							jockey.setSpecificEquipmentVisibility(JockeyAsset.ACC_SET, false);	
						}
						else{
							jockey.setSpecificEquipmentVisibility(JockeyAsset.ACC_SET, true);
						}
					}					
				break;
			}			
		}
		
		private function SelectBottomType(type:int):void{
			switch(type){
				case 0:						
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);					
					break;
				
				case 1:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 2:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 3:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 4:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 5:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 6:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 7:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 8:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 9:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 10:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 11:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 12:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 13:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 14:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 15:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
				
				case 16:					
					jockey.changeTextureByPart(JockeyAsset.BOTTOM_SET, type);						
					break;
			}
		}
		
		private function SelectShoesType(type:int):void{
			switch(type){
				case 0:
					jockey.changeTextureByPart(JockeyAsset.SHOES_SET, type);	
					break;
				
				case 1:
					jockey.changeTextureByPart(JockeyAsset.SHOES_SET, type);	
					break;
				
				case 0:
					jockey.changeTextureByPart(JockeyAsset.SHOES_SET, type);	
					break;
			}
		}
		
		private function SelectTopType(type:int):void{
			switch(type){
				case 0:						
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);					
				break;
				
				case 1:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
				break;
				
				case 2:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 3:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 4:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 5:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 6:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 7:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 8:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 9:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 10:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 11:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 12:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 13:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
					break;
				
				case 14:					
					jockey.changeTextureByPart(JockeyAsset.TOP_SET, type);						
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