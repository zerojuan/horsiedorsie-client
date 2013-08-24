package com.tada.clopclop.toolsets.precisehittest
{
	//
	//PreciseHitTest v.100
	//
	//Description:Evaluates if an object hits the precise object's area.
	//Not its bounding box but it's within and not transparent.
	//
	//Company:BENJWorks
	//Developer:Benj Borcena
	//
	
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	//import flash.utils.*;
	
	
	public class PreciseHitTest  
	{
		public function testHitting(mc1:Sprite,mc2:Sprite,mcAlpha:Number,CALLER:Object):Rectangle {
			// set up default params:
			mcAlpha = 255;
			
			// get bounds:
			
			var bound1:Object = mc1.getRect(CALLER.root);
			var bound2:Object = mc2.getRect(CALLER.root);
			
			// rule out anything that we know can't collide:
						
			if (mc1.hitTestObject(mc2) == true) {
				
				
				
				// determine test area boundaries:
				var myBound:Object = {};
				
				myBound.x = Math.max(bound1.x,bound2.x);
				myBound.width = Math.min(bound1.width,bound2.width);
				myBound.y = Math.max(bound1.y,bound2.y);
				myBound.height = Math.min(bound1.height,bound2.height);
				//trace("\n")
				//trace("x="+myBound.x +", "+"y="+myBound.y+", "+"H="+myBound.height+", "+"W="+myBound.width);
				//trace("x="+bound2.x +", "+"y="+bound2.y+", "+"H="+bound2.height+", "+"W="+bound2.width);
				
				
				
				// set up the image to use:
				
				var myImage:BitmapData = new BitmapData(myBound.width,myBound.height);
				
				// draw in the first image:
				var myMatrix:Matrix = mc1.transform.concatenatedMatrix;
				//trace(myMatrix)
				myMatrix.tx -= myBound.x;
				myMatrix.ty -= myBound.y;
				myImage.draw(mc1,myMatrix, new ColorTransform(1,1,1,1,255,-255,-255,mcAlpha));
				
				// overlay the second image:
				myMatrix = mc2.transform.concatenatedMatrix;
				myMatrix.tx -= myBound.x;
				myMatrix.ty -= myBound.y;
				myImage.draw(mc2,myMatrix, new ColorTransform(2,1,1,1,255,255,255,mcAlpha),"difference");
				
				// find the intersection:
				var precise:Rectangle = myImage.getColorBoundsRect(0xFFFFFFFF,0xFF00FFFF);
				//trace("BOO"+precise.width)
				
				// if there is no intersection, return null:
				if (precise.width == 0) {
					return null;
				} else {
					precise.x += myBound.x;
					precise.y += myBound.y;
					
					return precise;
				}
			}
			
			
			return null;
			
			
		}
		
		
		
	}
}