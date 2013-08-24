package com.tada.clopclop.ui.horseinfo.tabs {
	
	import com.tada.clopclop.ui.components.FrameComponent;
	import com.tada.clopclop.ui.components.ProgressBarComponent;
	import com.tada.utils.ChartUtil;
	
	import flash.display.DisplayObject;
	
	public class HorseInfoStatusTab extends FrameComponent {
		public static const SPEED_BAR:String = "speedBar";
		public static const STAMINA_BAR:String = "staminaBar";
		public static const STRENGTH_BAR:String = "strengthBar";
		public static const BALANCE_BAR:String = "balanceBar";
		public static const LUCK_BAR:String = "luckBar";
		private var _chart:ChartUtil;
		
		public function HorseInfoStatusTab() {
			addChild(new SkinStatsPieChart);
			_chart = new ChartUtil([SPEED_BAR, STRENGTH_BAR, LUCK_BAR, BALANCE_BAR, STAMINA_BAR], 63);
			_chart.x = 108;
			_chart.y = 82;
			addChild(_chart);
			initStatBars();
		}
		
		public function setStatValue(name:String, value:int):void {
			ProgressBarComponent(getComponent(name)).setCurrentValue(value);
			_chart.setStat(name, value);
		}
		
		public function setAllStats(speed:int = 0, stamina:int = 0, strength:int = 0, balance:int = 0, luck:int = 0):void {
			ProgressBarComponent(getComponent(SPEED_BAR)).setCurrentValue(speed);
			ProgressBarComponent(getComponent(STAMINA_BAR)).setCurrentValue(stamina);
			ProgressBarComponent(getComponent(STRENGTH_BAR)).setCurrentValue(strength);
			ProgressBarComponent(getComponent(BALANCE_BAR)).setCurrentValue(balance);
			ProgressBarComponent(getComponent(LUCK_BAR)).setCurrentValue(luck);
			_chart.setStat(SPEED_BAR, speed);
			_chart.setStat(STAMINA_BAR, stamina);
			_chart.setStat(STRENGTH_BAR, strength);
			_chart.setStat(BALANCE_BAR, balance);
			_chart.setStat(LUCK_BAR, luck);
		}
		
		private function initStatBars():void {
			const ICON_X_ADJ:int = 230;
			const BAR_X_ADJ:int = ICON_X_ADJ + 55;
			const Y_ADJ:int = 25;
			const Y_INIT:int = 20;
			const BackClass:Class = GaugeMultiLong;
			const MaskClass:Class = MaskMultiLong;
			const YellowBarClass:Class = BarYellowLong;
			addComponent(SPEED_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 0);
			addComponent(STAMINA_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 1);
			addComponent(STRENGTH_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 2);
			addComponent(BALANCE_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 3);
			addComponent(LUCK_BAR, new ProgressBarComponent(new BackClass, new YellowBarClass, new MaskClass), BAR_X_ADJ, Y_INIT + Y_ADJ * 4);
			addText(new LabelSpeedSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 0);
			addText(new LabelStaminaSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 1);
			addText(new LabelStrengthSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 2);
			addText(new LabelBalanceSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 3);
			addText(new LabelLuckSmall, ICON_X_ADJ, Y_INIT + Y_ADJ * 4);
		}
		
		private function addText(text:DisplayObject, X:int, Y:int):void {
			addChild(text);
			text.x = X;
			text.y = Y;
		}
	}
}