package com.tada.clopclop
{
	import com.tada.clopclop.datamodels.Ranch;

	/**
	 * Contains general game data about the user
	 */
	public class PlayerGlobalData
	{
		public static var cash:Number;
		public static var coin:Number;
		public static var xp:Number;
		public static var level:Number;
		public static var dbId:Number;
		public static var uid:String;
		
		public static var buildables:Array = [];
		
		public static var ranch:Ranch;
	}
}