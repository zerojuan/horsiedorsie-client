package com.tada.clopclop.ui.textdisplay
{
	public class RatioDisplayer implements ITextDisplayer
	{
		public function getText(value1:int, value2:int):String
		{
			return value1 + "/" + value2;
		}
	}
}