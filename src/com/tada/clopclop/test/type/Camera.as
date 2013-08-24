package com.tada.clopclop.test.type
{
	import com.away3d.cameras.Camera3D;
	import com.away3d.cameras.lenses.PerspectiveLens;
	import com.away3d.containers.View3D;
	import com.away3d.core.utils.CameraVarsStore;
	import com.away3d.events.CameraEvent;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	
	import flash.display.Sprite;

	public class Camera extends Sprite
	{
		private var _view:View3D;
		private var _horseTest:HorseAsset;
		private var _cameraTest:CameraHover;
		
		public function Camera(view:View3D, horseTest:HorseAsset)
		{
			_view = view;
			_horseTest = horseTest;
		}
		
		public function showCameraTest ():void{
			initDefault();
			initDisplay();
		}
		
		private function initDefault():void{
			_cameraTest = new CameraHover(stage);
			_cameraTest.setCameraPreset(CameraHover.CAMHOVER_DEFAULT);
			_cameraTest.target = _horseTest;
			_cameraTest.x += 400;
			_cameraTest.y += 300;
			_horseTest.mesh.visible = true;
			_view.camera = _cameraTest;
		}
		
		private function initDisplay():void{
			
		}
	}
}