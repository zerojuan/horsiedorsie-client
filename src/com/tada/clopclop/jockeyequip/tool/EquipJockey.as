package com.tada.clopclop.jockeyequip.tool
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.jockeyequip.JockeyComponent.tab.JockeyTabbedPanel;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	import com.tada.clopclop.toolsets.character.jockey.JockeyGR;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	
	import flash.display.Sprite;

	public class EquipJockey extends Sprite
	{
		private var _jockeyGR:JockeyGR = JockeyGR.getInstance();		
		private var jockey:JockeyAsset;				
		private var view:View3D;	
				
		public function EquipJockey(_view3d:View3D)
		{			
			view = _view3d;		
			view.x = 250;
			view.y = 255;			
			
			initialization();		
			
			jockey.mesh.scale(2);
		}
		
		private function initialization():void{
			jockey = new JockeyAsset(view);			
			
			//jockey.changeAnimationByType(JockeyAnimation.ANIM_IDLE01);	
			_jockeyGR.addOnAnimXMLLoaded(onAssetAnimLoaded);		
		}
		
		private function onAssetAnimLoaded(evt:JockeyEvent):void{
			_jockeyGR.removeOnAnimXMLLoaded(onAssetAnimLoaded);	
			jockey.changeMeshBySet(JockeyGR.HEAD_SET);
		}
		
		public function itemEquip(part:String, type:int, mesh:int):void{
			
			//Hold BE, not in use as of now
			trace("part:" + part + " type:" + type + " mesh:" +  mesh);	
			selectType(part, type, mesh);
		}
		
		private function selectType(part:String, type:int, mesh:int):void{
			//body
			if(part == JockeyTabbedPanel._HAIR  ){
				jockey.changeTextureByPart(JockeyGR.HAIR_SET, type);
				jockey.changeMeshByType(JockeyGR.HAIR_SET, mesh);
			}	
			if(part == JockeyTabbedPanel._EYEBROW  ){
				jockey.changeTextureByPart(JockeyGR.EYEBROW_SET, type);	
			}	
			if(part == JockeyTabbedPanel._EYES  ){
				jockey.changeTextureByPart(JockeyGR.EYE_SET, type);	
			}	
			if(part == JockeyTabbedPanel._MOUTH  ){
				jockey.changeTextureByPart(JockeyGR.MOUTH_SET, type);
			}	
			if(part == JockeyTabbedPanel._SKIN  ){
				jockey.changeTextureByPart(JockeyGR.SKIN_SET, type);
			}	
			
			//equipment
			if(part == JockeyTabbedPanel._TOP  ){
				jockey.changeTextureByPart(JockeyGR.TOP_SET, type);
			}	
			if(part == JockeyTabbedPanel._BOTTOM  ){
				jockey.changeTextureByPart(JockeyGR.BOTTOM_SET, type);		
			}	
			if(part == JockeyTabbedPanel._HAT  ){
				//change mesh
				jockey.addEquipment(JockeyGR.HEAD_SET);
				jockey.changeMeshByType(JockeyGR.HEAD_SET, mesh);
				jockey.changeTextureByPart(JockeyGR.HEAD_SET, type);	
			}	
			if(part == JockeyTabbedPanel._SHOES  ){
				jockey.changeTextureByPart(JockeyGR.SHOES_SET, type);		
			}	
			if(part == JockeyTabbedPanel._ACC  ){
				jockey.addEquipment(JockeyGR.ACC_SET);
				jockey.changeMeshByType(JockeyGR.ACC_SET, mesh);
				jockey.changeTextureByPart(JockeyGR.ACC_SET, type);				
			}	
		}		
	}
}