package com.tada.engine.iso
{
	import com.tada.utils.GameUtil;
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class IsoBase
	{										
		protected var gridSprite:Sprite;
		protected var tilegrid:Array = [];
		
		public var cols:int = 10;
		public var rows:int = 10;
		
		//Store these values so 
		//we won't have to calculate them everytime
		private var _sinTheta:Number;
		private var _cosTheta:Number;
		private var _sinAlpha:Number;
		private var _cosAlpha:Number;
		
		public function IsoBase(parent:DisplayObjectContainer)
		{						
			var theta:Number = 24;//30; //45;//35.264; 
			var alpha:Number = 45; //35.264;//45;
			
			
			theta = GameUtil.degreesToRadians(theta);
			alpha = GameUtil.degreesToRadians(alpha);
			
			_sinTheta = Math.sin(theta);
			_cosTheta = Math.cos(theta);
			_sinAlpha = Math.sin(alpha);
			_cosAlpha = Math.cos(alpha);					
		}
		
		/**
		 * Initialize the grid array, the grid will be populated later
		 */
		public function initGrid(cols:int, rows:int):void{
			tilegrid = [];
			Logger.print(this, "Col: " + cols + " Rows: " + rows);
			for(var i:int = 0; i < cols; i++){
				tilegrid[i] = [];
				for(var j:int = 0; j < rows; j++){
					tilegrid[i][j] = "_blank_";
				}
			} 
		}
		
		/**
		 * Take a 3D coordinate and convert it to screen coordinates
		 */
		public function mapToScreen(xpp:Number, ypp:Number, zpp:Number):Coordinate{
			var yp:Number = ypp;
			var xp:Number = xpp*_cosAlpha+zpp*_sinAlpha;
			var zp:Number = zpp*_cosAlpha-xpp*_sinAlpha;
			var x:Number = xp;
			var y:Number = yp*_cosTheta-zp*_sinTheta;
			return new Coordinate(x, y, 0);
		}
		
		/**
		 * Take a screen coordinate and map it into 3D isometric space
		 */
		public function mapToIsoWorld(screenX:Number, screenY:Number):Coordinate{			
			var z:Number = (screenX/_cosAlpha-screenY/(_sinAlpha*_sinTheta))*(1/(_cosAlpha/_sinAlpha+_sinAlpha/_cosAlpha));
			var x:Number = (1/_cosAlpha)*(screenX-z*_sinAlpha);
			return new Coordinate(x, 0, z);			
		}
	}
}