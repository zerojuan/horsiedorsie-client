package com.tada.clopclop.toolsets.custom
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	
	/**
	 * Author: Hedrick David
	 * 
	 * The Converter class is a class with static functions 
	 * that can be called upon when you want to convert a specific type of amount
	 * to an equivalent desired output. 
	 */
	
	public class Converter 
	{
		public function Converter()
		{
		}
		
		/**
		 * The amountToSprite converter, converts the amount entered into
		 * an equivalent type of sprite number from the numArray.
		 * 
		 * @param1:amount - set the amount to be converted to its equivalent sprite
		 * @param2:numArray - set the sprite asset of its equivalent numbering from 0 to 9 
		 * respectively into the array 
		 * ex: numArray:Array = [Text00,Text01,Text02,Text03,Text04,Text05,Text06,Text07,Text08,Text09];
		 */
		
		public static function amountToSprite(amount:Number, numArray:Array):Sprite{
			var amountStr:String = String (amount);
			var len:int = amountStr.length;
			var spriteHolder:Sprite = new Sprite();
			var posXOffset:int = 0;
			for (var str:int = 0; str<len;str++){
				for (var item:int = 0; item<numArray.length; item++){
					if (Number(amountStr.charAt(str)) == item){
						var spriteNum:Sprite = new (numArray[item]);
						spriteNum.x = posXOffset;
						posXOffset +=14;
						spriteHolder.addChild(spriteNum);
					}
				}
			}
			return spriteHolder;
		} 
	}
}