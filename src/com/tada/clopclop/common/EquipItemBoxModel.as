package com.tada.clopclop.common
{
	import com.tada.clopclop.declarations.ItemEquipmentDeclaration;
	import com.tada.utils.debug.Logger;
	
	import fl.controls.listClasses.ImageCell;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class EquipItemBoxModel extends Sprite
	{
		private var _itemEquipmentDeclaration:ItemEquipmentDeclaration
		private var _whoEquipmentUI:Object
		private var _who3DView:Object
		private var _depth01Selection:String;  
		private var _depth02Selection:String;
		private var _depth03Selection:String;		
		private var _depthBody:Array = [];		
		private var _depthEquipment:Array = [];
		private var _currentSelection:Array = [];
		private var _depthCurrentSelection:Array = [];
		private var _selectionPosition:Number = 0;
		private var _instanceType:String; 
		private var _arrayIndex:Number = 0
		private var _buyEquip: BuyEquip
		private var _sellEquip:SellEquip		
		private var buyAndSell:Boolean = false
		private var iconSellArray:Array
		private var transactionEquipType:MovieClip = null
		private var transactionEquipTypeAmount:Number =1
		private var transactionEquipTypePrice:Number = 0
		private var buyOrSell:String = null
			
		private var _D1Buttons:Array = [
			"shop",
			"mystorage"
		]
		
		private var _D2Buttons:Array = [
			"newi",
			"body",
			"equipment"
		]
			
		private var _transactions:Array = [
			"buy",
			"sell"
		]
		
		private var _icons:Array = [
			"iconLimited",
			"iconCash",
			"iconCheck",
			"iconHeart",
			"iconMyStorage",
			"iconLock",
			"iconNew",
			"iconShadow"
		]
		
		private var _textBox:Array = [
			"feature1LinerWIcon",
			"feature1Liner",
			"feature21Liner",
			"feature22Liner",
			"coinAmount",
			"cashAmount",
		]
		
		
		//constructor, passed the type of instance to use, the object that calls it,and the 3d view who's connected to it
		public function EquipItemBoxModel(type:String,who:Object,who3D:Object)
		{	
			_instanceType = type;
			_whoEquipmentUI = who;
			_who3DView = who3D;
			
		}
		
		// initialize equip item box model
		public function initEquipItemBoxModel():void
		{
			
			inheritD4ItemButton();
			associateD4ItemButton();
			placeEventListeners();
			updateEquipItemButton();
		}
		
		//set buttons in container
		private function inheritD4ItemButton():void
		{
			for (var i:Number = 0;i < 5;i++)
			{
				var equipItemBox_:D4ItemButton = new D4ItemButton();
				equipItemBox_.name = "equipItemBox_" + i
				addChild(equipItemBox_)
				equipItemBox_.x = i * 100				
				equipItemBox_.itemHolder.mouseChildren = false
				equipItemBox_.itemHolder.mouseEnabled = false
				
			}
		}
		
		//set 3rd depth button associations
		private function associateD4ItemButton():void
		{
			
			switch (_instanceType)
			{
				case "horse" :			
					_depthBody = [
						"mane_Mane_12",
						"eyes_Eye_14",
						"mouth_Mouth_6",
						"pattern_Pattern_0",
						"skin_Skin_8"
						
					];
					_depthEquipment = [
						"head_Head_0",
						"saddle_Saddle_11",
						"bridle_Bridle_16",
						"wings_Wing_1", 
						"accessory_Acc_0"
					];				
					break;
				case "jockey" :
					_depthBody = [
						"hair_Hair_3",
						"eyes_Eye_13",
						"eyebrows_EyeBrow_11",
						"mouth_Mouth_14",
						"skincolor_Skin_3"
					];
					_depthEquipment = [
						"top_Top_19",
						"bottom_Bottom_17",
						"head_Hat_20",
						"shoes_Shoes_3", 
						"accessory_Acc_5"
					];				
					break;
			}
			_depth01Selection = _D1Buttons[0]  
			_depth02Selection = _D2Buttons[0]
			_depth03Selection = ""
			
		}
		
		// set EventListeners
			
		private function placeEventListeners():void
		{
			setEquipItemBoxListener();	
			setD3Listeners(_depthBody);
			setD3Listeners(_depthEquipment);
			setNavigationListeners();
		}
				
		private function setEquipItemBoxListener():void
		{
			for (var h:Number = 0;h <5;h++)
			{
				var _Itemx:Object = (getChildByName("equipItemBox_"+h))					
				_Itemx.addEventListener(MouseEvent.MOUSE_OVER,buttonOver);
				_Itemx.addEventListener(MouseEvent.MOUSE_OUT,buttonOut);
				_Itemx.addEventListener(MouseEvent.CLICK,buttonClick);							
			}	
		}
		
		private function setD3Listeners(a:Array):void
		{
			for (var i:Number = 0;i <a.length;i++)
			{
				var _D3Split:Array = a[i].split("_")
				var _d3button:Object = _whoEquipmentUI.getChildByName(_D3Split[0] + "_sub_2_button")
				_d3button.addEventListener(MouseEvent.CLICK,d3Listeners)
			}
		}
		
		private function setSellListener(target:Object):void
		{			
			target.addEventListener(MouseEvent.CLICK,SellListener)			
		}
		
		private function addTransactionListeners():void
		{
			transactionEquipType.yes.addEventListener(MouseEvent.CLICK,transactionYes);
			transactionEquipType.no.addEventListener(MouseEvent.CLICK,transactionNo);
			transactionEquipType.left.addEventListener(MouseEvent.CLICK,transactionLeft);
			transactionEquipType.right.addEventListener(MouseEvent.CLICK,transactionRight);			
		}
		
		// Work on This
		private function setNavigationListeners():void
		{
			var _Left:Object = _whoEquipmentUI.scrollLeft
			var _Right:Object = _whoEquipmentUI.scrollRight
			_Left.addEventListener(MouseEvent.CLICK,leftListener)
			_Right.addEventListener(MouseEvent.CLICK,rightListener)
		}
		
		//listener functions
		private function leftListener(e:MouseEvent):void
		{
			if (_selectionPosition > 0)
			{
			_selectionPosition --;
			}
		}
		private function rightListener(e:MouseEvent):void
		{
			//if (_selectionPosition < 0)
			//{
				_selectionPosition ++;
			//}
		}
		
		private function buttonOver(e:MouseEvent):void
		{			
			var _Itemx:Object = e.currentTarget.itemHolder.buttonX;
			_Itemx.play();	
			
			trace(_Itemx);
		}
		
		private function buttonOut(e:MouseEvent):void
		{		
			var _Itemx:Object = e.currentTarget.itemHolder.buttonX;			
			_Itemx.gotoAndStop(1);	
			//Logger.print(this, "ButtonOut: " + e.target + " Current Target: " + e.currentTarget);			
		}
		
		private function buttonClick(e:MouseEvent):void
		{
			clearTransactionsButton()
			var _Itemx:Object = e.currentTarget;
			var _Typex:String
			//insert function to call and pass values
			if (_Itemx.active == true)
			{
			//changes 3d image			
			var splitItemIdentifier:Array = _Itemx.itemIdentifier.split("_")
			trace ( splitItemIdentifier[0] + splitItemIdentifier[1] + splitItemIdentifier[2])
			_who3DView.itemEquip(splitItemIdentifier[0],splitItemIdentifier[1],splitItemIdentifier[2])
			//activate transactions button
			if (_depth01Selection == "shop")
				{
					activateTransactionsButton("Buy",e.currentTarget)				
				}
			}
						
		}
		
		public function d1Listeners(e:MouseEvent):void
		{
			var nameSplitter:Array = e.target.name.split("_")			
			var _D3SplitBody:Array = _depthBody[0].split("_")
			switch (nameSplitter[0])
			{
				case "shop":
					_depth01Selection = "shop"
					_depth02Selection = "newi"
					_depth03Selection = ""
					break;
				case "mystorage":
					_depth01Selection = "mystorage"
					_depth02Selection = "body"
					_depth03Selection = _D3SplitBody[0]
					break;
			}
			updateEquipItemButton()				 
		}
		
		public function d2Listeners(e:MouseEvent):void
		{
			var nameSplitter:Array = e.target.name.split("_")
			var _D3SplitBody:Array = _depthBody[0].split("_")
			var _D3SplitEquipment:Array = _depthEquipment[0].split("_")
			switch (nameSplitter[0])
			{
				case "newi":
					_depth02Selection = "newi"
					_depth03Selection = ""
					break;
				case "body":
					_depth02Selection = "body"
					_depth03Selection = _D3SplitBody[0]
					break;
				case "equipment":
					_depth02Selection = "equipment"
					_depth03Selection = _D3SplitEquipment[0]
					break;
			}
			updateEquipItemButton()				 
		}
		
		private function d3Listeners(e:MouseEvent):void
		{
			var nameSplitter:Array = e.target.name.split("_")
			_depth03Selection = nameSplitter[0]
			updateEquipItemButton()			
		}
		
		private function SellListener(e:MouseEvent):void
		{
			var sellButtonName:Object =  e.currentTarget;
			var splitSellButtonName:Array = sellButtonName.name.split("_")
			clearTransactionsButton()
			activateTransactionsButton("Sell",(getChildByName("equipItemBox_"+Number(splitSellButtonName[1]))))
		}
		
		private function transactionYes(e:MouseEvent):void
		{
			
			switch (buyOrSell)
			{
				case "buy":
					Logger.print(this,"purchase " +  transactionEquipType.amount.text)
					break;
				case "sell":
					Logger.print(this,"sold " +  transactionEquipType.amount.text)
					break;
			}
			/*buyItem(transactionEquipTypeAmount);
			deductCoins(transactionEquipTypeAmount)
			deductCash(transactionEquipTypeAmount)*/
			Logger.print(this,"sold " +  transactionEquipType.amount.text)
			clearTransactionsButton()
		}
		private function transactionNo(e:MouseEvent):void
		{			
			trace ("did not purchase anything")
			clearTransactionsButton()
		}
		private function transactionLeft(e:MouseEvent):void
		{
			if (transactionEquipTypeAmount > 1 )			
				transactionEquipTypeAmount --
			var stringAmount:String = String(transactionEquipTypeAmount)
			transactionEquipType.amount.text = stringAmount
			trace (transactionEquipTypeAmount)
		}
		private function transactionRight(e:MouseEvent):void
		{			
			if (transactionEquipTypeAmount < 99 )
				transactionEquipTypeAmount ++
			var stringAmount:String = String(transactionEquipTypeAmount)
			transactionEquipType.amount.text = stringAmount
			trace (transactionEquipTypeAmount)
		}
		
		//remove Listeners
		private function removeTransactionListeners():void
		{
			transactionEquipType.yes.removeEventListener(MouseEvent.CLICK,transactionYes);
			transactionEquipType.no.removeEventListener(MouseEvent.CLICK,transactionNo);
			transactionEquipType.left.removeEventListener(MouseEvent.CLICK,transactionLeft);
			transactionEquipType.right.removeEventListener(MouseEvent.CLICK,transactionRight);	
		}
		
		private function removeSellListener(target:Object):void
		{			
			target.removeEventListener(MouseEvent.CLICK,SellListener)			
		}
	
		// update button content
		private function updateEquipItemButton():void
		{
			clearD4ItemButton();
			setItems();
			
			
		}
		
		private function setItems():void
		{
			var assetName:String =  setAssetName();
			var splitAssetName:Array = assetName.split("_")
			var maxAssets:Number = Number(splitAssetName[3])
			if (Number(splitAssetName[3]) > 5)
			{
				maxAssets = 5
			}
				
			if ((_depth03Selection != null)&&(splitAssetName[3] != "0"))
			{
				for( var h:Number = 0; h < maxAssets;h++)
				{	
					var assetCount:String
					if (h < 10)
					{
						assetCount = "0" + String(h+1)
					}
					else
					{
						assetCount = String(h+1)	
					}
					var targetAssetName:String = splitAssetName[0] + splitAssetName[1]+splitAssetName[2]+ assetCount 
					var imageClass:Class = getDefinitionByName(targetAssetName) as Class
					var imageObject:DisplayObject = new imageClass
					var _Itemx:Object = (getChildByName("equipItemBox_"+h))
					imageObject.name = "_imageObject"
					_Itemx.itemHolder.Image.addChild(imageObject)
					_Itemx.indicator = targetAssetName
					_Itemx.itemIdentifier = splitAssetName[1] + "_" + splitAssetName[2] + "_" + h
					_Itemx.active = true
					
					
				}					
			}
			setIcons();
		}
		
		private function setIcons():void
		{
			for (var c:Number = 0;c <5;c++)
			{
				var _Itemx:Object = getChildByName("equipItemBox_" + c)			
				if(_Itemx.active == true)
				{		
					_Itemx.itemHolder.iconShadow.visible = true
					if (_depth01Selection == "mystorage")
					{
						_Itemx.itemHolder.iconMyStorage.visible = true
						manageIconSell("add",_Itemx)						
					}
					if (_depth02Selection == "newi")
					{
						_Itemx.itemHolder.iconNew.visible = true
					}
				}
			}			
		}
		
		private function setAssetName():String
		{
			var firstIndicator:String
			var secondIndicator:String
			var thirdIndicator:String
			var setIndicator:String
			var firstNameArray:Array = []
			var secondNameArray:Array = []
			var totalNameArray:Array = []
			var numberOfContent:Number =0
			
			switch (_instanceType)
			{
				case "jockey":
					firstIndicator = "J"	
					break;				
				case "horse":
					firstIndicator = "H"
					break;				
			}
			
			switch (_depth02Selection)
			{
				case "newi":
					secondIndicator = ""	
					_depthCurrentSelection = []
					break;				
				case "body":
					secondIndicator = "B"
					_depthCurrentSelection = _depthBody					
					break;				
				case "equipment":
					secondIndicator = "E"
					_depthCurrentSelection = _depthEquipment					
					break;
			}
			for (var i:Number = 0;i< _depthCurrentSelection.length;i++)
			{
				var nameArray:Array = _depthCurrentSelection[i].split("_")
				firstNameArray.push(nameArray[0])
				secondNameArray.push(nameArray[1])
				totalNameArray.push(nameArray[2])
			}
			
			if (secondIndicator != "")
			{
				_arrayIndex = firstNameArray.indexOf(_depth03Selection)
				thirdIndicator =   secondNameArray[_arrayIndex]
				numberOfContent = totalNameArray[_arrayIndex]
			}
			else
			{
				thirdIndicator = ""	
			}
			setIndicator = firstIndicator + "_"+ secondIndicator + "_" + thirdIndicator + "_" + numberOfContent
			return setIndicator
		}
		
		//Clear Buttons
		private function clearD4ItemButton():void
		{
			for (var c:Number = 0;c <5;c++)
			{
				var _Itemx:Object = getChildByName("equipItemBox_" + c)			
					
				manageIconSell("remove",_Itemx)
				
				for (var d:Number = 0;d < _icons.length;d++)
				{
					_Itemx.itemHolder.getChildByName(_icons[d]).visible = false
				}
				for (var e:Number = 0;e < _textBox.length;e++)
				{
					_Itemx.itemHolder.getChildByName(_textBox[e]).visible = false
				}
				if(_Itemx.active == true)
				{					
					_Itemx.itemHolder.Image.removeChild(_Itemx.itemHolder.Image.getChildByName("_imageObject"))
				}
				clearTransactionsButton()
				with(_Itemx){
				indicator = null
				itemIdentifier = null
				active = false
				}	
			}					
		}
		
		//manages Buy and Sell windows
		private function clearTransactionsButton():void
		{
			if (buyAndSell == true)
			{
				removeTransactionListeners();
				removeChild(transactionEquipType)
				buyAndSell = false
			}
		
		}
		
		private function activateTransactionsButton(type:String,button:Object):void
		{			
				var _Itemx:Object = button	
				transactionEquipTypeAmount = 1
				if(_Itemx.active == true)
				{				
				var equipType:Class = getDefinitionByName( type + "Equip")as Class
				transactionEquipType = new equipType as MovieClip
				addChild(transactionEquipType)
				transactionEquipType.x =button.x -53.25
				transactionEquipType.y = -130
				transactionEquipType.price.text = String(transactionEquipTypePrice)
				transactionEquipType.amount.text = String(transactionEquipTypeAmount)				
				buyAndSell = true
				buyOrSell = type				
				addTransactionListeners();				
				
	
				
				}								
		}
		
		//manages the sell Button
		private function manageIconSell(type:String,button:Object):void
		{
			var a:Array = button.name.split("_")
			switch (type)
			{		
				case "add":
					var _iconSell:iconSell = new iconSell
					_iconSell.name = "iconSell_" + a[1]
					addChild(_iconSell)
					_iconSell.x = button.x + 70.30
					_iconSell.y = 65.05
					setSellListener(_iconSell);
					
					break;
				case "remove":
					for (var i:Number = 0; i < 5;i++)
					{
						if (getChildByName("iconSell_" + i) != null)
						{
							var iconToRemove:DisplayObject = DisplayObject(getChildByName("iconSell_" + i))
							removeSellListener(iconToRemove)
							removeChild(iconToRemove)						
						}
					}
					break;
			}
		}

	}
}