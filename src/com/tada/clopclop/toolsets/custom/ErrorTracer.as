package com.tada.clopclop.toolsets.custom
{
	import com.tada.utils.debug.Logger;

	public class ErrorTracer
	{
		
		/**
		 * This class is used to call trace error specified. 
		 * 
		 */
		
		private var traceCode:String;
		private var traceDesc:String;
		
		public function ErrorTracer()
		{
			
		}
		
		public static function traceError (errorCode:String):void{
			
			switch (errorCode){
				case "TCC0001":
					Logger.error(ErrorTracer, "traceError", "TCC0001 Error: animation array does not contain any character set");
					break;
				case "TCC0002":
					trace ("TCC0002 Error: The character set is null");
					break;
				case "TCC0003":
					trace ("TCC0003 Error: Not an equipment");
					break;
				case "TCC0004":
					trace ("TCC0004 Error: Asset not yet loaded compeletely");
					break;
				case "TCC0005":
					break;
				case "TCC0006":
					break;
				case "TCC0010":
					trace ("TCC0010 Error: Null stage reference");
					break;
			}
			
		}
	}
}