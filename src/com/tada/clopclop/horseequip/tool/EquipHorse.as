package com.tada.clopclop.horseequip.tool
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.horseequip.HorseComponent.tab.HorseTabbedPanel;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.toolsets.character.horse.HorseGR;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class EquipHorse extends Sprite
	{
		private var _horseGR:HorseGR = HorseGR.getInstance();		
		private var horse:HorseAsset;				
		private var view:View3D;	
					
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function EquipHorse(_view3d:View3D)
		{			
			view = _view3d;		
			view.x = 245;
			view.y = 300;
			
			initialization();	
			horse.mesh.scale(2);
			
		}
		
		private function initialization():void{
			horse = new HorseAsset(view);
			_horseGR.addOnAnimXMLLoaded(onAssetAnimLoaded);
			
		}
		
		private function onHorseJump (evt:Event):void{
			
			if (horse.animation.currFrame == 26){
				_horseGR.addOnAnimXMLLoaded(onAssetAnimLoaded);
				removeEventListener(Event.ENTER_FRAME,onHorseJump);
			}
		}
		
		private function onAssetAnimLoaded(evt:HorseEvent):void{
			_horseGR.removeOnAnimXMLLoaded(onAssetAnimLoaded);		
			horse.changeAnimationByType(HorseGR.ANIM_IDLE02);
		}
		
		private function onAssetAnimLoaded2(evt:HorseEvent):void{
			_horseGR.removeOnAnimXMLLoaded(onAssetAnimLoaded);		
			horse.changeAnimationByType(HorseGR.ANIM_PLEASANT);
		}
		
		public function itemEquip(part:String, type:int, mesh:int):void{	
			
			//Hold BE, not in use as of now			
			trace("part:" + part + " type:" + type + " mesh:" +  mesh);		
			selectType(part, type, mesh);
		}		
		
		private function selectType(part:String, type:int, mesh:int ):void{
			
			if(part == HorseTabbedPanel._MANE  ){
				horse.changeTextureByPart(HorseGR.HAIR_SET, type);
			}			
			if(part == HorseTabbedPanel._EYES  ){
				horse.changeTextureByPart(HorseGR.EYE_SET, type);
			}
			if(part == HorseTabbedPanel._MOUTH  ){
				horse.changeTextureByPart(HorseGR.MOUTH_SET, type);
			}
			if(part == HorseTabbedPanel._PATTERN  ){
				//horse.changeTextureByPart(HorseGR.BODY_SET, type + 3);	
				horse.changeDecalsByType(HorseGR.BODY_SET, type);
			}
			if(part == HorseTabbedPanel._SKIN  ){
				horse.changeTextureByPart(HorseGR.BODY_SET, type);	
			}
			//head
			if(part == HorseTabbedPanel._HEAD  ){
				horse.addEquipment(HorseGR.HEAD_SET);
				horse.changeMeshByType(HorseGR.HEAD_SET, mesh);
				horse.changeTextureByPart(HorseGR.HEAD_SET, type);
			}
			//saddle
			if(part == HorseTabbedPanel._SADDLE  ){
				horse.changeTextureByPart(HorseGR.SADDLE_SET, type);	
			}
			//bridle
			if(part == HorseTabbedPanel._BRIDLE  ){
				horse.changeTextureByPart(HorseGR.BRIDLE_SET, type);
			}
			//acc
			if(part == HorseTabbedPanel._ACC  ){
				horse.addEquipment(HorseGR.ACC_SET);
				horse.changeMeshByType(HorseGR.ACC_SET, mesh);
				horse.changeTextureByPart(HorseGR.ACC_SET, type);						
			}
			//wing
			if(part == HorseTabbedPanel._WING){
				horse.addEquipment(HorseGR.WING_SET);
				horse.changeMeshByType(HorseGR.WING_SET, mesh);
				horse.changeTextureByPart(HorseGR.WING_SET, type);
			}	
		}			
	}
}