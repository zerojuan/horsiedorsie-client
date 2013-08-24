package com.tada.clopclop.common.assets {
	import com.away3d.containers.Scene3D;
	import com.away3d.containers.View3D;
	import com.away3d.core.clip.RectangleClipping;
	import com.away3d.events.MouseEvent3D;
	import com.greensock.TweenMax;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.tada.clopclop.toolsets.character.horse.HorseAnimation;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.toolsets.character.horse.HorseGR;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAnimation;
	import com.tada.clopclop.toolsets.character.jockey.JockeyGR;
	
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;
	
	public class HorseHolderModel extends View3D implements I3DAsset{
		TweenPlugin.activate([GlowFilterPlugin]);
		
		public static const UP:String = "up";
		public static const DOWN:String = "down";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		
		private var _horse:HorseAsset;
		
		private var _horseGR:HorseGR = HorseGR.getInstance();
		
		public function HorseHolderModel(item:String = null, scene:Scene3D = null) {
			if (scene) {
				this.scene = scene;
			}
			
			clipping = new RectangleClipping({minX:-150, minY:-150, maxX:150, maxY:150});
			
			camera.position = new Vector3D(0, 0, 0);
			camera.moveBackward(500);
			camera.moveUp(500);
			camera.lookAt(new Vector3D(0, 0, 0));					
				
			start();					
		}
		
		public function start():void{
			_horse = new HorseAsset(this);
			_horse.mesh.scale(.025);
			_horse.mesh.rotationY = 135;
			_horse.mesh.addEventListener(MouseEvent3D.MOUSE_UP, onClick);
			_horse.mesh.addEventListener(MouseEvent3D.MOUSE_OVER, onOver);
			_horse.mesh.ownCanvas = true;
			_horseGR.addOnAnimXMLLoaded(onXMLLoaded);
		}
		
		public function walk(direction:String):void {
			
			switch (direction) {
				case UP:
					_horse.changeAnimationByType(HorseGR.ANIM_WALK);
					_horse.mesh.rotationY = 135;
					break;
				case DOWN:
					_horse.changeAnimationByType(HorseGR.ANIM_WALK);
					_horse.mesh.rotationY = 315;
					break;
				case LEFT:
					_horse.changeAnimationByType(HorseGR.ANIM_WALK);
					_horse.mesh.rotationY = 45;
					break;
				case RIGHT:
					_horse.changeAnimationByType(HorseGR.ANIM_WALK);
					_horse.mesh.rotationY = 225;
					break;
			}
		}
		
		private function onXMLLoaded(evt:HorseEvent):void{
			_horseGR.removeOnXMLLoaded(onXMLLoaded);
			walk(HorseHolderModel.DOWN);
		}
		
		public function update(e:Event = null):void {
			render();
		}
		
		private function onClick(e:MouseEvent3D):void {
			dispatchEvent(e);
		}
		
		private function onOver(e:MouseEvent3D):void {
			trace("over");
			_horse.mesh.removeEventListener(MouseEvent3D.MOUSE_OVER, onOver);
			_horse.mesh.addEventListener(MouseEvent3D.MOUSE_OUT, onOut);
			TweenMax.to(_horse.mesh, .5, {
				glowFilter: {color:0x00FF00, alpha:1, blurX:8, blurY:8, strength: 10}
			});
			_horse.changeAnimationByType(HorseGR.ANIM_WALK);
		}
		
		private function onOut(e:MouseEvent3D):void {
			trace("out");
			_horse.mesh.removeEventListener(MouseEvent3D.MOUSE_OUT, onOut);
			_horse.mesh.addEventListener(MouseEvent3D.MOUSE_OVER, onOver);
			TweenMax.to(_horse.mesh, .5, {
				glowFilter: {alpha:0, blurX:0, blurY:0, strength:0, remove:true}
			});
		}
		
		public function initHolder():void {} public function teleport(x:int, y:int):void {}
	}
}