package com.tada.clopclop.datamodels
{
	public class Character implements IDBModel
	{
		public var _buff0:Number;
		public var _buff1:Number;
		public var _categoryCharacter:Number;
		public var _categoryEquip:Number;
		public var _categoryGroup:Number;
		public var _equipLevel:Number;
		public var _giftFlag:Number;
		public var _guts:Number;
		public var _horseExp:int;
		public var _itemBase_idx:Number;
		public var _itemBuyCashPrice:Number;
		public var _itemBuyCoinPrice:Number;
		public var _itemGrade:Number;
		public var _itemName:String;
		public var _itemNew:Number;
		public var _itemSell_price:Number;
		public var _limited:Number;
		public var _needBuild:Number;
		public var _needFriendCount:Number;
		public var _needLevel:Number;
		public var _paraClean:Number;
		public var _paraHunger:Number;
		public var _partnership:Number;
		public var _statusBalance:Number;
		public var _statusLuck:Number;
		public var _statusSpeed:Number;
		public var _statusStamina:Number;
		public var _statusStrenght:Number;
		public var _thumbnailUrl:String;
		public var _tradeFlag:String;
		public var _useTime:Number;
		public var _userExp:Number;
		
		public function Character()
		{
			
		}
		public function fill(result:Object):void
		{
		
			_buff0 = result.buff_0;
			_buff1 = result.buff_1;
			_categoryCharacter = result.category_character;
			_categoryEquip = result.category_equip;
			_categoryGroup = result.category_group;
			_equipLevel = result.equip_level;
			_giftFlag = result.gift_flag;
			_guts = result.guts;
			_horseExp = result.horse_exp;
			_itemBase_idx = result.item_base_idx;
			_itemBuyCashPrice = result.item_buy_cash_price;
			_itemBuyCoinPrice = result.item_buy_coin_price;
			_itemGrade = result.item_grade;
			_itemName = result.item_name;
			_itemNew = result.item_new;
			_itemSell_price = result.item_sell_price;					
			_needBuild = result.need_build;
			_needFriendCount = result.need_friendcount;
			_needLevel = result.need_level;
			_paraClean = result.para_clean;
			_paraHunger = result.para_hunger;
			_partnership = result.partnership;
			_statusBalance = result.status_balance;
			_statusLuck = result.status_luck;
			_statusSpeed = result.status_speed;
			_statusStamina = result.status_stamina;
			_statusStrenght = result.status_strenght;
			_thumbnailUrl = result.thumbnail_url;
			_tradeFlag = result.trade_flag;
			_useTime = result.use_time;
			_userExp = result.user_exp;
		}
		
		public function clone():IDBModel
		{
			var cloned:Character = new Character;
			
						
			cloned._buff0 = _buff0;
			cloned._buff1 = _buff1;
			cloned._categoryCharacter = _categoryCharacter;
			cloned._categoryEquip = _categoryEquip;
			cloned._categoryGroup = _categoryGroup;
			cloned._equipLevel = _equipLevel;
			cloned._giftFlag = _giftFlag;
			cloned._guts = _guts;
			cloned._horseExp =_horseExp;
			cloned._itemBase_idx = _itemBase_idx;
			cloned._itemBuyCashPrice = _itemBuyCashPrice;
			cloned._itemBuyCoinPrice = _itemBuyCoinPrice;
			cloned._itemGrade =_itemGrade;
			cloned._itemName = _itemName;
			cloned._itemSell_price = _itemSell_price;	
			cloned._needBuild = _needBuild;
			cloned._needFriendCount = _needFriendCount;
			cloned._needLevel = _needLevel;
			cloned._paraClean =_paraClean;
			cloned._paraHunger = _paraHunger;
			cloned._partnership =_partnership;
			cloned._statusBalance = _statusBalance;
			cloned._statusLuck = _statusLuck;
			cloned._statusSpeed = _statusSpeed;
			cloned._statusStamina = _statusStamina;
			cloned._statusStrenght = _statusStrenght;
			cloned._thumbnailUrl = _thumbnailUrl;
			cloned._tradeFlag = _tradeFlag;
			cloned._useTime = _useTime;
			cloned._userExp =_userExp;
			
			return cloned;
		}
	}
}