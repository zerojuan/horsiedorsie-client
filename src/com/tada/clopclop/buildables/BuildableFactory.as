package com.tada.clopclop.buildables
{
	import com.tada.clopclop.events.BuildablesEvent;
	import com.tada.clopclop.toolsets.clopclopconnection.ClopClopConnection;
	import com.tada.clopclop.world.BuildableItem;
	import com.tada.engine.TEngine;
	import com.tada.utils.debug.Logger;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	import com.tada.clopclop.datamodels.Building;

	public class BuildableFactory
	{
		private static var _instance:BuildableFactory;
		private static var _allowInstantiation:Boolean;
		
		private var _buildableArray:Array;
		
		private var _appDomain:ApplicationDomain;
		
		public var isReady:Boolean = false;
		
		public static function get instance():BuildableFactory{
			if(!_instance){
				_allowInstantiation = true;
				_instance = new BuildableFactory();
				_allowInstantiation = false;
			}
			return _instance;
		}
		
		public function BuildableFactory(){
			if(!_allowInstantiation){
				throw new Error("Trying to Initialize a Singleton in BuildableFactory");
			}
			
			_buildableArray = [];
		}
		
		public function init():void{			
			ClopClopConnection.instance.getBuildingList(onBuildingListReply);
		}
		
		public function loadAssets():void{
			Logger.info(this,"loadAssets", "Loading Buildable assets"); 
			var request:URLRequest = new URLRequest("./assets/building.swf");
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoadingComplete);
			loader.load(request);
			
		}
		
		private function onAssetLoadingComplete(evt:Event):void{
			Logger.print(this, "Loaded Buildable assets");
			var loaderInfo:LoaderInfo = LoaderInfo(evt.target);
			_appDomain = loaderInfo.applicationDomain;	
			
			isReady = true;
			TEngine.mainClass.dispatchEvent(new BuildablesEvent(BuildablesEvent.BUILDING_ASSETS_READY)); 
		}
		
		public function getBuildable(id:Number):BuildableItem{			
			var buildableModel:Building = _buildableArray[id] as Building;			
			var buildableItem:BuildableItem = new BuildableItem(buildableModel.mcClass, 0, 0, buildableModel.cols, buildableModel.rows);
			buildableItem.typeId = id;
			buildableItem.sellPrice = buildableModel.sellPrice;
			buildableItem.coinPrice = buildableModel.buyCoinPrice;
			return buildableItem; 			
		}
		
		public function getBuildableModel(id:Number):Building{
			return _buildableArray[id] as Building;
		}
		
		public function getBuildableModelsUsingCategory(type:int):Array{
			var retArr:Array = [];
			for each(var buildable:Building in _buildableArray){
				if(buildable.category == type){
					retArr.push(buildable);
				} 				
			}
			return retArr;
		}
		
		public function getNewBuildableModels():Array{
			var retArr:Array = [];
			for each(var buildable:Building in _buildableArray){
				if(buildable.isNew == 1){
					retArr.push(buildable);
				}				
			}
			return retArr;
		}
		
		public function getMCClass(className:String):Class{
			return _appDomain.getDefinition(className) as Class;
		}
		
		public function getMyBuilding(result:Object):BuildableItem{			
			var buildableItem:BuildableItem = getBuildable(result.build_base_idx);
			
			buildableItem.state = BuildableItem.FUNCTIONAL;
			var arr:Array = (result.field_area as String).split("_");			
			buildableItem.col = arr[0];
			buildableItem.row = arr[1];			
			buildableItem.flipped = (result.rotation != 0);
			buildableItem.worldId = result.build_idx;			
			return buildableItem;
		}
		
		private function onBuildingListReply(results:Array):void{
			Logger.info(this, "onBuildingListReply", "Received " + results.length + " building information ");
			for(var i:int = 0; i < results.length; i++){
				var result:Object = results[i];
				var buildable:Building = new Building();
				buildable.fill(result);				
				
				_buildableArray[buildable.id] = buildable;
			}
		} 
		
	}
}