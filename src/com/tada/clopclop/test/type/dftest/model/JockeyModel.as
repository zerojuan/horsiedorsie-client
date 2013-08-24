package com.tada.clopclop.test.type.dftest.model
{
	import flash.display.Sprite;

	public class JockeyModel extends Sprite
	{
		private var _acc:int	= 0;
		private var _bottom:int	= 0;
		private var _top:int	= 0;
		private var _shoes:int	= 0;
		
		public function JockeyModel(AccType:int,TopType:int, BottomType:int,ShoesType:int)
		{			
			_acc = Acctype;
			_top = ToptType;
			_bottom = BottomType;
			_shoes = ShoesType;			
		}
		
		public function JockeyPlayer(AccType:int,TopType:int, BottomType:int,ShoesType:int):void{
			
		}
		
	}
}