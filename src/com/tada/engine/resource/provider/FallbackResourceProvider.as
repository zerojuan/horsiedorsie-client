package com.tada.engine.resource.provider
{
	import com.tada.engine.resource.ImgResource;

	public class FallbackResourceProvider extends BulkLoaderResourceProvider
	{
		/**
		 * The singleton instance of the resource manager.
		 */
		public static function get instance():FallbackResourceProvider
		{
			if (!_instance)
				_instance = new FallbackResourceProvider();
			
			return _instance;
		}
		
		// ------------------------------------------------------------
		// public methods
		// ------------------------------------------------------------
		
		/**
		 * Contructor
		 */ 
		public function FallbackResourceProvider()
		{
			// call the BulkLoaderResourceProvider parent constructor where we
			// specify that this Provider should not be registered as a normal provider.
			super("PBEFallbackProvider",12,false);
		}
		/**
		 * This method will check if this provider has access to a specific Resource
		 */
		public override function isResourceKnown(uri:String, type:Class):Boolean
		{
			// always return true, because this resource provider will load the 
			// resource on the fly, using BulkLoader when it is requested.
			return true;
		}
		
		public override function unloadResource(uri:String, type:Class):void
		{
			// because this resource was dynamicly loaded 'On The Fly'
			// we have to unload it and clean memory
			var resourceIdentifier:String = uri.toLowerCase() + type;			
			if (resources[resourceIdentifier]!=null)
			{
				if (resources[resourceIdentifier] is ImgResource)							
					(resources[resourceIdentifier] as ImgResource).dispose();
				resources[resourceIdentifier] = null;
			}
		}
		
		// ------------------------------------------------------------
		// private and protected variables
		// ------------------------------------------------------------		
		private static var _instance:FallbackResourceProvider = null;				
	}
}