package com.tada.engine.resource
{
	import com.tada.utils.debug.Logger;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	public class Resource extends EventDispatcher
	{
		public function get filename():String{
			return _filename;
		}
		
		public function set filename(value:String):void{
			if(_filename){
				Logger.warn(this, "set filename", "Can't set a filename of a resource once it has been set");
				return;
			}
		
			_filename = value;
		}
		
		public function get isLoaded():Boolean{
			return _isLoaded;
		}
		
		public function get didFail():Boolean{
			return _didFail;
		}
		
		public function get referenceCount():int{
			return _referenceCount;
		}
		
		protected function get resourceLoader():Loader{
			return _loader;
		}
		
		public function load(filename:String):void{
			_filename = filename;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onDownloadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onDownloadError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onDownloadSecurityError);
			
			var request:URLRequest = new URLRequest();
			request.url = filename;
			loader.load(request);
			
			_urlLoader = loader;
		}
		
		public function initialize(data:*):void{
			if(!(data is ByteArray))
				throw new Error("Default Resource can only process ByteArrays!");
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onDownloadError);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onDownloadSecurityError);
			loader.loadBytes(data);
			
			_loader = loader;
		}
		/**
		 * Increments the number of references to the resource. This should only ever be
		 * called by the ResourceManager.
		 */
		public function incrementReferenceCount():void
		{
			_referenceCount++;
		}
		/**
		 * Disposes resource and cleans data
		 */
		public function dispose():void
		{
			_urlLoader = null;
			_loader = null;
		}
		/**
		 * Decrements the number of references to the resource. This should only ever be
		 * called by the ResourceManager.
		 */
		public function decrementReferenceCount():void
		{
			_referenceCount--;
		}
		/**
		 * This method will be used by a Resource Provider to indicate that this
		 * resource has failed loading
		 */
		public function fail(message:String):void
		{
			onFailed(message);
		}
		/**
		 * This is called when the resource data has been fully loaded and conditioned.
		 * Returning true from this method means the load was successful. False indicates
		 * failure. Subclasses must implement this method.
		 *
		 * @param content The fully conditioned data for this resource.
		 *
		 * @return True if content contains valid data, false otherwise.
		 */
		protected function onContentReady(content:*):Boolean
		{
			return false;
		}
		/**
		 * Called when loading and conditioning of the resource data is complete. This
		 * must be called by, and only by, subclasses that override the initialize
		 * method.
		 *
		 * @param event This can be ignored by subclasses.
		 */
		protected function onLoadComplete(event:Event = null):void
		{
			try
			{
				if (onContentReady(event ? event.target.content : null))
				{
					_isLoaded = true;
					_urlLoader = null;
					_loader = null;
					dispatchEvent(new ResourceEvent(ResourceEvent.LOADED_EVENT, this));
					return;
				}
				else
				{
					onFailed("Got false from onContentReady - the data wasn't accepted.");
					return;
				}
			}
			catch(e:Error)
			{
				Logger.error(this, "Load", "Failed to load! " + e.toString());
			}
			
			onFailed("The resource type does not match the loaded content.");
			return;
		}
		private function onDownloadComplete(event:Event):void
		{
			var data:ByteArray = ((event.target) as URLLoader).data as ByteArray;
			initialize(data);
		}
		
		private function onDownloadError(event:IOErrorEvent):void
		{
			onFailed(event.text);
		}
		
		private function onDownloadSecurityError(event:SecurityErrorEvent):void
		{
			onFailed(event.text);
		}
		protected function onFailed(message:String):void
		{
			_isLoaded = true;
			_didFail = true;
			Logger.error(this, "Load", "Resource " + _filename + " failed to load with error: " + message);
			dispatchEvent(new ResourceEvent(ResourceEvent.FAILED_EVENT, this));
			
			_urlLoader = null;
			_loader = null;
		}
		
		protected var _filename:String = null;
		private var _isLoaded:Boolean = false;
		private var _didFail:Boolean = false;
		private var _urlLoader:URLLoader;
		private var _loader:Loader;
		private var _referenceCount:int = 0;
		
	}
}