package
{
	import com.greensock.TweenLite;
	import com.tada.clopclop.PlayerGlobalData;
	import com.tada.clopclop.buildables.BuildableFactory;
	import com.tada.clopclop.datamodels.Ranch;
	import com.tada.clopclop.dataproviders.BuildingDataProvider;
	import com.tada.clopclop.dataproviders.CharacterDataProvider;
	import com.tada.clopclop.toolsets.clopclopconnection.ClopClopConnection;
	import com.tada.clopclop.toolsets.facebookconnection.FacebookConnection;
	import com.tada.utils.debug.Logger;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Security;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import mx.core.ByteArrayAsset;

	public class ClopClopPreloader extends MovieClip
	{
		[Embed(source="../lib/preloader.swf", mimeType="application/octet-stream")]
		private var preloaderClass:Class;
		
		private var _loader:Loader;
		private var _byteArray:ByteArrayAsset;
		
		
		private var _preloaderMC:MovieClip;
		
		private var _gameLayer:Sprite;
		private var _preloaderLayer:Sprite;
		
		private var _doneLoadingFrame:Boolean; //Loading frames
		private var _doneLoadingLibs:Boolean; //Loading libraries
		private var _doneLoadingPlayerData:Boolean; //Loading player data
		
		private var _buildingDP:BuildingDataProvider;
		
		private var _characterDP:CharacterDataProvider;
		
		public function ClopClopPreloader(){
			Security.allowDomain("http://clopclopdev.tadaworld.net");			
			setPreloadedText("Loaded preloader");
			stop();
			
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			_gameLayer = new Sprite();
			addChild(_gameLayer);
			
			_preloaderLayer = new Sprite();
			addChild(_preloaderLayer);
			
			_byteArray = new preloaderClass();
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.INIT, preloaderPreloaded, false, 0, true);
			_loader.loadBytes(_byteArray);
									
			var flashVars:Object = LoaderInfo(root.loaderInfo).parameters;
			
			if(flashVars.uid && flashVars.uid !="undefined"){	
				FacebookConnection.instance.init(flashVars.uid, flashVars.uname, flashVars.token);
			}else{				
				FacebookConnection.instance.init("undefined", "Julius", "TOKENANGINAMO");
			}
			
			//Setup player account data
			BuildableFactory.instance.init();
			loadGameData();
		}
		
		private function loadGameData():void{
			setPreloadedText("Loading game data: ");
			_buildingDP = new BuildingDataProvider();
			
			_characterDP = new CharacterDataProvider();
			ClopClopConnection.instance.getItemBaseList(onItemLoaded);
			
			
		}
		
		private function onItemLoaded(res:Array):void{
			setPreloadedText("Loaded Data for Characters");
			_characterDP.init(res);
			ClopClopConnection.instance.getBuildingList(onBuildingListLoaded);
		}
		
		private function onBuildingListLoaded(res:Array):void{
			setPreloadedText("Loaded Data for Buildings");
			_buildingDP.init(res);
			ClopClopConnection.instance.getUser(getCurrentUserInfo);
		}
		
		private function onMyBuildingListResponse(results:Array):void{
			for(var i:int = 0; i < results.length; i++){
				PlayerGlobalData.buildables[i] = BuildableFactory.instance.getMyBuilding(results[i]);							
			}	
			var ranch:Ranch = new Ranch();
			ranch.setShopProvider(_buildingDP);
			ranch.fill(results);
			PlayerGlobalData.ranch = ranch;
			setPreloadedText("Complete loading player data in " + getTimer() / 1000 + "secs.");
			
			_doneLoadingPlayerData = true;
			
			init(); //try if we can start the game now
		}
				
		
		private function libLoadingDone():void{
			_doneLoadingLibs = true;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(evt:Event):void{
			if(framesLoaded == totalFrames){
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				nextFrame();
				_doneLoadingFrame = true;
				_preloaderMC.loadingBarMC.bar.scaleX = 1;
				onFramesLoaded();				
				setPreloadedText("Frame loading finished in " + (getTimer() / 1000) + " secs");
			}else{
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				
				_preloaderMC.loadingBarMC.bar.scaleX = percent;
				if((_preloaderMC.introMC as MovieClip).currentFrame >= 110){
					_preloaderMC.introMC.stop();
				}
			}
		}
		
		private function loadLibraries():void{
			
		}
		
		private function onFramesLoaded():void{
			_preloaderMC.introMC.gotoAndStop(112);
			init();
			//TODO: Do stuff when frames are already loaded
		}
		
		private function preloaderPreloaded(evt:Event):void{
			_preloaderMC = MovieClip(_loader.content);
			_preloaderLayer.addChild(_preloaderMC);
			_preloaderLayer.x = 0;
			_preloaderLayer.y = 0;
			_preloaderMC.stop();
			_preloaderMC.introMC.gotoAndPlay(0);
			_preloaderMC.loadingBarMC.gotoAndPlay(0);
			_preloaderMC.loadingBarMC.bar.scaleX = 1;
			
			setPreloadedText("Preloader loaded in " + (getTimer() / 1000) + " seconds");
			
			//TODO: Add library loading functions
			libLoadingDone();
			
			//setPreloaderText("...");			
		}
		
		private function getCurrentUserInfo(result:Array):void{
			PlayerGlobalData.uid = FacebookConnection.instance.uid;
			PlayerGlobalData.cash = result[0].user_cash;
			PlayerGlobalData.coin = result[0].user_coin;
			PlayerGlobalData.xp = result[0].user_exp;
			PlayerGlobalData.dbId = result[0].user_idx;
			PlayerGlobalData.level = result[0].user_level;
			
			ClopClopConnection.instance.getMyBuilding(onMyBuildingListResponse, PlayerGlobalData.dbId);
		}
		
		
		
		private function init():void{
			trace("DoneLoading Frames: " + _doneLoadingFrame +
					" DoneLoading Libs: " + _doneLoadingLibs +
					" DoneLoadingPlayerData: " + _doneLoadingPlayerData);
			if(_doneLoadingFrame && _doneLoadingLibs && _doneLoadingPlayerData){
				Logger.info(this, "init", "Main initialized in " + (getTimer() / 1000) + " seconds");
				var mainClass:Class = Class(getDefinitionByName("ClopClopMainApp"));
				if(mainClass){
					_preloaderMC.introMC.gotoAndStop(110);
					TweenLite.to(_preloaderMC, 2, {onComplete:function():void{
						_preloaderMC.introMC.gotoAndPlay(110);
						var app:Object = new mainClass();
						_gameLayer.addChild(app as Sprite);
						TweenLite.to(_preloaderMC, .3, {onComplete:removePreloader});
						app.init({buildingDataProvider: _buildingDP, characterDataProvider: _characterDP});
											
					}});
					trace("Initializing main");
					//(app as DisplayObject).addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				}
			}
		}
		
		private function setPreloadedText(str:String):void{
			trace(str);
			Logger.print(this, str);
		}
		
		private function removePreloader():void{
			_preloaderLayer.removeChild(_preloaderMC);
		}				
				
	}
}