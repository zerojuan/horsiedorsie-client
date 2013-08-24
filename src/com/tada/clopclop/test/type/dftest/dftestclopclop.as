package com.tada.clopclop.test.type.dftest
{
	import com.away3d.cameras.HoverCamera3D;
	import com.away3d.containers.ObjectContainer3D;
	import com.away3d.containers.View3D;
	import com.away3d.core.base.Object3D;
	import com.tada.clopclop.ClopClopMainController;
	import com.tada.clopclop.horseequip.HorseEquipController;
	import com.tada.clopclop.horseequip.HorseEquipView;
	import com.tada.clopclop.jockeyequip.JockeyEquipController;
	import com.tada.clopclop.jockeyequip.JockeyEquipView;
	import com.tada.clopclop.test.type.Jockey;
	import com.tada.clopclop.toolsets.camera.CameraHover;
	import com.tada.clopclop.toolsets.character.horse.HorseAsset;
	import com.tada.clopclop.toolsets.character.jockey.JockeyAsset;
	import com.tada.clopclop.toolsets.character.jockey.sets.main.JockeySkinSet;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	[SWF(height = "860", width= "700")]	
	
	public class dftestclopclop extends Sprite
	{			
		private var _view:MovieClip = new MovieClip;
		
		private var JEquip:EquipJockey;
		private var HEquip:dfhorseEquip;
		
		
		private var ring:EquipRotateMouseOver;
		
		private var txtHead:TextField 	= new TextField;
		private var txtAcc:TextField 	= new TextField;
		private var txtEye:TextField	= new TextField;
		private var txtBottom:TextField = new TextField;
		private var txtShoes:TextField	= new TextField;
		private var txtSkins:TextField	= new TextField;
		private var txtEyeBrow:TextField= new TextField;
		private var txtMouth:TextField	= new TextField;
		
		private var ctr:int = 0;
		
		private var horse:HorseAsset;		
		private var jockey:JockeyAsset;		
		
		private var group1:ObjectContainer3D = new ObjectContainer3D;
		// HoverCam controls	
		private var view:View3D;
		private var camera:CameraHover;
		
		
		private var JEquipView:HorseEquipView;
		
		
		private var mesh:ObjectContainer3D;
		private var _horseEquipView:HorseEquipView;
		private var _jockeyEquipView:JockeyEquipView;
		//end hover		
				
		
		
		public function dftestclopclop()
		{			
			if (stage){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE , init);
			}			
		}
		
		public function init(evt:Event = null):void{
			
			
			//create a 3D-viewport
			addChild(txtHead);
			addChild(txtAcc);
			addChild(txtBottom);
			addChild(txtShoes);
			
			addChild(txtEye);
			addChild(txtSkins);
			addChild(txtEyeBrow);
			addChild(txtMouth);
			
			
			txtHead.text 	= "Custom Head";
			txtAcc.text		= "Custom Acc";
			txtAcc.y	= 30;
			txtBottom.text = "Custom Bottom"
			txtBottom.y = 60;
			txtShoes.text = "Custom Shoes"
			txtShoes.y = 90;
			
			txtEye.text = "Custom Eye";
			txtEye.y		= 160;
			
			txtEyeBrow.text = "EyeBrow";
			txtEyeBrow.y	= 190;
				
			txtSkins.text = "Custom Skin";
			txtSkins.y = 400;	
				
			txtMouth.text = "Custom Mouth";
			txtMouth.y = 220;
				
			addChild(_view)			
			view = new View3D;//({x:100, y:100});		
			
			
			//addChild(view);
			 //view movie clip type
			camera = new CameraHover(stage);
			view.camera = camera;				
			camera.setCameraPreset(CameraHover.CAMHOVER_MOUSEDRIVEN);						
			
			//camera.tiltAngle = 0;
			//camera.panAngle = 0;
			
			_horseEquipView = new HorseEquipView();			
			_horseEquipView.name = "_horseEquipView";
			_view.addChild(_horseEquipView);
			_horseEquipView.initHorseEquipView();
			_horseEquipView.visibility(true);		
			
			/*
			_jockeyEquipView = new JockeyEquipView();
			_jockeyEquipView.name = "_jockeyEquipView";
			_view.addChild(_jockeyEquipView);
			_jockeyEquipView.initJockeyEquipView();	
			_jockeyEquipView.visibility(true);
		
			_view.addChild(view);			
			JEquip = new EquipJockey(view);		
			
			*/
			_view.addChild(view);			
			HEquip = new dfhorseEquip(view);	
			
			view.camera.zoom =3;
			view.camera.focus = 200;
						
			ring = new EquipRotateMouseOver;	
			
			_horseEquipView.addChild(ring);				
			//_jockeyEquipView.addChild(ring);			
			
			ring.x = view.x - 50;
			ring.y = view.y;
			
			addListeners();	
		}	
		
		private function addListeners():void{
			
			//test button for customization
			
			addEventListener(Event.ENTER_FRAME, onEnter);
			txtHead.addEventListener(MouseEvent.CLICK, onClickHead);
			txtAcc.addEventListener(MouseEvent.CLICK, onClickAcc);
			txtBottom.addEventListener(MouseEvent.CLICK, onClickBottom);
			txtShoes.addEventListener(MouseEvent.CLICK, onClickShoes);
			
			txtEye.addEventListener(MouseEvent.CLICK, onClickEye);
			txtEyeBrow.addEventListener(MouseEvent.CLICK, onClickEyeBrow);
			txtSkins.addEventListener(MouseEvent.CLICK, onClickSkin);
			txtMouth.addEventListener(MouseEvent.CLICK, onClickMouth);
			
		}
		
		private function onClickHead(e:MouseEvent):void{
			var BE:String = "E";
			var part:String = "Acc";
			var type:int = 0;
			
			JEquip.JockeyEquip(BE, part, type);			
		}
		
		private function onClickAcc(e:MouseEvent):void{	
			var BE:String = "E";
			var part:String = "Top";
			var type:int = ctr;	
			
			ctr++
				if(ctr <= 14){
					JEquip.JockeyEquip(BE, part, type);
				}
				else
					ctr = 0;
		}
		
		private function onClickBottom(e:MouseEvent):void{	
			var BE:String = "E";
			var part:String = "Bottom";
			var type:int = ctr;	
			
			ctr++
			if(ctr <= 16){
				JEquip.JockeyEquip(BE, part, type);
			}
			else
				ctr = 0;
		}
		
		private function onClickShoes(e:MouseEvent):void{	
			var BE:String = "E";
			var part:String = "Shoes";
			var type:int = ctr;	
			
			ctr++
			if(ctr <= 2){
				JEquip.JockeyEquip(BE, part, type);
			}
			else
				ctr = 0;
		}
		
		private function onClickEye(e:MouseEvent):void{
			var BE:String = "B";
			var part:String = "Eye";
			var type:int = ctr;	
			
			ctr++
			if(ctr <= 12){
				JEquip.JockeyEquip(BE, part, type);
			}
			else
				ctr = 0;
		}
		
		private function onClickEyeBrow(e:MouseEvent):void{
			trace("Eyebrow");
			
			var BE:String = "B";
			var part:String = "EyeBrow";
			var type:int = ctr;	
			
			ctr++
			if(ctr <= 10){
				JEquip.JockeyEquip(BE, part, type);
			}
			else
				ctr = 0;
		}
		
		private function onClickSkin(e:MouseEvent):void{
			var BE:String = "B";
			var part:String = "Skin";
			var type:int = ctr;	
			
			ctr++
			if(ctr <= 2){
				JEquip.JockeyEquip(BE, part, type);
			}
			else
				ctr = 0;
		}
		
		private function onClickMouth(e:MouseEvent):void{
			var BE:String = "B";
			var part:String = "Mouth";
			var type:int = ctr;	
			
			ctr++
			if(ctr <= 13){
				JEquip.JockeyEquip(BE, part, type);
			}
			else
				ctr = 0;
		}
		
		private function onEnter(e:Event):void{		
			// re-render viewport
			view.render();					
		}
	}
}