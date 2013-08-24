package 
{
	import com.away3d.animators.VertexAnimator;
	import com.away3d.cameras.*;
	import com.away3d.cameras.lenses.PerspectiveLens;
	import com.away3d.containers.*;
	import com.away3d.core.base.*;
	import com.away3d.core.clip.FrustumClipping;
	import com.away3d.core.clip.NearfieldClipping;
	import com.away3d.core.clip.RectangleClipping;
	import com.away3d.core.geom.Path;
	import com.away3d.core.render.Renderer;
	import com.away3d.core.utils.*;
	import com.away3d.debug.*;
	import com.away3d.events.Loader3DEvent;
	import com.away3d.extrusions.LinearExtrusion;
	import com.away3d.extrusions.PathDuplicator;
	import com.away3d.extrusions.PathExtrusion;
	import com.away3d.loaders.*;
	import com.away3d.materials.*;
	import com.away3d.test.Button;
	import com.tada.clopclop.test.type.Jockey;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.horse.HorseAnimation;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.toolsets.character.horse.HorseGR;
	import com.tada.clopclop.toolsets.character.horse.event.HorseEvent;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	import com.tada.clopclop.toolsets.character.jockey.JockeyGR;
	import com.tada.clopclop.toolsets.character.jockey.event.JockeyEvent;
	
	import flash.display.*;
	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import flashx.textLayout.elements.BreakElement;
	

	[SWF(backgroundColor="#FFFFFF", width="800", height="600", frameRate="30")]
	
	public class ClopClopRacingTest extends Sprite
	{
		
		//(source="assets/Racing/stadium.md2",mimeType="application/octet-stream"
		//private var stadiumClass:Class;
		
		//[Embed(source="com/tada/clopclop/common/assets/Racing/sky.md2",mimeType="application/octet-stream")]
		//private var skyClass:Class;
		
		//[Embed(source="com/tada/clopclop/common/assets/Racing/bg.png")]
		//private var stadiumTexture:Class;
		
		//[Embed(source="com/tada/clopclop/common/assets/Racing/sky.jpg")]
		//private var skyTexture:Class;
		

		private var scene:Scene3D;
		private var camera:HoverCamera3D;
		private var view:View3D;
		

		private var stadiumMaterial:BitmapFileMaterial;
		private var skyMaterial:BitmapFileMaterial;
		

		//private var stadiumMd2:Md2;
		//private var skyMd2:Md2;
		
		private var stadiumObject:Mesh;
		private var skyObject:Mesh;
		

		//Mouse Settings
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var move:Boolean = false;
		
		//Keyboard Settings
		private var lastKey:uint;
		private var keyIsDown:Boolean = false;
		//////////////////////////////////
		private var jockey:JockeyAsset;
		private var jockey2:JockeyAsset;
		private var jockey3:JockeyAsset;
		private var jockey4:JockeyAsset;
		private var jockey5:JockeyAsset;
		private var jockeyGr:JockeyGR = JockeyGR.getInstance();
		//Horse Settings/////////////////
		//Note//
		//To get the correct rotation speed of the horse base on his speed//
		//Add 0.115 to rotationSpeed per 50 speed added to horse speed//
		////////////////////////////////
		private var horse:HorseAsset;
		private var horse2:HorseAsset;
		private var horse3:HorseAsset;
		private var horse4:HorseAsset;
		private var horse5:HorseAsset;

		private var horseSpeed:int = 500*2; //default speed is 500 correspond to rotation speed
		private var rotationSpeed:Number = .825*2; //default for rotation speed is 1.15 correspond to speed
		private var extraSpeed:int = 250;
		private var isNewUTurn:Boolean;
		private var animCtr:Number = 0;
		private var horseArray:Array;
		private var horseStartPosX:int = 93500;
		private var horseStartPosY:int = 35000;
		private var firstHorseUTurn:int = -57500;// 116000 distance from starting point to UTurn point
		private var secondHorseUTurn:int = 57500;
		//private var horseUTurnPosY:int = 25000;
		private var finishLineX:int = 5000;
		private var finishLineY:int = 25000;
		private var activateFinishLine:Boolean = false;
		//Camera Settings
		//camera zoom default 10
		//camera focus default 100
		private var tiltUp:int = 1;
		private var tiltDown:int = 1;
		private var panRight:int = 1;
		private var panLeft:int = 1;
		private var zoomIn:int = 1;
		private var zoomOut:int = 1;
		//Labels
		private var zoomLabel:TextField;
		private var focusLabel:TextField;
		private var tiltAngleLable:TextField;
		private var panAngleLable:TextField;
		private var keyboardLabel:TextField;
		private var keyboardLabel2:TextField;
		private var keyboardLabel3:TextField;
		private var keyboardLabel4:TextField;
		private var keyboardLabel5:TextField;
		private var mouseOrbitLabel:TextField;
		private var mouseLabel:TextField;
		private var arrowOrbitLabel:TextField;
		private var _horseGr:HorseGR = HorseGR.getInstance();
		private var canRun:Boolean = false;
		private var stadiumLoader:Loader3D;
		private var skyLoader:Loader3D;
		//Time
		private var myTimer:Timer = new Timer(1000,1);
		private var startRunning:Boolean = false;
		private var _stadiumVertAnim:VertexAnimator;
		private var _skyVertAnim:VertexAnimator;
		private var assetView:View3D = new View3D();
		private var assetScene:Scene3D;
		private var assetCamera:HoverCamera3D;
		public function ClopClopRacingTest()
		{
			if (stage){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(evt:Event = null):void
		{
			Security.allowDomain("localhost");
			Security.allowDomain("tadaworld.net");
			Security.allowDomain("clopclopdev.tadaworld.net");
			Security.allowDomain("clopclop.tadaworld.net");
			initEngine();
			//initMaterials();
			initObjects();
			initEnvironment();
			initListeners();
		}
		
		private function initEngine():void
		{
			//assetCamera = new HoverCamera3D();
			scene = new Scene3D();
			camera = new HoverCamera3D();
			camera.lens = new PerspectiveLens();
			camera.panAngle = 185;
			camera.tiltAngle = 2;
			camera.zoom = 50;
			camera.distance = 12000;
			camera.focus = 10;
			camera.hover(true);
			
			//camera.fov = 60;
			view = new View3D();
			
			addChild(view);
			//view.clipping.objectCulling = true;
			//view.clipping.maxZ = 500000;
			//view.clipping.minZ = -500000;
			view.scene = scene;
			view.camera = camera;
			
			//view.renderer = Renderer.BASIC;
			//view.renderer = Renderer.CORRECT_Z_ORDER;
			//view.renderer = Renderer.INTERSECTING_OBJECTS;
		}
		
//		private function initMaterials():void
//		{
//			stadiumMaterial = new BitmapFileMaterial(Cast.bitmap(stadiumTexture));
//			skyMaterial = new BitmapFileMaterial(Cast.bitmap(skyTexture));
//		}
		
		private function initEnvironment():void{
			var md2:Md2 = new Md2();
			var md22:Md2 = new Md2();
			stadiumMaterial = new BitmapFileMaterial("assets/props/racing/bg.png");
			md2.material = stadiumMaterial;
			stadiumLoader = new Loader3D();
			skyLoader = new Loader3D();
			skyMaterial = new BitmapFileMaterial("assets/props/racing/sky.jpg");
			md22.material = skyMaterial;
			
			stadiumLoader.addEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
			stadiumLoader.addEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
			skyLoader.addEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
			skyLoader.addEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadError);
			stadiumLoader.loadGeometry("assets/props/racing/stadium.md2", md2);
			skyLoader.loadGeometry("assets/props/racing/sky.md2", md22);
		}
		
		private function onLoadError(evt:Loader3DEvent):void{
			trace(evt.loader.IOErrorText);
		}
		private function onLoadComplete(evt:Loader3DEvent):void{
			switch(evt.currentTarget){
				case stadiumLoader:
					stadiumLoader.removeEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
					stadiumLoader.removeEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
					stadiumObject = stadiumLoader.handle as Mesh;
					stadiumObject.scale(1);
					stadiumObject.pushback = true;
					//_stadiumVertAnim = stadiumObject.animationLibrary.getAnimation("default").animator as VertexAnimator;
					//_stadiumVertAnim.play();
					scene.addChild(stadiumObject);
					break;
				
				case skyLoader:
					skyLoader.removeEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
					skyLoader.removeEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
					skyObject = skyLoader.handle as Mesh;
					skyObject.scale(1);
					skyObject.pushback = true;
					//_skyVertAnim = skyObject.animationLibrary.getAnimation("default").animator as VertexAnimator;
					//_skyVertAnim.play();
					scene.addChild(skyObject);
					break;
			}	
		}
		
		private function initObjects():void
		{

//			stadiumMd2 = new Md2();
//			stadiumMd2.fps = 32;
//			stadiumMd2.centerMeshes = true;
//			stadiumObject = stadiumMd2.parseGeometry(stadiumClass) as Mesh;

			
//			skyMd2 = new Md2();
//			skyMd2.fps = 32;
//			skyMd2.centerMeshes = true;
//			skyObject = skyMd2.parseGeometry(skyClass) as Mesh;

			
			horse = new HorseAsset(view);
			horse2 = new HorseAsset(view);
			horse3 = new HorseAsset(view);
			horse4 = new HorseAsset(view);
			//horse5 = new HorseAsset(view);
			horse.animation.setFPS(30);
			horse2.animation.setFPS(30);
			horse3.animation.setFPS(30);
			horse4.animation.setFPS(30);
			_horseGr.addOnAnimXMLLoaded(onAnimXMLLoaded);
			
			jockey = new JockeyAsset(view);
			jockey2 = new JockeyAsset(view);
			jockey3 = new JockeyAsset(view);
			jockey4 = new JockeyAsset(view);
			//jockey5 = new JockeyAsset(view);
			
			jockeyGr.addOnAnimXMLLoaded(onJockeyAnimXMLLoaded);
			/**
			horseArray = new Array();
			for(var i:int = 0; i <= 3; i++){
				horseArray[i] = new HorseAsset(view);
				horseArray[i].mesh.moveRight(2000);
				horseArray[i].mesh.moveForward(horseStartPosY+2000);
				horseArray[i].mesh.moveRight(horseStartPosX);
				horseArray[i].mesh.moveUp(50);
			}**/
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			
			zoomLabel = new TextField();
			zoomLabel.x = 50;
			zoomLabel.y = 50+300;
			
			focusLabel = new TextField();
			focusLabel.x = 50;
			focusLabel.y = 70+300;
			
			panAngleLable = new TextField();
			panAngleLable.x = 50;
			panAngleLable.y = 90+300;
			
			tiltAngleLable = new TextField();
			tiltAngleLable.x = 50;
			tiltAngleLable.y = 110+300;
			
			keyboardLabel = new TextField();
			keyboardLabel.x = 50;
			keyboardLabel.y = 200+250;
			keyboardLabel2 = new TextField();
			keyboardLabel2.x = 50;
			keyboardLabel2.y = 255+250;
			keyboardLabel3 = new TextField();
			keyboardLabel3.x = 50;
			keyboardLabel3.y = 225+250;
			keyboardLabel4 = new TextField();
			keyboardLabel4.x = 50;
			keyboardLabel4.y = 240+250;
			keyboardLabel5 = new TextField();
			keyboardLabel5.x = 50;
			keyboardLabel5.y = 270+250;
			
			mouseLabel = new TextField();
			mouseLabel.x = 50+150;
			mouseLabel.y = 200+250;
			
			mouseOrbitLabel = new TextField();
			mouseOrbitLabel.x = 50+150;
			mouseOrbitLabel.y = 225+250;
			
			arrowOrbitLabel = new TextField();
			arrowOrbitLabel.x = 50+150;
			arrowOrbitLabel.y = 240+250;
			
			zoomLabel.text = "Zoom = " + camera.zoom;
			focusLabel.text = "Focus = " + camera.focus;
			
			panAngleLable.text = "Pan Angle = " + camera.panAngle;
			tiltAngleLable.text = "Tilt Angle = " + camera.tiltAngle;
			
			keyboardLabel.text = "KeyBoard Control";
			keyboardLabel2.text = "A,D = Left & Right";
			keyboardLabel3.text = "W = +50% Boost";
			keyboardLabel4.text = "S = Slow Down";
			keyboardLabel5.text = "Zoom = + and -";
			mouseLabel.text = "Mouse Control";
			mouseOrbitLabel.text = "LeftMouse to Orbit";
			arrowOrbitLabel.text = "or use Arrow Btns";
			
			
			
			sprite.addChild(zoomLabel);
			sprite.addChild(focusLabel);
			sprite.addChild(panAngleLable);
			sprite.addChild(tiltAngleLable);
			sprite.addChild(keyboardLabel);
			sprite.addChild(keyboardLabel2);
			sprite.addChild(keyboardLabel3);
			sprite.addChild(keyboardLabel4);			
			sprite.addChild(keyboardLabel5);
			sprite.addChild(mouseOrbitLabel);
			sprite.addChild(mouseLabel);
			sprite.addChild(arrowOrbitLabel);
			
		}
		
		private function onAnimXMLLoaded(evt:HorseEvent):void{
			_horseGr.removeOnAnimXMLLoaded(onAnimXMLLoaded);
			horse.mesh.moveForward(horseStartPosY-3000);
			horse.mesh.moveRight(horseStartPosX);
			horse.mesh.moveUp(50);
			horse.changeAnimationByType(HorseGR.ANIM_EAT);
			horse.pushfront = true;
			//horse.changeMeshByType(HorseGR.HAIR_SET, HorseGR.MESHHAIR_007);
			//horse.changeTextureByPart(HorseGR.HAIR_SET, HorseGR.TEXHAIR_007_0001);
			//horse.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0006);
			
			horse2.mesh.moveForward(horseStartPosY-1500);
			horse2.mesh.moveRight(horseStartPosX);
			horse2.mesh.moveUp(50);
			//horse3.addEquipment(HorseGR.WING_SET);
			horse2.changeAnimationByType(HorseGR.ANIM_HUNGRY);
			//horse2.changeMeshByType(HorseGR.MOUTH_SET, HorseGR.MESHMOUTH_003);
			//horse2.changeTextureByPart(HorseGR.MOUTH_SET, HorseGR.TEXMOUTH_003_0003);
			//horse2.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0005);
			horse2.pushfront = true;
			
			horse3.mesh.moveForward(horseStartPosY);
			horse3.mesh.moveRight(horseStartPosX);
			horse3.mesh.moveUp(50);
			horse3.changeAnimationByType(HorseGR.ANIM_DANCE);
			//horse3.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0004);
			horse3.pushfront = true;
			
			horse4.mesh.moveForward(horseStartPosY+1500);
			horse4.mesh.moveRight(horseStartPosX);
			horse4.mesh.moveUp(50);
			horse4.changeAnimationByType(HorseGR.ANIM_PLEASANT);
			//horse4.changeMeshByType(HorseGR.MOUTH_SET, HorseGR.MESHMOUTH_002);
			//horse4.changeTextureByPart(HorseGR.MOUTH_SET, HorseGR.TEXMOUTH_002_0001);
			//horse4.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0003);
			horse4.pushfront = true;
			
			//horse5.mesh.moveForward(horseStartPosY+3000);
			//horse5.mesh.moveRight(horseStartPosX);
			//horse5.mesh.moveUp(50);
			//horse.addEquipment(HorseGR.WING_SET);
			//horse5.changeAnimationByType(HorseGR.ANIM_PLEASANT);
			//horse5.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0002);
			//horse5.pushfront = true;
		
			canRun = true;
			

		}
		private function onJockeyAnimXMLLoaded(evt:JockeyEvent):void{
			jockeyGr.removeOnAnimXMLLoaded(onJockeyAnimXMLLoaded);
			jockey.mesh.moveForward(horseStartPosY-3000);
			jockey.mesh.moveRight(horseStartPosX);
			jockey.mesh.moveUp(800);
			jockey.changeAnimationByType(JockeyGR.ANIM_RIDING01);
			jockey.shadow = false;
			jockey2.shadow = false;
			jockey3.shadow = false;
			jockey4.shadow = false;
			jockey.animation.setFPS(30);
			jockey2.animation.setFPS(30);
			jockey3.animation.setFPS(30);
			jockey4.animation.setFPS(30);
			//jockey5.shadow = false;
			
			jockey.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0005);
			jockey2.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0003);
			jockey3.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0006);
			jockey4.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0002);
			//jockey5.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0010);
			
			jockey.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0005);
			jockey2.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0004);
			jockey3.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0007);
			jockey4.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0010);
			//jockey5.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0003);
			
			jockey3.addEquipment(JockeyGR.ACC_SET);
			jockey3.changeMeshByType(JockeyGR.ACC_SET, JockeyGR.MESHACC_002);
			jockey3.changeTextureByPart(JockeyGR.ACC_SET, JockeyGR.TEXACC_002_0001);
			
			jockey.addEquipment(JockeyGR.HEAD_SET);
			jockey.changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_003);
			jockey.changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_003_0001);
			
			//jockey2.addEquipment(JockeyGR.HEAD_SET);
			//jockey2.changeMeshByType(JockeyGR.HEAD_SET, 5);
			//jockey2.changeTextureByPart(JockeyGR.HEAD_SET, 5);
			
			//jockey5.addEquipment(JockeyGR.ACC_SET);
			//jockey5.changeMeshByType(JockeyGR.ACC_SET, JockeyGR.MESHACC_003);
			//jockey5.changeTextureByPart(JockeyGR.ACC_SET, JockeyGR.TEXACC_003_0001);
			//jockey.pushfront = true;
			
			jockey2.mesh.moveForward(horseStartPosY-1500);
			jockey2.mesh.moveRight(horseStartPosX);
			jockey2.mesh.moveUp(800);
			jockey2.changeAnimationByType(JockeyGR.ANIM_RIDING01);
			//jockey2.pushfront = true;
			
			jockey3.mesh.moveForward(horseStartPosY);
			jockey3.mesh.moveRight(horseStartPosX);
			jockey3.mesh.moveUp(800);
			jockey3.changeAnimationByType(JockeyGR.ANIM_RIDING01);
			//jockey3.pushfront = true;
			
			jockey4.mesh.moveForward(horseStartPosY+1500);
			jockey4.mesh.moveRight(horseStartPosX);
			jockey4.mesh.moveUp(800);
			jockey4.changeAnimationByType(JockeyGR.ANIM_RIDING01);
			//jockey4.pushfront = true;
			
			//jockey5.mesh.moveForward(horseStartPosY+3000);
			//jockey5.mesh.moveRight(horseStartPosX);
			//jockey5.mesh.moveUp(800);
			//jockey5.changeAnimationByType(JockeyGR.ANIM_RIDING01);
		}
		
		private function initListeners():void
		{
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			myTimer.addEventListener(TimerEvent.TIMER, timerListener);
		}
		
		private function onEnterFrame(event:Event):void
		{
			cinematicEntrance();
			myTimer.start();		
			if (canRun == true){
				onTheRun();
				onUTurn();
				finishLine();
			}
			horseController();
			cameraFunction();
			onResize();
			view.render();

			//assetView.render();
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			lastPanAngle = camera.panAngle;
			lastTiltAngle = camera.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
			move = true;
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			move = false;
  
		}
		private function onResize(event:Event = null):void
		{
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
			
		}
		private function keyDown(e:KeyboardEvent):void
		{
			lastKey = e.keyCode;
			keyIsDown = true;
		}
		private function keyUp(e:KeyboardEvent):void
		{
			keyIsDown = false;
		}
		private function onUTurn():void{
			if(horse.mesh.x <= firstHorseUTurn){
				camera.panAngle -=rotationSpeed;
				horse.mesh.rotationY -=rotationSpeed;
				jockey.mesh.rotationY -=rotationSpeed;
				panAngleLable.text = "Pan Angle = " + camera.panAngle;
				isNewUTurn = true;
				///////////////////////////
				if(horse2.mesh.x <= firstHorseUTurn){
					horse2.mesh.rotationY -=(rotationSpeed+.0325);
					jockey2.mesh.rotationY -=(rotationSpeed+.0325);
					//isNewUTurn = true;
				}
				/////////////////////////
				if(horse3.mesh.x <= firstHorseUTurn){
					horse3.mesh.rotationY -=(rotationSpeed+.0125);
					jockey3.mesh.rotationY -=(rotationSpeed+.0125);
					//isNewUTurn = true;
				}
				////////////////////////
				if(horse4.mesh.x <= firstHorseUTurn){
					horse4.mesh.rotationY -=(rotationSpeed+.0225);
					jockey4.mesh.rotationY -=(rotationSpeed+.0225);
					//isNewUTurn = true;
				}
				//if(horse5.mesh.x <= firstHorseUTurn){
				//	horse5.mesh.rotationY -=(rotationSpeed+.0425);
				//	jockey5.mesh.rotationY -=(rotationSpeed+.0425);
					//isNewUTurn = true;
				//}
			}

			///////////////////////
			if(isNewUTurn){
				if(horse.mesh.x >= secondHorseUTurn){
					camera.panAngle -=rotationSpeed;
					horse.mesh.rotationY -=rotationSpeed;
					jockey.mesh.rotationY -=rotationSpeed;
					panAngleLable.text = "Pan Angle = " + camera.panAngle;
					activateFinishLine = true;
				
				////////////////////////////////////
				if(horse2.mesh.x >= secondHorseUTurn){
					horse2.mesh.rotationY -=rotationSpeed;
					jockey2.mesh.rotationY -=rotationSpeed;
					//activateFinishLine = true;
				}
			
				////////////////////////////////////
				if(horse3.mesh.x >= secondHorseUTurn){
					horse3.mesh.rotationY -=rotationSpeed;
					jockey3.mesh.rotationY -=rotationSpeed;
					//activateFinishLine = true;
				}
				/////////////////////////////////////
				if(horse4.mesh.x >= secondHorseUTurn){
					horse4.mesh.rotationY -=rotationSpeed;		
					jockey4.mesh.rotationY -=rotationSpeed;
					//activateFinishLine = true;
				}
				//if(horse5.mesh.x >= secondHorseUTurn){
					//horse5.mesh.rotationY -=rotationSpeed;		
					//jockey5.mesh.rotationY -=rotationSpeed;
					//activateFinishLine = true;
				//}
				}
			}
		}
		private function onTheRun():void{
			if(startRunning){
				horse.mesh.moveLeft(horseSpeed);	
				horse2.mesh.moveLeft(horseSpeed-15);
				horse3.mesh.moveLeft(horseSpeed-5);
				horse4.mesh.moveLeft(horseSpeed-10);
				//horse5.mesh.moveLeft(horseSpeed-20);
				
				jockey.mesh.moveLeft(horseSpeed);	
				jockey2.mesh.moveLeft(horseSpeed-15);
				jockey3.mesh.moveLeft(horseSpeed-5);
				jockey4.mesh.moveLeft(horseSpeed-10);
				//jockey5.mesh.moveLeft(horseSpeed-20);
				
				animCtr++;
				if(animCtr <= 1){
					horse.changeAnimationByType(HorseGR.ANIM_RUN);
					horse2.changeAnimationByType(HorseGR.ANIM_RUN);
					horse3.changeAnimationByType(HorseGR.ANIM_RUN);
					horse4.changeAnimationByType(HorseGR.ANIM_RUN);
					//horse5.changeAnimationByType(HorseGR.ANIM_RUN);
				}
			}
		}
		private function horseController():void{
			if(keyIsDown){
				if(camera.tiltAngle <= 1){
					camera.tiltAngle = 2;
				}else if(camera.tiltAngle >= 20){
					camera.tiltAngle = 19;
				}else if(camera.zoom <= 10){
					camera.zoom = 11;
				}else if(camera.zoom >= 120){
					camera.zoom = 119;
				}
				switch(lastKey){	
					case 65				: horse.mesh.rotationY -=rotationSpeed; break;//horse turn left (A)
					case 68				: horse.mesh.rotationY +=rotationSpeed; break;//horse turn right (D)
					case 87				: horse.mesh.moveLeft(extraSpeed); break;//horse moving forward (W)
					case 83				: horse.mesh.moveRight(extraSpeed); break;//horse moving backward (S)
					case Keyboard.UP	: camera.tiltAngle += tiltUp; break; 
					case Keyboard.DOWN	: camera.tiltAngle -= tiltDown; break;
					case Keyboard.LEFT	: camera.panAngle += panRight; break;
					case Keyboard.RIGHT	: camera.panAngle -= panLeft; break;
					case 107			: camera.zoom += zoomIn; break; //+ button
					case 109			: camera.zoom -= zoomOut; break; // - button
					case 13				: resetGame(); break;
				}
				zoomLabel.text = "Zoom = " + camera.zoom;
				panAngleLable.text = "Pan Angle = " + camera.panAngle;
				tiltAngleLable.text = "Tilt Angle = " + camera.tiltAngle;
			}
		}
		private function cameraFunction():void{
			if (move) {
				camera.panAngle = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
				camera.tiltAngle = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;
				panAngleLable.text = "Pan Angle = " + camera.panAngle;
				if(camera.tiltAngle <= 1){
					camera.tiltAngle = 1;
					tiltAngleLable.text = "Tilt Angle = " + camera.tiltAngle;
				}else if(camera.tiltAngle >= 20){
					camera.tiltAngle = 20;
					tiltAngleLable.text = "Tilt Angle = " + camera.tiltAngle;
				}
			}
			//Currently target to horse instead the stadium//
			camera.target = horse.mesh;
			//Just Hover//
			camera.hover();
		}
		private function timerListener(e:TimerEvent):void{
			if(getTimer() >= 5000){
				startRunning = true;
			}
		}
		private function finishLine():void{
			if(activateFinishLine){
				if(horse.mesh.x <= finishLineX){
					horse.mesh.moveLeft(-horseSpeed);
					startRunning = false;
					horse.changeAnimationByType(HorseGR.ANIM_JUMP);
				}
			}
		}
		private function cinematicEntrance():void{
			
		}
		private function resetGame():void{

		}
	}
}