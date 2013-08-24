package com.tada.engine.iso
{
	import flash.geom.Point;

	/**
	 * Wrapper class to contain the x,y,z values
	 */
	public class Coordinate
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function Coordinate(x:Number = 0, y:Number = 0, z:Number = 0){
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		/**
		 * Converts the coordinate to x,y point
		 */
		public static function toPoint(coord:Coordinate):Point{
			return new Point(coord.x, coord.y);
		}
		
		public function toString():String{
			return "[" + x.toString() + "," + y.toString() + "," + z.toString() + "]";
		}
	}
}