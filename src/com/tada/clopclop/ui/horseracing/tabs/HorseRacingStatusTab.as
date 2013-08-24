package com.tada.clopclop.ui.horseracing.tabs {
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.components.ProgressBarComponent;
	
	import flash.display.DisplayObject;
	
	public class HorseRacingStatusTab extends FrameComponent {
		public static const SPEED_BAR:String = "speedBar";
		public static const STAMINA_BAR:String = "staminaBar";
		public static const STRENGTH_BAR:String = "strengthBar";
		public static const BALANCE_BAR:String = "balanceBar";
		public static const LUCK_BAR:String = "luckBar";
		
		public static const FRIENDSHIP_BAR:String = "friendshipBar";
		public static const ENERGY_BAR:String = "energyBar";
		public static const FEEDING_BAR:String = "feedingBar";
		public static const SHOWER_BAR:String = "showerBar";
		
		public function HorseRacingStatusTab() {
			initStatBars();
			initParamBars();
		}
		
		public function setBarValue(name:String, value:int):void {
			ProgressBarComponent(getComponent(name)).setCurrentValue(value);
		}
		
		public function setAllStats(speed:int = 0, stamina:int = 0, strength:int = 0, balance:int = 0, luck:int = 0):void {
			ProgressBarComponent(getComponent(SPEED_BAR)).setCurrentValue(speed);
			ProgressBarComponent(getComponent(STAMINA_BAR)).setCurrentValue(stamina);
			ProgressBarComponent(getComponent(STRENGTH_BAR)).setCurrentValue(strength);
			ProgressBarComponent(getComponent(BALANCE_BAR)).setCurrentValue(balance);
			ProgressBarComponent(getComponent(LUCK_BAR)).setCurrentValue(luck);
		}
		
		public function setAllParams(friendship:int = 0, energy:int = 0, feeding:int = 0, shower:int = 0):void {
			ProgressBarComponent(getComponent(FRIENDSHIP_BAR)).setCurrentValue(friendship);
			ProgressBarComponent(getComponent(ENERGY_BAR)).setCurrentValue(energy);
			ProgressBarComponent(getComponent(FEEDING_BAR)).setCurrentValue(feeding);
			ProgressBarComponent(getComponent(SHOWER_BAR)).setCurrentValue(shower);
		}
		
		private function initStatBars():void {
			const ICON_X_ADJ:int = 0;
			const BAR_X_ADJ:int = ICON_X_ADJ + 55;
			const Y_ADJ:int = 23;
			const Y_INIT:int = 0;
			const BackClass:Class = GaugeMultiLong;
			const MaskClass:Class = MaskMultiLong;
			const YellowBarClass:Class = BarYellowLong;
			addComponent(SPEED_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 0);
			addComponent(STAMINA_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 1);
			addComponent(STRENGTH_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 2);
			addComponent(BALANCE_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 3);
			addComponent(LUCK_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 4);
			addDisplayObject(new LabelSpeedSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 0);
			addDisplayObject(new LabelStaminaSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 1);
			addDisplayObject(new LabelStrengthSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 2);
			addDisplayObject(new LabelBalanceSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 3);
			addDisplayObject(new LabelLuckSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 4);
		}
		
		private function initParamBars():void {
			const ICON_X_ADJ:int = getComponent(SPEED_BAR).displayObject.x + getComponent(SPEED_BAR).displayObject.width + 45;
			const BAR_X_ADJ:int = ICON_X_ADJ + 25;
			const Y_ADJ:int = 31;
			const Y_INIT:int = 0;
			const BackClass:Class = GaugeMultiLong;
			const MaskClass:Class = MaskMultiLong;
			const RedBarClass:Class = BarRedLong;
			const GreenBarClass:Class = BarGreenLong;
			addComponent(FRIENDSHIP_BAR, new ProgressBarComponent(new BackClass, new RedBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 0);
			addComponent(ENERGY_BAR, new ProgressBarComponent(new BackClass, new GreenBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 1);
			addComponent(FEEDING_BAR, new ProgressBarComponent(new BackClass, new GreenBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 2);
			addComponent(SHOWER_BAR, new ProgressBarComponent(new BackClass, new GreenBarClass, new MaskClass, null, false, 100), BAR_X_ADJ, Y_INIT + Y_ADJ * 3);
			addDisplayObject(new IconParameterHeart, ICON_X_ADJ, Y_INIT + Y_ADJ * 0);
			addDisplayObject(new IconEnergy, ICON_X_ADJ, Y_INIT + Y_ADJ * 1);
			addDisplayObject(new IconFeeding, ICON_X_ADJ, Y_INIT + Y_ADJ * 2);
			addDisplayObject(new IconShower, ICON_X_ADJ, Y_INIT + Y_ADJ * 3);
		}
		
		private function addDisplayObject(object:DisplayObject, X:int, Y:int):void {
			addChild(object);
			object.x = X;
			object.y = Y;
		}
	}
}