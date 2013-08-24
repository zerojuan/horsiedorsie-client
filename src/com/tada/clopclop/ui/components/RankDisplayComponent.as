package com.tada.clopclop.ui.components {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class RankDisplayComponent implements IComponent {
		public static const SS:int = 1;
		public static const S:int = 2; 
		public static const A:int = 3;
		public static const B:int = 4;
		public static const C:int = 5;
		public static const D:int = 6;
		
		private var _rank:MovieClip;
		
		public function RankDisplayComponent(rankDisplay:MovieClip, initRank:int = SS) {
			_rank = rankDisplay;
			_rank.gotoAndStop(SS);
		}
		
		public function setRank(rank:int):void {
			_rank.gotoAndStop(rank);
		}
		
		public function addListeners():void {
			
		}
		
		public function removeListeners():void {
			
		}
		
		public function setPosition(X:Number, Y:Number):void {
			_rank.x = X;
			_rank.y = Y;
		}
		
		public function getPosition():Point {
			return new Point(_rank.x, _rank.y);
		}
		
		public function get displayObject():DisplayObject {
			return _rank;
		}
	}
}