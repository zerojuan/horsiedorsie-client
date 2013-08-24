package com.tada.clopclop.racing
{
	import com.away3d.cameras.HoverCamera3D;
	import com.away3d.containers.ObjectContainer3D;
	import com.away3d.containers.View3D;
	import com.away3d.core.base.Object3D;
	import com.away3d.core.clip.FrustumClipping;
	import com.away3d.primitives.Plane;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.toolsets.character.horse.HorseGR;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	import com.tada.clopclop.toolsets.character.jockey.JockeyGR;
	import com.tada.clopclop.toolsets.racing.RacingAsset;
	import com.tada.clopclop.toolsets.racing.RacingGR;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.text.TextField;

	public class Racing3DView extends Sprite
	{
		private var _view:View3D;
		private var _propsGr:RacingGR = RacingGR.getInstance();
		private var _horseGr:HorseGR = HorseGR.getInstance();
		private var _jockeyGr:JockeyGR = JockeyGR.getInstance();
		private var _racingAsset:RacingAsset;
		private var _basicCam:CameraHover;
		private var _plane:Plane;
		private var _mainCam:HoverCamera3D;
		private var _testText:TextField;
		private var _horseArray:Array = [];
		private var _jockeyArray:Array = [];
		private var _offset:Number = -3000;
		private var _characterContainer:Vector.<ObjectContainer3D> = new Vector.<ObjectContainer3D>();
		
		public function Racing3DView()
		{
		}
		
		public function init():void{
			init3D();
			initAssets();	
			initCamSettings();
			initViewClipping();
			initListeners();
		}
		
		private function initListeners():void{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);		
		}
		
		private function init3D():void{
			_plane = new Plane();
			_plane.scale(50);
			_view = new View3D({x:380, y:400});
			addChild(_view);
			//_view.scene.addChild(_plane);
			_basicCam = new CameraHover(stage);
			_view.camera = _basicCam;
			_basicCam.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);
			
		}
		
		private function initCamSettings():void{
			// dummy target
			var plane:Plane = new Plane;
			plane.ownCanvas = true;
			plane.alpha = 0;
			_basicCam.fov = 50;
			_racingAsset.trackGen.addAnimatorPathInstance(plane, .004,new Vector3D(0,0,0),2);
			_basicCam.target = plane;
		}
		
		private function initViewClipping():void{
			//_view.clipping = new FrustumClipping();
			_view.clipping.minX = -300;
			_view.clipping.maxX = 300;
			_view.clipping.minY = -248;
			_view.clipping.maxY = 90;
		}
		
		private function initAssets():void{
			_racingAsset = new RacingAsset(_view);
			
			for (var charSet:int = 0; charSet<4; charSet++){
				var horseInst:HorseAsset = new HorseAsset(_view);
				horseInst.changeAnimationByType(HorseGR.ANIM_RUN);
				horseInst.mesh.scale(.8);
				horseInst.mesh.rotationY = 90;
				if (charSet % int (Math.random() * 5) == 0){
					horseInst.addEquipment(HorseGR.WING_SET);
				}
				horseInst.changeTextureByPart(HorseGR.BODY_SET, int(Math.random()*8));
				_horseArray[charSet] = horseInst;
				
				var jockeyInst:JockeyAsset = new JockeyAsset(_view);
				var rand:int = int (Math.random() * 2+1)-1;
				var index:int = 0;
				if (rand%2 == 0){
					index = JockeyGR.ANIM_RIDING01;
				} else {
					index = JockeyGR.ANIM_RIDING02;
				}
				
				jockeyInst.changeAnimationByType(index);
				jockeyInst.mesh.moveUp(550);
				jockeyInst.mesh.scale(.8);
				jockeyInst.mesh.rotationY = 90;
				
				jockeyInst.changeTextureByPart(JockeyGR.SKIN_SET, int(Math.random()*8));
				_jockeyArray[charSet] = jockeyInst;
				_characterContainer[charSet] = new ObjectContainer3D();
				_characterContainer[charSet].addChild(_horseArray[charSet].mesh);
				_characterContainer[charSet].addChild(_jockeyArray[charSet].mesh);
				_racingAsset.trackGen.addAnimatorPathInstance(_characterContainer[charSet],0.007 ,new Vector3D(_offset,0,0),2);
				_offset += 1500;
				_view.scene.addChild(_characterContainer[charSet]);
			}
			
			_jockeyArray[0].addEquipment(JockeyGR.ACC_SET);
			_jockeyArray[0].addEquipment(JockeyGR.HEAD_SET);
			_jockeyArray[0].changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_007);
			_jockeyArray[0].changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_007_0002);
			_jockeyArray[0].changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHACC_005);
			_jockeyArray[0].changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXACC_005_0002);
				
			_jockeyArray[1].addEquipment(JockeyGR.ACC_SET);
			_jockeyArray[1].addEquipment(JockeyGR.HEAD_SET);
			_jockeyArray[1].changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_003);
			_jockeyArray[1].changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_003_0001);
			_jockeyArray[1].changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHACC_007);
			_jockeyArray[1].changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXACC_007_0001);
			
			_jockeyArray[2].addEquipment(JockeyGR.ACC_SET);
			_jockeyArray[2].addEquipment(JockeyGR.HEAD_SET);
			_jockeyArray[2].changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_010);
			_jockeyArray[2].changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_010_0001);
			_jockeyArray[2].changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHACC_002);
			_jockeyArray[2].changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXACC_002_0001);
			
			_jockeyArray[3].addEquipment(JockeyGR.ACC_SET);
			_jockeyArray[3].addEquipment(JockeyGR.HEAD_SET);
			_jockeyArray[3].changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_008);
			_jockeyArray[3].changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_008_0002);
			_jockeyArray[3].changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHACC_004);
			_jockeyArray[3].changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXACC_004_0001);
			
			_racingAsset.trackGen.setPathDebugVisibility(true);
			_racingAsset.startTime();
			_horseGr.addOnAnimXMLLoaded(onAnimXMLLoaded);
		}
		
		private function onAnimXMLLoaded(evt:HorseEvent):void{
			for (var horse:int = 0; horse<_horseArray.length; horse++){
				
			}
		}
		
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);	
		}
		
		public function onEnterFrame (evt:Event):void{
			_view.render();
		}
	}
}