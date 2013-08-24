package com.tada.clopclop.test.type
{
	import com.away3d.animators.PathAnimator;
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
	import com.away3d.primitives.Plane;
	import com.away3d.primitives.Trident;
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
	
	//	import org.flexunit.internals.namespaces.classInternal;
	
	[SWF(backgroundColor="#000000", width="800", height="600")]
	
	public class clopclopTestWaypoint extends Sprite
	{
		
		//(source="assets/Racing/stadium.md2",mimeType="application/octet-stream"
		//private var stadiumClass:Class;
		
		//[Embed(source="com/tada/clopclop/common/assets/Racing/sky.md2",mimeType="application/octet-stream")]
		//private var skyClass:Class;
		
		//[Embed(source="com/tada/clopclop/common/assets/Racing/bg.png")]
		//private var stadiumTexture:Class;
		
		//[Embed(source="com/tada/clopclop/common/assets/Racing/sky.jpg")]
		//private var skyTexture:Class;
		
		private var stadiumObject:Mesh;
		private var skyObject:Mesh;
		
		private var stadiumMaterial:BitmapFileMaterial;
		private var skyMaterial:BitmapFileMaterial;
		
		private var stadiumLoader:Loader3D;
		private var skyLoader:Loader3D;
		
		private var _stadiumVertAnim:VertexAnimator;
		private var _skyVertAnim:VertexAnimator;
		
		private var scene:Scene3D;
		private var camera:HoverCamera3D;
		private var view:View3D;
	
		//Mouse Settings
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var move:Boolean = false;

		private var horse:HorseAsset;
		private var horse2:HorseAsset;
		private var horse3:HorseAsset;
		private var horse4:HorseAsset;
		private var horseContainer:ObjectContainer3D = new ObjectContainer3D();
		private var horseContainer2:ObjectContainer3D = new ObjectContainer3D();
		private var horseContainer3:ObjectContainer3D = new ObjectContainer3D();
		private var horseContainer4:ObjectContainer3D = new ObjectContainer3D();
		private var horseGr:HorseGR = HorseGR.getInstance();
		
		private var jockey:JockeyAsset;
		private var jockey2:JockeyAsset;
		private var jockey3:JockeyAsset;
		private var jockey4:JockeyAsset;
		private var jockeyGr:JockeyGR = JockeyGR.getInstance();
		
		private var tiltUp:int = 1;
		private var tiltDown:int = 1;
		private var panRight:int = 1;
		private var panLeft:int = 1;
		private var zoomIn:int = 1;
		private var zoomOut:int = 1;
		
		private var horsePathAnimator:PathAnimator;
		private var horsePathAnimator2:PathAnimator;
		private var horsePathAnimator3:PathAnimator;
		private var horsePathAnimator4:PathAnimator;
		private var cameraPathAnimator:PathAnimator;
		
		private var trackPath:Path;
		private var rotationPoints:Array;
		private var time:Number = 0;
		private var time2:Number = 0;
		private var time3:Number = 0;
		private var time4:Number = 0;
		private var time5:Number = 0;
		private var trident:Trident = new Trident(2000,true);		
		
		private var firstPlaceLabel:TextField;
		private var secondPlaceLabel:TextField;
		private var thirdPlaceLabel:TextField;
		private var fourthPlaceLabel:TextField;
		
	
		public function clopclopTestWaypoint()
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
			initEnvironment()
			initObjects();
			initListeners();
			initAnimations();
		}
		
		private function initEngine():void
		{
			scene = new Scene3D();
			camera = new HoverCamera3D();
			camera.panAngle = 185;
			camera.tiltAngle = 2;
			camera.zoom = 150;
			camera.distance = 10000;
			//camera.focus = 100;
			camera.fov = 45;
			camera.hover(true);
			camera.lens = new PerspectiveLens();
			view = new View3D();
			
			addChild(view);
			view.scene = scene;
			view.camera = camera;
		
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			
			firstPlaceLabel = new TextField();
			firstPlaceLabel.x = 50;
			firstPlaceLabel.y = 100;
			
			secondPlaceLabel = new TextField();
			secondPlaceLabel.x = 50;
			secondPlaceLabel.y = 120;
			
			thirdPlaceLabel = new TextField();
			thirdPlaceLabel.x = 50;
			thirdPlaceLabel.y = 140;
			
			fourthPlaceLabel = new TextField();
			fourthPlaceLabel.x = 50;
			fourthPlaceLabel.y = 160;
			
			
			
			sprite.addChild(firstPlaceLabel);
			sprite.addChild(secondPlaceLabel);
			sprite.addChild(thirdPlaceLabel);
			sprite.addChild(fourthPlaceLabel);
			
			//view.renderer = Renderer.BASIC;
			//view.renderer = Renderer.CORRECT_Z_ORDER;
			//view.renderer = Renderer.INTERSECTING_OBJECTS;
			scene.addChild(new Trident(250, true));
		}
	
		private function initEnvironment():void{
			var md2:Md2 = new Md2();
			var md22:Md2 = new Md2();
			stadiumLoader = new Loader3D();
			skyLoader = new Loader3D();
			
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
					stadiumMaterial = new BitmapFileMaterial("assets/props/racing/bg.png");
					stadiumObject.material = stadiumMaterial;
					stadiumObject.scale(1);
					stadiumObject.pushback = true;
					_stadiumVertAnim = stadiumObject.animationLibrary.getAnimation("default").animator as VertexAnimator;
					_stadiumVertAnim.play();
					view.scene.addChild(stadiumObject);
					break;
				
				case skyLoader:
					skyLoader.removeEventListener(Loader3DEvent.LOAD_SUCCESS, onLoadComplete);
					skyLoader.removeEventListener(Loader3DEvent.LOAD_ERROR, onLoadError);
					skyObject = skyLoader.handle as Mesh;
					skyMaterial = new BitmapFileMaterial("assets/props/racing/sky.jpg");
					skyObject.material = skyMaterial;
					skyObject.scale(1);
					skyObject.pushback = true;
					_skyVertAnim = skyObject.animationLibrary.getAnimation("default").animator as VertexAnimator;
					_skyVertAnim.play();
					view.scene.addChild(skyObject);
					break;
			}	
		}
		
		private function initObjects():void
		{
			//var plane:Plane = new Plane();
			//plane.scale(100);
			//plane.segmentsH = 5;
			//plane.segmentsW = 5;
			//view.scene.addChild(plane);

			horse = new HorseAsset(view);
//			horse.animationSync();

			horse2 = new HorseAsset(view);
//			horse2.animationSync();

			horse3 = new HorseAsset(view);
//			horse3.animationSync();
			
			horse4 = new HorseAsset(view);
//			horse4.animationSync();
			
			jockey = new JockeyAsset(view);
//			jockey.animationSync();
			
			jockey2 = new JockeyAsset(view);
//			jockey2.animationSync();
			
			jockey3 = new JockeyAsset(view);
//			jockey3.animationSync();
			
			jockey4 = new JockeyAsset(view);
//			jockey4.animationSync();
			
			horseGr.addOnAnimXMLLoaded(onAnimXMLLoaded);
			jockeyGr.addOnAnimXMLLoaded(onJockeyAnimXMLLoaded);
			rotationPoints = new Array();
			rotationPoints.push(new Vector3D(0, 0, 0));
			rotationPoints.push(new Vector3D(0, 0, 0));
			rotationPoints.push(new Vector3D(0, 0, 0));

			var pointPath:Array = new Array();
			//1st straightPath
			pointPath.push(new Vector3D(93500,0,35000), new Vector3D(75500,0,35000), new Vector3D(57500,0,35000));
			pointPath.push(new Vector3D(57500,0,35000), new Vector3D(28750,0,35000), new Vector3D(0,0,35000));
			pointPath.push(new Vector3D(0,0,35000), new Vector3D(-28750,0,35000), new Vector3D(-57500,0,35000));
			//1st arcPath
			pointPath.push(new Vector3D(-57500,0,35000), new Vector3D(-92000,0,35000), new Vector3D(-92500, 0, 0));
			pointPath.push(new Vector3D(-92500,0,0), new Vector3D(-92000,0,-35000), new Vector3D(-57500,0,-35000));
			//2nd straightPath
			pointPath.push(new Vector3D(-57500,0,-35000), new Vector3D(-28750,0,-35000), new Vector3D(0,0,-35000));
			pointPath.push(new Vector3D(0,0,-35000), new Vector3D(28750,0,-35000), new Vector3D(57500,0,-35000));
			//2nd arcPath
			pointPath.push(new Vector3D(57500,0,-35000), new Vector3D(94000,0,-35000), new Vector3D(94500,0,0));
			pointPath.push(new Vector3D(94500,0,0), new Vector3D(94000,0,35000), new Vector3D(-57500,0,35000));
			//Last straightPath
			pointPath.push(new Vector3D(-57500,0,35000), new Vector3D(0,0,35000), new Vector3D(0,0,35000));
			//create the path object to be used again for the path animator
			trackPath = new Path(pointPath);
			trackPath.debugPath(view.scene);
			trackPath.smoothPath();
			//trackPath.
			trackPath.display = true;
			scene.addChild(trident);
		}
		
		private function onAnimXMLLoaded(evt:HorseEvent):void{
			horseGr.removeOnAnimXMLLoaded(onAnimXMLLoaded);
			horse.mesh.scale(.75);
			horse.mesh.rotationY = 90;
			horse.changeAnimationByType(HorseGR.ANIM_RUN);
			//horse.pushfront = true;
			horse.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0002);
			
			horse2.mesh.scale(0.75);
			horse2.mesh.rotationY = 90;
			horse2.changeAnimationByType(HorseGR.ANIM_RUN);
			//horse2.pushfront = true;
			horse2.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0003);
			
			horse3.mesh.scale(0.75);
			horse3.mesh.rotationY = 90;
			horse3.changeAnimationByType(HorseGR.ANIM_RUN);
			//horse3.pushfront = true;
			horse3.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0004);

			horse4.mesh.scale(0.75);
			horse4.mesh.rotationY = 90;
			horse4.changeAnimationByType(HorseGR.ANIM_RUN);
			//horse4.pushfront = true;
			horse4.changeTextureByPart(HorseGR.BODY_SET, HorseGR.TEXBODY_001_0005);
			
			view.scene.addChild(horseContainer);
			horseContainer.addChild(horse.mesh);
			horseContainer.addChild(jockey.mesh);
			
			view.scene.addChild(horseContainer2);
			horseContainer2.addChild(horse2.mesh);
			horseContainer2.addChild(jockey2.mesh);
			
			view.scene.addChild(horseContainer3);
			horseContainer3.addChild(horse3.mesh);
			horseContainer3.addChild(jockey3.mesh);
			
			view.scene.addChild(horseContainer4);
			horseContainer4.addChild(horse4.mesh);
			horseContainer4.addChild(jockey4.mesh);
		}
		private function onJockeyAnimXMLLoaded(evt:JockeyEvent):void{
			jockeyGr.removeOnAnimXMLLoaded(onJockeyAnimXMLLoaded);
			jockey.shadow = false;
			jockey2.shadow = false;
			jockey3.shadow = false;
			jockey4.shadow = false;
			jockey.animation.setFPS(4);
			jockey2.animation.setFPS(4);
			jockey3.animation.setFPS(4);
			jockey4.animation.setFPS(4);
			jockey.mesh.rotationY = 90;
			jockey2.mesh.rotationY = 90;
			jockey3.mesh.rotationY = 90;
			jockey4.mesh.rotationY = 90;
			jockey.mesh.scale(0.75);
			jockey2.mesh.scale(0.75);
			jockey3.mesh.scale(0.75);
			jockey4.mesh.scale(0.75);
			
			jockey.mesh.moveUp(700);
			jockey2.mesh.moveUp(700);
			jockey3.mesh.moveUp(700);
			jockey4.mesh.moveUp(700);
			//jockey5.shadow = false;
			
			jockey.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0002);
			jockey2.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0003);
			jockey3.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0004);
			jockey4.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0005);
			//jockey5.changeTextureByPart(JockeyGR.SKIN_SET, JockeyGR.TEXSKIN_001_0010);
			
			jockey.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0002);
			jockey2.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0003);
			jockey3.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0004);
			jockey4.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0005);
			//jockey5.changeTextureByPart(JockeyGR.TOP_SET, JockeyGR.TEXTOP_001_0003);
			
			jockey.addEquipment(JockeyGR.ACC_SET);
			jockey2.addEquipment(JockeyGR.ACC_SET);
			jockey3.addEquipment(JockeyGR.ACC_SET);
			jockey4.addEquipment(JockeyGR.ACC_SET);
			
			jockey.changeMeshByType(JockeyGR.ACC_SET, JockeyGR.MESHACC_001);
			jockey2.changeMeshByType(JockeyGR.ACC_SET, JockeyGR.MESHACC_002);
			jockey3.changeMeshByType(JockeyGR.ACC_SET, JockeyGR.MESHACC_003);
			jockey4.changeMeshByType(JockeyGR.ACC_SET, JockeyGR.MESHACC_004);
//			jockey3.changeTextureByPart(JockeyGR.ACC_SET, JockeyGR.TEXACC_002_0002);
			
			jockey.addEquipment(JockeyGR.HEAD_SET);
			jockey2.addEquipment(JockeyGR.HEAD_SET);
			jockey3.addEquipment(JockeyGR.HEAD_SET);
			jockey4.addEquipment(JockeyGR.HEAD_SET);
		
			jockey.changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_001);
			jockey2.changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_002);
			jockey3.changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_003);
			jockey4.changeMeshByType(JockeyGR.HEAD_SET, JockeyGR.MESHHEAD_004);
			
			jockey.changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_001_0001);
			jockey2.changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_001_0002);
			jockey3.changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_002_0001);
			jockey4.changeTextureByPart(JockeyGR.HEAD_SET, JockeyGR.TEXHEAD_003_0001);
			
			jockey.changeAnimationByType(JockeyGR.ANIM_RODEO);
			jockey2.changeAnimationByType(JockeyGR.ANIM_RODEO);
			jockey3.changeAnimationByType(JockeyGR.ANIM_RODEO);
			jockey4.changeAnimationByType(JockeyGR.ANIM_RODEO);
		}
		private function initAnimations():void
		{
			horsePathAnimator = new PathAnimator(trackPath, horseContainer, {rotations:rotationPoints, alignToPath:true, offset:new Vector3D(-3000,100,1000), fps:2});
			horsePathAnimator2 = new PathAnimator(trackPath, horseContainer2, {rotations:rotationPoints, alignToPath:true, offset:new Vector3D(-1500,100,1000), fps:2});
			horsePathAnimator3 = new PathAnimator(trackPath, horseContainer3, {rotations:rotationPoints, alignToPath:true, offset:new Vector3D(0,100,1000), fps:2});
			horsePathAnimator4 = new PathAnimator(trackPath, horseContainer4, {rotations:rotationPoints, alignToPath:true, offset:new Vector3D(1500,100,1000), fps:2});
		}
	
		private function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onEnterFrame(event:Event):void
		{
			var pathArray:Array = [horsePathAnimator.progress,horsePathAnimator2.progress,horsePathAnimator3.progress,horsePathAnimator4.progress];
			var ranking:Number;
			var temp:String;
			
			var arrayName:Array = ["horse 1","horse 2","horse 3","horse 4"];
			for(x = 0; x < pathArray.length; x++){
				for(y=0; y< pathArray.length - 1;y++){
					
					if(pathArray[y] < pathArray[y+1]){
						ranking = pathArray[y];
						pathArray[y] = pathArray[y+1];
						pathArray[y+1] = ranking;
						
						temp = arrayName[y];
						arrayName[y] = arrayName[y+1];
						arrayName[y+1] = temp;
					}
				}			
			}

			firstPlaceLabel.text = "1st = " + arrayName[0];
			secondPlaceLabel.text = "2nd = " + arrayName[1];
			thirdPlaceLabel.text = "3rd = " + arrayName[2];
			fourthPlaceLabel.text = "4th = " + arrayName[3];

			if (horsePathAnimator) {
				//trace(horsePathAnimator.progress);
				time += randomRange(0.007);
				horsePathAnimator.update(time);
			}
			if (horsePathAnimator2) {
				time2 += randomRange(0.007);
				horsePathAnimator2.update(time2);
			}
			if (horsePathAnimator3) {
				time3 += randomRange(0.007);
				horsePathAnimator3.update(time3);
			}
			if (horsePathAnimator4) {
				time4 += randomRange(0.007);
				horsePathAnimator4.update(time4);
			}
			if (cameraPathAnimator) {
				time5 += 0.04;
				cameraPathAnimator.update(time5);
			}

			cameraFunction();
			onResize();
			view.render();
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

		private function cameraFunction():void{
			if (move) {
				camera.panAngle = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
				camera.tiltAngle = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;

				if(camera.tiltAngle <= 1){
					camera.tiltAngle = 1;
				}else if(camera.tiltAngle >= 20){
					camera.tiltAngle = 20;
				}
			}
			camera.target = horseContainer;
			camera.hover();
		}
		private function randomRange(max:Number, min:Number = 0.005):Number
		{
			return Math.random() * (max - min) + min;
		}
	}
}