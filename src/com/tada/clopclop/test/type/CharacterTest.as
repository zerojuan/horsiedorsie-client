package com.tada.clopclop.test.type
{
	import com.away3d.containers.View3D;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	public class CharacterTest extends Sprite
	{
		private var _view:View3D;
		private var _camera:CameraHover;
		private var _jockey:JockeyAsset;
		
		public function CharacterTest()
		{
			if (stage){
				init();
			} else {
				stage.addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		public function init(evt:Event = null):void{
			_view = new View3D({x:250, y:300});
			addChild(_view);
			_camera = new CameraHover(stage);
			_view.camera = _camera;
			_camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);
			_jockey = new JockeyAsset(_view);
			_camera.target = _jockey;
			_jockey.changeAnimationByType(5);
			addListeners();
		}
		
		private function addListeners():void{
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame (evt:Event):void{
			_view.render();
		}
		
		
	}
}