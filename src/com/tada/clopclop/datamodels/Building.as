package com.tada.clopclop.datamodels
{
	import com.tada.clopclop.Constants;
	import com.tada.utils.debug.Logger;

	public class Building implements IDBModel
	{		
		public static const BUILDINGS:int = 0;
		public static const TILES:int = 1;
		public static const GARDENING:int = 2;
		public static const FENCES:int = 3;
		public static const STRUCTRURE:int = 4;
		public static const DECORATION:int = 5;
		
		public static const UNDER_CONSTRUCTION:String = "underConstruction";
		public static const NON_BOUGHT:String = "unBought";
		public static const FUNCTIONAL:String = "functional";
		public static const REDECORATING:String  = "redecorating";
		
		public var id:Number;		
		public var category:Number;
		public var buildName:String;
		public var sellPrice:Number;
		public var buyCoinPrice:Number;
		public var buyCashPrice:Number;
		public var isNew:int;
		public var levelRequirement:int;
		public var friendCountRequirement:int;
		public var cashPrice:int;
		public var buildTime:Number;
		public var content:String;
		
		public var state:String;
		
		public var thumbnailURL:String;
		public var mcClass:String;
		
		public var cols:int;
		public var rows:int;
		
		public var ranchId:Number;
		public var col:int;
		public var row:int;
		public var flipped:Boolean;
		
		public function getCurrency():String{
			if(buyCoinPrice == -1){
				if(buyCashPrice == -1){
					return null;
				}else{
					return Constants.CASH; 
				}
			}
			return Constants.COIN;
		}
		
		public function getPrice():int{
			if(getCurrency() == Constants.CASH){
				return buyCashPrice;
			}else if(getCurrency() == Constants.COIN){
				return buyCoinPrice;
			}
			return -1;
		}
		
		public function fill(obj:Object):void{						
			id = obj.build_base_idx;
			buyCashPrice = obj.build_buy_cash_price;
			buyCoinPrice = obj.build_buy_coin_price;
			buildName = obj.build_name;
			sellPrice = obj.build_sell_price;
			buildTime = obj.build_time;
			category = obj.category;
			content = obj.content;
			friendCountRequirement = obj.friend_count;
			cols = obj.w_size;
			rows = obj.h_size;
			isNew = obj.item_new;
			cashPrice = obj.lock_cash_prize;
			mcClass = obj.mc_url;
			thumbnailURL = obj.thumbnail_url;
			levelRequirement = obj.user_level;
		}
		
		public function clone():IDBModel{
			var cloned:Building = new Building();
			cloned.id = id;
			cloned.cols = cols;
			cloned.rows = rows;
			cloned.mcClass = mcClass;
			cloned.thumbnailURL = thumbnailURL;
			cloned.cashPrice = cashPrice;
			cloned.buyCashPrice = buyCashPrice;
			cloned.buyCoinPrice = buyCoinPrice;
			cloned.buildName = buildName;
			cloned.sellPrice = sellPrice;
			cloned.category = category;
			cloned.buildTime = buildTime;
			return cloned;
		}
				
	}
}