package 
{
	
	import com.tada.clopclop.ClopClopMainController;
	import com.tada.engine.TEngine;
	import com.tada.engine.resource.provider.BulkLoaderResourceProvider;
	
	import flash.display.Sprite;
	import flash.system.Security;
	

	[SWF(height = '700', width = '760', frameRate="30")]
	[Frame(factoryClass="ClopClopPreloader")]
	public class ClopClopMainApp extends Sprite 
	{					
		private var _clopClopMainController:ClopClopMainController				
		
		public function ClopClopMainApp(){
			Security.allowDomain("http://clopclopdev.tadaworld.net");
			Security.allowDomain('http://profile.ak.fbcdn.net');
			Security.allowDomain('https://profile.ak.fbcdn.net');
			
			name = "MainSprite";			
			//init();
		}
		
		public function init(params:Object):void{
			//Initialize the GameEngine
			TEngine.startup(this);
			
			//Initialize resource manager
			TEngine.resourceManager.registerResourceProvider(new BulkLoaderResourceProvider("BulkResourceProvider"));
			
			
			initClopClopMainController(params);						
		}				
		
		private function initClopClopMainController(params:Object):void{
			
			_clopClopMainController = new ClopClopMainController(this);			
			_clopClopMainController.startClopClopMainController(params.buildingDataProvider, params.characterDataProvider);						
		}
		
	}
}