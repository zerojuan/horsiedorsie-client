package com.tada.utils {
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ChartUtil extends Sprite {		
		private var _stats:Vector.<int> = new Vector.<int>;
		private var _statNames:Vector.<String> = new Vector.<String>;
		private var _statPoints:Vector.<Point> = new Vector.<Point>;
		private var _statPointsFinal:Vector.<Point> = new Vector.<Point>;
		private var _radius:int = 0;
		private const STAT_FINAL:int = 100;
		private var _currentlyTweening:Array = [];
		
		public function ChartUtil(nodes:Array, radius:int = 200, chartImage:Class = null) {
			_radius = radius;
			var nodeCount:int = nodes.length;
			for (var a:int = 0; a < nodes.length; a++) {
				_stats.push(0);
				_statNames.push(nodes[a]);
				_statPoints.push(new Point(0, 0));
				
				var rad:Number = (((360 / nodeCount) * a) - 90) * (Math.PI / 180);
				var point:Point = new Point();
				point.x = radius * Math.cos(rad);
				point.y = radius * Math.sin(rad);
				_statPointsFinal.push(point);
				
				/*var text:TextField = new TextField;
				text.text = nodes[a];
				text.x = point.x;
				text.y = point.y;
				addChild(text);*/
			}
			draw();
		}
		
		public function setStat(stat:String, value:int):void {
			var index:int = _statNames.indexOf(stat);
			if (index >= 0) {
				_stats[index] = value;
				tweenToPoint(_statPoints[index], calculatePoint(_stats[index], _statPointsFinal[index]));
			}
		}
		
		public function getStat(stat:String):int {
			return _stats[_statNames.indexOf(stat)];
			
		}
		
		private function calculatePoint(newValue:int, finalPoint:Point):Point {
			var point:Point = new Point();
			point.x = finalPoint.x * (newValue / STAT_FINAL);
			point.y = finalPoint.y * (newValue / STAT_FINAL);
			return point;
		}
		
		private function tweenToPoint(origPt:Point, destPt:Point):void {
			if (!this.hasEventListener(Event.ENTER_FRAME)) {
				trace("Add listener once...");
				this.addEventListener(Event.ENTER_FRAME, update);
			}
			if (_currentlyTweening.indexOf(origPt) < 0) {
				_currentlyTweening.push(origPt);
			}
			TweenLite.to(origPt, 1, {
				x: destPt.x,
				y: destPt.y,
				onComplete: function():void {
					_currentlyTweening.splice(_currentlyTweening.indexOf(origPt), 1);
				}
			});
		}
		
		private function update(e:Event = null):void {
			if (_currentlyTweening.length > 0) {
				trace("Drawing...");
				draw();
			}
			else {
				if (this.hasEventListener(Event.ENTER_FRAME)) {
					trace("Stopping and removing listener.");
					this.removeEventListener(Event.ENTER_FRAME, update);
				}
			}
		}
		
		private function draw():void {
			graphics.clear();
			/*graphics.beginFill(0x509980);
			graphics.lineStyle(5, 0xFFFFFF, .8);
			graphics.drawCircle(0, 0, _radius);
			graphics.beginFill(0x509980);
			graphics.drawCircle(0, 0, _radius / 2);
			for (var a:int = 0; a < _statPointsFinal.length; a++) {
				graphics.moveTo(0, 0);
				graphics.lineTo(_statPointsFinal[a].x, _statPointsFinal[a].y);
			}*/
			graphics.beginFill(0x0050CC, .7);
			graphics.lineStyle(2.5, 0x000000, 1);
			graphics.moveTo(_statPoints[0].x, _statPoints[0].y);
			for (var a:int = 1; a < _statPoints.length; a++) {
				graphics.lineTo(_statPoints[a].x, _statPoints[a].y);
			}
			graphics.endFill();
		}
	}
}