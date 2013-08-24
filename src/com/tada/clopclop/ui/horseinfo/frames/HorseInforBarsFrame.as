package com.tada.clopclop.ui.horseinfo.frames {
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.components.LevelDisplayComponent;
	import com.tada.clopclop.ui.components.ProgressBarComponent;
	
	import flash.display.DisplayObject;
	
	public class HorseInforBarsFrame extends FrameComponent {
		private const LEVEL_TEXT:String = "levelText";
		private const LEVEL_BAR:String = "levelBar";
		public static const FRIENDSHIP_BAR:String = "friendshipBar";
		public static const ENERGY_BAR:String = "energyBar";
		public static const FEEDING_BAR:String = "feedingBar";
		public static const SHOWER_BAR:String = "showerBar";
		
		public function HorseInforBarsFrame() {
			initLevelObjects();
			initParamBars();
		}
		
		public function setLevelDisplayValue(value:int):void {
			LevelDisplayComponent(getComponent(LEVEL_TEXT)).setLevel(value);
		}
		
		public function setExpMaxValue(value:int):void {
			ProgressBarComponent(getComponent(LEVEL_BAR)).setMaxValue(value);
		}
		
		public function setExpValue(value:int):void {
			ProgressBarComponent(getComponent(LEVEL_BAR)).setCurrentValue(value);
		}
		
		public function setParamValue(name:String, value:int):void {
			ProgressBarComponent(getComponent(name)).setCurrentValue(value);
		}
		
		public function setAllParams(friendship:int = 0, energy:int = 0, feeding:int = 0, shower:int = 0):void {
			ProgressBarComponent(getComponent(FRIENDSHIP_BAR)).setCurrentValue(friendship);
			ProgressBarComponent(getComponent(ENERGY_BAR)).setCurrentValue(energy);
			ProgressBarComponent(getComponent(FEEDING_BAR)).setCurrentValue(feeding);
			ProgressBarComponent(getComponent(SHOWER_BAR)).setCurrentValue(shower);
		}
		
		private function initLevelObjects():void {
			addComponent(LEVEL_TEXT, new LevelDisplayComponent(new LabelLvl, new LabelGradientBlueDebussy, new LabelGradientBlueDebussy, -5), 5, 0);
			addComponent(LEVEL_BAR, new ProgressBarComponent(new GaugeBlueBig, new BarBlueBig, new MaskBlueBig), 0, 25);
		}
		
		private function initParamBars():void {
			const BAR_X_ADJ:int = 40;
			const ICON_X_ADJ:int = 15;
			const Y_INIT:int = 40; 
			const Y_ADJ:int = 20;
			const BackClass:Class = GaugeMultiLong;
			const MaskClass:Class = MaskMultiLong;
			const RedBarClass:Class = BarRedLong;
			const GreenBarClass:Class = BarGreenLong;
			addComponent(FRIENDSHIP_BAR, new ProgressBarComponent(new BackClass, new RedBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 1);
			addComponent(ENERGY_BAR, new ProgressBarComponent(new BackClass, new GreenBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 2);
			addComponent(FEEDING_BAR, new ProgressBarComponent(new BackClass, new GreenBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 3);
			addComponent(SHOWER_BAR, new ProgressBarComponent(new BackClass, new GreenBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 4);
			addIcon(new IconParameterHeart, ICON_X_ADJ, Y_INIT + Y_ADJ * 1);
			addIcon(new IconEnergy, ICON_X_ADJ, Y_INIT + Y_ADJ * 2);
			addIcon(new IconFeeding, ICON_X_ADJ, Y_INIT + Y_ADJ * 3);
			addIcon(new IconShower, ICON_X_ADJ, Y_INIT + Y_ADJ * 4);
		}
		
		private function addIcon(icon:DisplayObject, X:int, Y:int):void {
			addChild(icon);
			icon.x = X;
			icon.y = Y;
		}
	}
}