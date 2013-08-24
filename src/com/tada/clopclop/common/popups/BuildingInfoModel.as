package com.tada.clopclop.common.popups
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;

	public class BuildingInfoModel extends Sprite
	{
		private static const DELAY:int = 100;
		private var _buildInfo:BuildInfo;
		
		public var BUILD_TIME:Number
		public var BUILD_PROCESS:Number
		
		private var processInt:uint
		
		public function BuildingInfoModel(build_time:Number,build_process:Number)
		{
			inheritBuildInfo();
			
			_buildInfo.build_time.text = "00:00:05"
			
			setBuildProcess(build_process);
			setBuildTime(build_time);
			
			processInt = setInterval(calculateBuild,1000)
				
		}
		
		
		private function calculateBuild():void 
		{
			var _buildingHolder:Object = parent
			var build:Number = BUILD_PROCESS + 1
			var remain:Number =  BUILD_TIME - BUILD_PROCESS
			setBuildProcess(build)
			
			var percentage:Number = BUILD_PROCESS / BUILD_TIME 
				
				
			_buildInfo.build_time.text = "00:00:0" + remain
				
			setBar(percentage * 100)
			
			if((percentage * 100) == 100) {
				//building is done
				setTimeout(finishBuilding,1500)
			}
			
			
			
		}
		
		private function finishBuilding():void 
		{
			var _buildingHolder:Object = parent
				
			_buildingHolder.changeState("complete");
			_buildingHolder.removeBuildingInfo();				
			clearInterval(processInt)
		}
		
		
		private function setBuildProcess(value:Number):void 
		{
			BUILD_PROCESS = value
		}
		private function setBuildTime(value:Number):void 
		{
			BUILD_TIME = value
		}
		
		public function inheritBuildInfo():void 
		{
			_buildInfo = new BuildInfo();
			_buildInfo.name = "_buildInfo";
			_buildInfo.stop();
			addChild(_buildInfo);
		}
		
		public function setBar(percent:Number):void 
		{
			var _percent:Number = Math.floor( percent );
			if ( _percent > 0 )
			{
				var _timer:Timer = new Timer( DELAY , _percent );
				_timer.addEventListener( TimerEvent.TIMER , onTick , false , 0 , true );
				_timer.start();
			}
		}
		private function onTick(event:TimerEvent):void
		{
			_buildInfo.nextFrame();			
		}
	}
}