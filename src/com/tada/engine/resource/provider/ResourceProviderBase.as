package com.tada.engine.resource.provider
{
	import com.tada.engine.resource.Resource;
	
	import flash.utils.Dictionary;

	public class ResourceProviderBase implements IResourceProvider
	{
		public function ResourceProviderBase(){
			// create the Dictionary object that will keep all resources 			
			resources = new Dictionary();
		}
		/**
		 * This method will check if this provider has access to a specific Resource
		 */
		public function isResourceKnown(uri:String, type:Class):Boolean
		{
			var resourceIdentifier:String = uri.toLowerCase() + type;
			return (resources[resourceIdentifier]!=null)
		}
		
		/**
		 * This method will request a resource from this ResourceProvider
		 */
		public function getResource(uri:String, type:Class, forceReload:Boolean = false):Resource
		{
			var resourceIdentifier:String = uri.toLowerCase() + type;
			return resources[resourceIdentifier];
		}
		
		/**
		 * This method will unload a resource from the resources Dictionary
		 */
		public function unloadResource(uri:String, type:Class):void
		{
			var resourceIdentifier:String = uri.toLowerCase() + type;			
			if (resources[resourceIdentifier]!=null)
			{
				resources[resourceIdentifier].dispose();
				resources[resourceIdentifier] = null;
			}
		}
		
		/**
		 * This method will add a resource to the resources Dictionary
		 */
		protected function addResource(uri:String, type:Class, resource:Resource):void
		{
			var resourceIdentifier:String = uri.toLowerCase() + type;
			resources[resourceIdentifier] = resource;        	
		}
		
		// ------------------------------------------------------------
		// private and protected variables
		// ------------------------------------------------------------
		protected var resources:Dictionary;
	}
}