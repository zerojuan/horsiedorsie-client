package com.tada.clopclop.ui.horseinfo {
	import com.away3d.containers.View3D;
	import com.tada.clopclop.horseequip.HorseComponent.look.HorseLookPanel;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.ui.UIMainFrame;
	import com.tada.clopclop.ui.horseinfo.frames.HorseInfoTabsFrame;
	import com.tada.clopclop.ui.horseinfo.frames.HorseInfoWinRateFrame;
	import com.tada.clopclop.ui.horseinfo.frames.HorseInforBarsFrame;
	
	public class HorseInformationUI extends UIMainFrame {
		private const HORSE_WINDOW:String = "horseWindow";
		private const INFO_BARS:String = "infoBars";
		private const INFO_TABS:String = "infoTabs";
		private const INFO_RATE:String = "infoRate";
		
		public function HorseInformationUI() {
			super(new SkinFrame, new LabelInformation);
		}
		
		override protected function initObjects():void {
			super.initObjects();
			initHorseView();
			addComponent(INFO_BARS, new HorseInforBarsFrame, 355, 60);
			var infoTabs:HorseInfoTabsFrame = new HorseInfoTabsFrame;
			addComponent(INFO_TABS, infoTabs, (_backgroundDisplay.width / 2) - (infoTabs.width / 2), (_backgroundDisplay.height / 2) + (_backgroundDisplay.height / 4) - (infoTabs.height / 2));
			addComponent(INFO_RATE, new HorseInfoWinRateFrame, 340, 250);
		}
		
		private var _view:View3D;
		private var _horse:HorseAsset;
		private var _camera:CameraHover;
		
		private function initHorseView():void {
			_camera = new CameraHover(stage);
			_camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);
			_camera.fov = 60;
			_view = new View3D;
			_view.camera = _camera;
			_horse = new HorseAsset(_view);
			addComponent(HORSE_WINDOW, new HorseLookPanel(_view), 50, 50);
		}
		
		public function get infoBars():HorseInforBarsFrame {
			return HorseInforBarsFrame(getComponent(INFO_BARS));
		}
		
		public function get infoTabs():HorseInfoTabsFrame {
			return HorseInfoTabsFrame(getComponent(INFO_TABS));
		}
		
		public function get infoRate():HorseInfoWinRateFrame {
			return HorseInfoWinRateFrame(getComponent(INFO_RATE));
		}
		
		public function update():void {
			if (this.parent) {
				_view.render();
			}
		}
	}
}