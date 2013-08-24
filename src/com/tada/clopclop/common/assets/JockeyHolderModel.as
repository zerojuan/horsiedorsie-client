package com.tada.clopclop.common.assets {
	import com.away3d.containers.Scene3D;
	import com.away3d.containers.View3D;
	import com.away3d.core.clip.RectangleClipping;
	import com.away3d.events.MouseEvent3D;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	import com.tada.clopclop.toolsets.character.jockey.JockeyGR;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	
	import flash.events.Event;
	import flash.geom.Vector3D;

	public class JockeyHolderModel extends View3D implements I3DAsset{
		
		public static const UP:String = "up";
		public static const DOWN:String = "down";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		
		private var _jockey:JockeyAsset;
		
		private var _jockeyGR:JockeyGR = JockeyGR.getInstance();
		
		public function JockeyHolderModel(item:String = null, scene:Scene3D = null) {
			if (scene) {
				this.scene = scene;
			}
			
			clipping = new RectangleClipping({minX:-300, minY:-300, maxX:300, maxY:300});
			
			_jockey = new JockeyAsset(this);
			_jockey.mesh.scale(.030);
			_jockey.mesh.rotationY = 135;
			_jockey.mesh.ownCanvas = true;
			
			camera.position = new Vector3D(0, 0, 0);
			camera.moveBackward(500);
			camera.moveUp(500);
			camera.lookAt(new Vector3D(0, 0, 0));
			
			_jockeyGR.addOnAnimXMLLoaded(onXMLLoaded);
		}
		
		private function onXMLLoaded(evt:JockeyEvent):void{
			walk(DOWN);
		}
		
		public function walk(direction:String):void {
			switch (direction) {
				case UP:
					_jockey.changeAnimationByType(JockeyGR.ANIM_WALK);
					_jockey.mesh.rotationY = 135;
					break;
				case DOWN:
					_jockey.changeAnimationByType(JockeyGR.ANIM_FEED);
					_jockey.mesh.rotationY = 315;
					break;
				case LEFT:
					_jockey.changeAnimationByType(JockeyGR.ANIM_WALK);
					_jockey.mesh.rotationY = 45;
					break;
				case RIGHT:
					_jockey.changeAnimationByType(JockeyGR.ANIM_WALK);
					_jockey.mesh.rotationY = 225;
					break;
			}
		}
		
		public function update(e:Event = null):void {
			render();
		}
		
		
		private function onClick(e:MouseEvent3D):void{
			dispatchEvent(e);
		}
		
		private function onOver(e:MouseEvent3D):void{
			
		}
		
		private function onOut(e:MouseEvent3D):void{
			
		}
		
	}
}