package com.tada.utils
{
	import flash.display.DisplayObjectContainer;

	public class GameUtil
	{
		/**
		 * Removed all the children of the DisplayObjectContainer
		 */
		public static function removeAllChildren(target:DisplayObjectContainer):void{
			while(target.numChildren > 0){
				target.removeChildAt(0);
			}
		}
		
		/**
		 * Converts degrees to radians
		 */
		public static function degreesToRadians(degrees:Number):Number{
			return degrees *= Math.PI / 180;
		}
		
		/**
		 * Converts radians to degrees
		 */
		public static function radiansToDegrees(radians:Number):Number{
			return radians *= 180 / Math.PI;
		}
		
		/**
		 * Clones an array
		 */
		public static function cloneArray(array:Array):Array{
			var newArray:Array = [];
			
			for each(var item:* in array){
				newArray.push(item);
			}
			
			return newArray;
		}
		
		/**
		 * Limits the value v to a min and max number
		 */
		public static function clamp(v:Number, min:Number = 0, max:Number = 1):Number{
			if(v < min) return min;
			if(v > max) return max;
			return v;
		}
		/**
		 * Removes all instances of the specified character from
		 * the beginning and end of the specified string
		 */
		public static function trim(str:String, char:String):String{
			return trimBack(trimFront(str, char), char);
		}
		
		/**
		 * Recursively removes all characters that match the cahr parameter 
		 * starting from the front of the string and working toward te end
		 * until the first character in string does not match char and return
		 * the update string
		 */
		public static function trimFront(str:String, char:String):String{
			char = stringToCharacter(char);
			if(str.charAt(0) == char){
				str = trimFront(str.substring(1), char);
			}
			return str;
		}
		
		/**
		 * Recursively removes all characters that match the cahr parameter 
		 * starting from the back of the string and working toward backward
		 * until the last character in string does not match char and return
		 * the update string
		 */
		public static function trimBack(str:String, char:String):String{
			char = stringToCharacter(char);
			if(str.charAt(str.length - 1) == char){
				str = trimBack(str.substring(0, str.length - 1), char);
			}
			return str;
		}
		
		/**
		 * Convert a string to character
		 */
		public static function stringToCharacter(str:String):String{
			if(str.length == 1){
				return str;
			}
			
			return str.slice(0,1);
		}
	}
}