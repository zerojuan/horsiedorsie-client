package com.tada.clopclop.ui.horseinfo.tabs {
	
	import com.tada.clopclop.ui.components.FrameComponent;
	
	public class HorseInfoRaceRecordsTab extends FrameComponent {
		
		public function HorseInfoRaceRecordsTab() {
			addChild(new SkinRaceRecords);
		}
	}
}