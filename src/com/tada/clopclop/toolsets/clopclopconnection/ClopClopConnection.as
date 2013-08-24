package com.tada.clopclop.toolsets.clopclopconnection
{
	import com.greensock.TweenLite;
	import com.tada.clopclop.toolsets.facebookconnection.FacebookConnection;
	import com.tada.engine.TEngine;
	import com.tada.utils.debug.Logger;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	public class ClopClopConnection
	{
		private static var _instance:ClopClopConnection;
		private static var allowInstantiation:Boolean;
		
		private var conn:NetConnection = new NetConnection();
		private var _facebookConnection:FacebookConnection;
		private var uid:String;
		private var uidx:Number;
		
		public var gatewayURL:String = "http://clopclop.tadaworld.net/clopclop/amfphp/gateway.php";//"http://clopclopdev.tadaworld.net/amfphp/gateway.php"; //"http://clopclop.tadaworld.net/clopclopphpdb/amfphp/gateway.php";
		
		public var COIN:Number
		public var CASH:Number
		public var LEVEL:Number
		public var RANCH_SIZE:Number
		public var CALLER:Object
		public var USER_INFO:Object
		public var USER_LEVEL_INFO:Object
		
		public static function get instance():ClopClopConnection{
			if(!_instance){
				allowInstantiation = true;
				_instance = new ClopClopConnection();
				allowInstantiation = false;
			}
			return _instance;
		}
		
		public function ClopClopConnection(){
			if(!allowInstantiation){
				throw new Error("Trying to instantiate a singleton ClopClopConnection");
			}
							
			uid = FacebookConnection.instance.uid;				
			if(uid == "undefined") {				
				uid = "752846809" //Julius: 752846809 //benj's fb uid  696348997  100001752645158
			}
			Logger.info(this, "ClopClopConnection", "Using " + uid + " as UID");
			conn.connect(gatewayURL);
		}				
		
		//set functions
		public function setMyTiles(callBack:Function, getUserIdx:Number, getBaseIdx:int, getFieldInfo:String):void{
			var responder:Responder = new Responder(callBack);
			Logger.info(this, "setMyTiles", "UserInfo.set_my_build_start>>UID:"+getUserIdx+" BUILD_ID: " + getBaseIdx + " \n\t FIELD_INFO: " + getFieldInfo);
			conn.call("UserInfo.set_my_build_start_Tile", responder, getUserIdx, getBaseIdx, getFieldInfo); //696348997
		}
		
		public function setMyBuilding(callBack:Function, getUserIdx:Number,getIdx:int,getFieldInfo:String):void{
			var responder:Responder = new Responder(callBack);
			Logger.info(this, "setMyBuilding", "UserInfo.set_my_build_start>>UID:"+getUserIdx+" BUILD_ID: " + getIdx + " \n\t FIELD_INFO: " + getFieldInfo);
			conn.call("UserInfo.set_my_build_start", responder, getUserIdx, getIdx, getFieldInfo); //696348997
		}
		
		public function setMyBuildingMove(callBack:Function, userId:Number, buildingId:int, fieldInfo:String, rotation:int):void{
			var responder:Responder = new Responder(callBack);
			Logger.info(this, "setMyBuildingMove", "UserInfo.set_my_build_move>> UID: " + userId + " RANCH_ID: " + buildingId + "\n\t FIELD_INFO: " + fieldInfo + " ROTATION: " + rotation);
			conn.call("UserInfo.set_my_build_move", responder, userId, buildingId, fieldInfo, rotation); //696348997
		} 
		
		public function setMyBuildingSell(callBack:Function, userId:int, buildingId:int):void{
			conn.connect(gatewayURL);
			Logger.info(this, "setMyBuildingSell", "UserInfo.set_my_build_sell>> UID: " + userId + " BUILD_ID: " + buildingId);
			var responder:Responder = new Responder(callBack);
			conn.call("UserInfo.set_my_build_sell", responder, userId, buildingId);					
		}
		
		public function setMyBuildingRotation(callBack:Function, userId:int, buildingId:int, rotation:int):void{
			Logger.debug(this, "setMyBuildingRotation", "UserInfo.set_my_build_rotation>> UID: " + userId + " BUILD_ID: " + buildingId + " ROTATION: " + rotation);
			var responder:Responder = new Responder(callBack);
			conn.call("UserInfo.set_my_build_rotation", responder, userId, buildingId , rotation);
		}
		
		public function setMyBuildingStorage(callBack:Function, userId:int, buildingId:int):void{
			Logger.debug(this, "setMyBuildingStorage", "UserInfo.set_my_build_storage>> UID: " + userId + " BUILD_ID: " + buildingId);
			var responder:Responder = new Responder(callBack);
			conn.call("UserInfo.set_my_build_storage", responder, userId, buildingId);
		}
		
		//get info functions
		public function getUser(callBack:Function):void{
			var responder:Responder = new Responder(callBack);
			conn.call("UserInfo.get_user_info", responder, uid); //696348997		
		}		
		public function getLevel(callBack:Function):void{
			var responder:Responder = new Responder(callBack);							
			conn.call("UserInfo.get_user_level", responder, uid); //696348997			
		}		
		public function getBuildingList(callBack:Function):void{
			var responder:Responder = new Responder(callBack);
			conn.call("UserInfo.get_list_building", responder, null); //696348997					
		}		
		public function getMyBuilding(callBack:Function, userId:Number):void{
			var responder:Responder = new Responder(callBack);
			conn.call("UserInfo.get_my_building", responder, userId); //696348997		
		}
		
		//responder functions
		private function getUserInfo(result:Array):void{			
			USER_INFO = result			
			CALLER.getCurrentUserInfo(USER_INFO)			
		}
		private function getCoinInfo(result:Array):void{			
			COIN = result[0]['user_coin']			
			CALLER.getCurrentValueOfScreenModel("_coin",COIN)
			
		}
		private function getCashInfo(result:Array):void{			
			CASH = result[0]['user_cash']			
			CALLER.getCurrentValueOfScreenModel("_cash",CASH)			
		}
		private function getLevelInfo(result:Array):void{
			var _worldController:Object = CALLER.parent.getChildByName("_worldController")
			LEVEL = result[0]['user_level']
			
			CALLER.getCurrentValueOfScreenModel("_level",LEVEL)
			//_worldController.startTileCreation(LEVEL);
			
		}
		
		private function getUserLevelInfo(result:Array):void{
			
			
			var _worldController:Object = CALLER.parent.getChildByName("_worldController")
			RANCH_SIZE = result[LEVEL-1]['ranch_size']
			
			//CALLER.getCurrentValueOfScreenModel("_level",LEVEL)
			
			_worldController.startTileCreation(RANCH_SIZE);
			
			
			
		}
		
		private function getBuildingListInfo(result:Array):void{

			CALLER.BUILD_LIST = result
		}
		private function getMyBuildingInfo(result:Array):void{
			
			CALLER.MY_BUILDING = result
		}
		// responder set functions
		private function setMyBuildingInfo(result:Array):void{
			
		}
		
		//horse base level ( HORSE LEVEL AND BASIC INFORMATION )
		public function getHorseBaseLevel(callBack:Function):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.get_horse_level", responder, null); 
		}

		//item base list ( ITEM BASIC INFORMATION )
		public function getItemBaseList(callBack:Function):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.get_list_item", responder, null); 
		}

		//my horse list ( USER'S HORSE BASIC INFORMATION )
		public function getMyHorseList(callBack:Function, userId:Number):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.get_my_horse", responder, userId); 
		}

		//my jockey list ( USER'S JOCKEY BASIC INFORMATION )
		public function getMyJockeyList(callBack:Function, userId:Number):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.get_my_jockey", responder, userId); 
		}

		//my hold item ( USER'S ITEM )
		public function getMyHoldItem(callBack:Function, userId:Number):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.get_my_item", responder, userId); 
		}

		//my hold horse item ( USER HORSE'S ITEM )
		public function getMyHoldHorseItem(callBack:Function, userId:Number):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.get_horseholditem", responder, userId); 
		}
		//=> arr[i]["horse_idx"] --> arrMyhorselist[i]["horse_idx"] match
		//=> arr[i]["item_idx"] --> arrMyholditem[i]["item_idx"] match

		//my hold jockey item ( USER JOCKEY'S ITEM )
		public function getMyHoldJockeyItem(callBack:Function, userId:Number):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.get_jockeyholditem", responder, userId); 
		}
		//=> arr[i]["jockey_idx"] --> arrMyjockeylist[i]["jockey_idx"] match
		//=> arr[i]["item_idx"] --> arrMyholditem[i]["item_idx"] match

		//shop buy horse custom ( HORSE CUSTOMIZING AT THE SHOP )
		public function setShopBuyHorseCustom(callBack:Function, userId:Number, horse_idx:int, custom_info:String):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.set_my_horse_customechange", responder, userId, horse_idx, custom_info); 
		}
		//=> custom_info ex :  "2_3_4_"  
		//2 , 3 , 4 .. => item_base_idx	( arrItemBaseList[] )

		//shop buy jockey custom ( JOCKEY CUSTOMIZING AT THE SHOP )
		public function setShopBuyJockeyCustom(callBack:Function, userId:Number, jockey_idx:int, custom_info:String):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.set_my_jockey_customechange", responder, userId, jockey_idx, custom_info); 
		}
		//=> custom_info ex :  "2_3_4_"  
		//2 , 3 , 4 .. => item_base_idx	( arrItemBaseList[] )

		//storage buy horse custom ( HORSE CUSTOMIZING AT THE STORAGE )
		public function setStorageBuyHorseCustom(callBack:Function, userId:Number, horse_idx:int, custom_info:String):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.set_my_horse_storagecustomechange", responder, userId, horse_idx, custom_info); 
		}
		//=> custom_info ex :  "2_3_4_"  
		//2 , 3 , 4 .. => item_idx	( arrItemMyeList[] )

		//storage buy jockey custom ( JOCKEY CUSTOMIZING AT THE STORAGE )
		public function setStorageBuyJockeyCustom(callBack:Function, userId:Number, jockey_idx:int, custom_info:String):void{
			var responder:Responder = new Responder(callBack);
			conn.call("CustomInfo.set_my_jockey_storagecustomechange", responder, userId, jockey_idx, custom_info); 
		}
		//=> custom_info ex :  "2_3_4_"  
		//2 , 3 , 4 .. => item_idx	( arrItemMyeList[] )
	}
}