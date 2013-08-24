package 
{	
	import com.away3d.containers.View3D;
	import com.away3d.core.render.Renderer;
	import com.tada.clopclop.test.type.Camera;
	import com.tada.clopclop.test.type.Horse;
	import com.tada.clopclop.test.type.Jockey;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	
	import flash.display.Sprite;
	import flash.errors.MemoryError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	import flash.system.System;
	import flash.text.TextField;
	
	
	
	public class ClopClop3DTest extends Sprite
	{
		private var _camera:CameraHover;
		private var _horseSample:HorseAsset;
		private var _jockeySample:JockeyAsset;
		private var _horseButton:ButtonMC;
		private var _jockeyButton:ButtonMC;
		private var _cameraButton:ButtonMC;
		
		private var _horseTest:Horse;
		private var _jockeyTest:Jockey;
		private var _cameraTest:Camera;
		
		private var _view3DMain:View3D;
		[SWF(height = "860", width= "700")]
		public function ClopClop3DTest()
		{
			if (stage){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(evt:Event = null):void{
			Security.allowDomain("localhost");
			Security.allowDomain("tadaworld.net");
			Security.allowDomain("clopclopdev.tadaworld.net");
			Security.allowDomain("clopclop.tadaworld.net");
			removeEventListener(Event.ADDED_TO_STAGE,init);
			_view3DMain = new View3D({x:180,y:120});
			_view3DMain.scaleX = .5;
			_view3DMain.scaleY = .5;
			addChild(_view3DMain);
			displayElements();
			addListeners();
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			
		}
		
		private function addListeners():void{
			_horseButton.addEventListener(MouseEvent.CLICK,onMouseClick);
			_jockeyButton.addEventListener(MouseEvent.CLICK,onMouseClick);
			_cameraButton.addEventListener(MouseEvent.CLICK,onMouseClick);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(evt:Event):void{
			_view3DMain.render();	
		}
		
		private function nullSamples():void{
			if (_horseTest && _horseTest != null){
				_horseTest.reset();
				_horseTest.hideHorse();
				removeChild(_horseTest);
				_horseTest = null;
			}
			
			if (_jockeyTest && _jockeyTest != null){
				_jockeyTest.reset();
				_jockeyTest.hideJockey();
				removeChild(_jockeyTest);
				_jockeyTest = null;
			}
			_view3DMain.camera = _camera;
		}
		
		private function onMouseClick(evt:MouseEvent):void{
			switch (evt.target){
				case _horseButton:
					if (_jockeySample != null){
						_jockeySample.setCharacterVisibility(false);
					}
					nullSamples();
					_horseTest = new Horse(_view3DMain,_horseSample);
					addChild(_horseTest);
					_horseTest.showHorse();
					_horseSample.mesh.visible = true;
					_horseSample.setEquipmentsVisible(false);
					_horseTest.x = 50;
					_horseTest.scaleX = .5;
					_horseTest.scaleY = .5;
					//navigateToURL(new URLRequest("http://apps.facebook.com/tadaclopclopdev/"), "_self" );
					_view3DMain.clear();
					break;
				
				case _jockeyButton:
					if ( _jockeySample == null){
						_jockeySample = new JockeyAsset(_view3DMain);
					} else {
						_jockeySample.setSpecificEquipmentVisibility(JockeyAsset.ACC_SET, false);
					}
					nullSamples();
					_horseSample.visible = false;
					_jockeyTest = new Jockey(_view3DMain,_jockeySample);
					addChild(_jockeyTest);
					_jockeyTest.showJockey();
					_jockeySample.setCharacterVisibility(true);
					_jockeySample.setEquipmentsVisible(false);
					_jockeyTest.x = 50;
					_jockeyTest.scaleX = .5;
					_jockeyTest.scaleY = .5;
					_view3DMain.clear();
					break;
				
				case _cameraButton:
					nullSamples();
					_cameraTest = new Camera(_view3DMain, _horseSample);
					addChild (_cameraTest);
					_cameraTest.showCameraTest();
					break;
			}
		}
		
		private function displayElements():void{
			_camera = new CameraHover(stage);
			_camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);
			_horseSample = new HorseAsset(_view3DMain);
			_view3DMain.camera = _camera;
			_view3DMain.renderer = Renderer.CORRECT_Z_ORDER;
			_horseButton = new ButtonMC();
			_jockeyButton = new ButtonMC();
			_cameraButton = new ButtonMC();
			_horseTest = new Horse(_view3DMain,_horseSample);
			_horseTest.showHorse();
			
			addChild(_horseButton);
			addChild(_jockeyButton);
			addChild(_horseTest);
			addChild(_cameraButton);
			
			_horseTest.x = 50;
			_horseTest.scaleX = .5;
			_horseTest.scaleY = .5;
			
			_horseButton.x = 100;
			_horseButton.buttonMCText = new TextField();
			_horseButton.buttonMCText.text = "Horse Test";
			_horseButton.buttonMCText.mouseEnabled = false;
			addChild(_horseButton.buttonMCText);
			_horseButton.buttonMCText.x = 70;
			_horseButton.buttonMCText.y = -8;
			_horseButton.scaleX = .5;
			_horseButton.scaleY = .5;
			
			_jockeyButton.x = 180;
			_jockeyButton.buttonMCText = new TextField();
			_jockeyButton.buttonMCText.text = "Jockey Test";
			_jockeyButton.buttonMCText.mouseEnabled = false;
			addChild(_jockeyButton.buttonMCText);
			_jockeyButton.buttonMCText.x = 150;
			_jockeyButton.buttonMCText.y = -8;
			_jockeyButton.scaleX = .5;
			_jockeyButton.scaleY = .5;
			
			_cameraButton.x = 260;
			_cameraButton.buttonMCText = new TextField();
			_cameraButton.buttonMCText.text = "Camera Test";
			_cameraButton.buttonMCText.mouseEnabled = false;
			addChild(_cameraButton.buttonMCText);
			_cameraButton.buttonMCText.x = 227;
			_cameraButton.buttonMCText.y = -8;
			_cameraButton.scaleX = .5;
			_cameraButton.scaleY = .5;
		}
	}
}