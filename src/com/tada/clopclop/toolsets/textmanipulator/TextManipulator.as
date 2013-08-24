package com.tada.clopclop.toolsets.textmanipulator
{
	public class TextManipulator
	{
		public function TextManipulator()
		{
		}
		
		public function processHirarchy(myNum:Number):String {
			var hirarchy:String
			
			switch (myNum) {
				case 1 :
					hirarchy = myNum + "st"
					break;
				case 2 :
					hirarchy = myNum + "nd"
					break;
				case 3 :
					hirarchy = myNum + "rd"
					break;
				default :
					hirarchy = myNum + "th"
			}
			
			return hirarchy
		}
	}
}