package com.tada.clopclop.test.type
{
	import com.away3d.containers.View3D;
	import com.away3d.core.base.Mesh;
	import com.away3d.core.base.Object3D;
	import com.away3d.core.base.Segment;
	import com.away3d.core.geom.Path;
	import com.away3d.core.geom.PathCommand;
	import com.away3d.primitives.BezierPatch;
	import com.away3d.primitives.Plane;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.toolsets.character.horse.HorseGR;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	import com.tada.clopclop.toolsets.character.jockey.JockeyGR;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.system.Security;
	import flash.text.TextField;
	
	public class StressTest extends Sprite
	{
		private var _view:View3D;
		private var _camera:CameraHover;
		private var _horse:HorseAsset;
		private var _horse2:HorseAsset;
		private var _jockey:JockeyAsset;
		private var _rotY:Number = 0;
		private var _jockeyGR:JockeyGR = JockeyGR.getInstance();
		private var _horseGR:HorseGR = HorseGR.getInstance();
		private var _horseArray:Array = [];
		private var _xPos:int = 0;
		private var _zPos:int = 0;
		private var _testTF:TextField;
		
		
		public function StressTest()
		{
			if (stage){
				init();
			} else {
				stage.addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function init(evt:Event = null):void{
			Security.allowDomain("localhost");
			Security.allowDomain("tadaworld.net");
			Security.allowDomain("clopclopdev.tadaworld.net");
			Security.allowDomain("clopclop.tadaworld.net");
			
			_testTF = new TextField();
			addChild(_testTF);
			//_testTF.text = "This is a test";
			//_testTF.addEventListener(MouseEvent.CLICK, onMouseClick);
			_view = new View3D({x:250, y:300});
			addChild(_view);
			_camera = new CameraHover(stage);
			_view.camera = _camera;
			_camera.setCameraPreset(CameraHover.CAMHOVER_DEFAULT);
			_camera.setRacingPreset(CameraHover.RACING_CRANE, 10, {sPos:-1000, ePos:5000});
			
			for (var x:int = 0; x<2; x++){
				var jockey:JockeyAsset = new JockeyAsset(_view);
				jockey.mesh.moveForward(_xPos);
				jockey.mesh.moveLeft(_zPos);
				//horse.changeMeshByType(HorseGR.MOUTH_SET, HorseGR.MESHMOUTH_003);
				//horse.changeAnimationByType(HorseGR.ANIM_IDLE02);
				//horse.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0004);
				//horse.changeMeshByType(HorseGR.MOUTH_SET, HorseGR.MESHMOUTH_002);
				//horse.changeMeshByType(HorseGR.HAIR_SET, HorseGR.MESHHAIR_003);
				//horse.changeTextureByPart(HorseGR.MOUTH_SET, HorseGR.TEXMOUTH_DEFAULT);
				//horse.changeAnimationByType(HorseGR.ANIM_IDLE01);
				jockey.shadow = false;
				_xPos += 1000;
				if (x%10 == 0){
					_xPos = 0;
					_zPos += 2500;
				}
				
				//plane = HorseGR.getInstance().getShadow();
				_horseArray[x] = jockey;
			}
			
			//_horse = new HorseAsset (_view);
			//_jockey = new JockeyAsset (_view);
			
			//var plane:Plane = new Plane();
			//plane.scale(100);
			//plane.pushback = true;
			//_view.scene.addChild(plane);
			_camera.distance = 6000;
			//_camera.position = new Vector3D(20000,0,20000);
			_camera.tiltAngle = 40;
			_camera.target = _horseArray[0];
			_camera.hover(true);
			//_horseGR.addOnAnimXMLLoaded(onXMLLoaded);
			//_jockeyGR.addOnAnimXMLLoaded(onJockeyAnimXMLLoaded);
			cameratest();
			//pathtest();
			addListeners();
		}
		
		private function linetest():void{
			var path:Path = new Path();
			//var pc:PathCommand = new PathCommand(
			/*// Open-ended line segment
			var mesh:Mesh = new Mesh();
			var segment0:Segment = new Segment();
			segment0.moveTo(100, 500, 0);
			segment0.lineTo(600, 500, 0);
			segment0.lineTo(600, 0, 0);
			segment0.curveTo(1100, 0, 0, 1100, -500, 0);
			mesh.addSegment(segment0);
			_view.scene.addChild(mesh);
			*/
		}
		
		private function cameratest():void{
			
		}
		
		private function onJockeyAnimXMLLoaded (evt:JockeyEvent):void{
			//_jockey.changeAnimationByType(JockeyGR.ANIM_SHOWER);
			//_jockey.changeAnimationByType(JockeyGR.ANIM_FEED);
			//_jockey.changeAnimationByType(JockeyGR.ANIM_CURE);
			//_jockey.changeAnimationByType(JockeyGR.ANIM_TRAINING);
			//_jockey.changeAnimationByType(JockeyGR.ANIM_CONSTRUCTION);
			//_jockey.changeMeshByType(JockeyGR.BOTTOM_SET, 1);
			//_jockey.changeMeshByType(JockeyGR.HAIR_SET, 2);
			//_jockey.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0008);
			//_jockey.changeTextureByPart(JockeyGR.BOTTOM_SET, JockeyGR.TEXBOTTOM_001_0005);
			//_jockey.changeTextureByPart(JockeyGR.HAIR_SET, JockeyGR.TEXHAIR_002_0001);
			//_jockey.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0003);
			//_jockey.changeTextureByPart(JockeyGR.SHOES_SET, JockeyGR.TEXSHOES_001_0003);
			//_jockey.changeTextureByPart(JockeyGR.EYE_SET, JockeyGR.TEXEYE_001_0010);
			//_jockey.changeTextureByPart(JockeyGR.EYEBROW_SET, JockeyGR.TEXEYEBROW_001_0009);
			//_jockey.changeTextureByPart(JockeyGR.MOUTH_SET, JockeyGR.TEXMOUTH_001_0008);
			//_jockey.addEquipment(JockeyGR.HEAD_SET);
			//_jockey.addEquipment(JockeyGR.ACC_SET);
			//_jockey.changeMeshByType(JockeyGR.ACC_SET, 3);
			//_jockey.changeTextureByPart(JockeyGR.ACC_SET, 6);
			//_jockey.changeMeshByType(JockeyGR.HEAD_SET, 5);
			//_jockey.changeTextureByPart(JockeyGR.HEAD_SET, 5);
			//_jockey.changeMeshByType(JockeyGR._jockey.changeMeshByType(JockeyGR.HEAD_SET, 2);
			
		}
		
		private function onXMLLoaded (evt:HorseEvent):void{
			//_horse.changeAnimationByType(HorseGR.ANIM_PLEASANT);
			//_horseGR.removeOnAnimXMLLoaded(onXMLLoaded);
			//_horse.changeMeshByType(HorseGR.HAIR_SET, HorseGR.MESHHAIR_003);
			//_horse.changeMeshByType(HorseGR.MOUTH_SET, HorseGR.MESHMOUTH_003);
			//_horse.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0005);
			//_horse.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0008);
			//_horse.changeTextureByPart(HorseGR.BRIDLE_SET, HorseGR.TEXBRIDLE_0016);
			//_horse.changeTextureByPart(HorseGR.SADDLE_SET, HorseGR.TEXSADDLE_0011);
			//_horse.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0005);
			//_horse.mesh.yaw(45);
			//_horse.addEquipment(HorseGR.WING_SET);
			//_horse.changeAnimationByType(HorseGR.ANIM_RUN);
		}
		
		private function onMouseClick (evt:MouseEvent):void{
			//_horse.changeTextureByPart(HorseGR.BRIDLE_SET, HorseGR.TEXBRIDLE_0002);
			//_jockey.changeMeshByType(JockeyGR.HAIR_SET, JockeyGR.MESHHAIR_003);
			//_jockey.changeMeshByType(JockeyGR.BOTTOM_SET, JockeyGR.MESHBOTTOM_002);
			//_horse.changeMeshByType(HorseGR.HAIR_SET, HorseGR.MESHHAIR_006);
			if (_horse.equipmentExists(HorseGR.WING_SET) == false){
				_horse.addEquipment(HorseGR.WING_SET);
			} else {
				if (_horse.equipmentVisibility(HorseGR.WING_SET) == true){
					_horse.setSpecificEquipmentVisibility(HorseGR.WING_SET, false);
				} else {
					_horse.setSpecificEquipmentVisibility(HorseGR.WING_SET, true);
				}
			}
		}
	
		private function addListeners():void{
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame (evt:Event):void{
			_view.render();
			_view.scene.updateTime();
			//for (var a:int = 0; a<_horseArray.length;a++){
			//_horseArray[a].mesh.rotationY = _rotY++;
			//}
		}
	}
}