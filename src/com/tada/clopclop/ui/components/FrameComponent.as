package com.tada.clopclop.ui.components
{
	import com.tada.utils.debug.Logger;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class FrameComponent extends Sprite implements IComponent {
		[ArrayElementType("IComponent")]
		protected var _componentArray:Array = [];
		
		public function FrameComponent() {
			
		}
		
		public function addComponent(name:String, component:IComponent, X:Number = 0, Y:Number = 0):void {
			if (!_componentArray[name]) {
				_componentArray[name] = component;
				this.addChild(_componentArray[name].displayObject);
				_componentArray[name].setPosition(X, Y);
				if (this.parent) {
					_componentArray[name].addListeners();
				}
				Logger.print(this, "Component " + name + " has been added!");
			}
			else {
				Logger.error(this, "addComponent", "Component with the name " + name + " already exists!");
			}
		}
		
		public function removeComponent(name:String):void {
			if (_componentArray[name]) {
				if (_componentArray[name].displayObject.parent) {
					_componentArray[name].displayObject.parent.removeChild(_componentArray[name].displayObject);
					_componentArray[name].removeListeners();
				}
				_componentArray[name] = null;
				delete _componentArray[name];
				Logger.print(this, "Component " + name + " has been removed!");
			}
			else {
				Logger.error(this, "removeComponent", "Could not find component with the name " + name + "!");
			}
		}
		
		public function showComponent(name:String):void {
			if (_componentArray[name]) {
				if (!_componentArray[name].displayObject.parent) {
					this.addChild(_componentArray[name].displayObject);
					if (this.parent) {
						_componentArray[name].addListeners();
					}
				}
			}
			else {
				Logger.error(this, "showComponent", "Could not find component with the name " + name + "!");
			}
		}
		
		public function hideComponent(name:String):void {
			if (_componentArray[name]) {
				if (_componentArray[name].displayObject.parent) {
					_componentArray[name].displayObject.parent.removeChild(_componentArray[name].displayObject);
					_componentArray[name].removeListeners();
				}
			}
			else {
				Logger.error(this, "hideComponent", "Could not find component with the name " + name + "!");
			}
		}
		
		public function getComponent(name:String):IComponent {
			if (_componentArray[name]) {
				return _componentArray[name];
			}
			else {
				Logger.error(this, "getComponent", "Could not find component with the name " + name + "!");
			}
			return null;
		}
		
		public function addListeners():void {
			for (var name:String in _componentArray) {
				if (_componentArray[name].displayObject.parent) {
					_componentArray[name].addListeners();
				}
			}
		}
		
		public function removeListeners():void {
			for (var name:String in _componentArray) {
				_componentArray[name].removeListeners();
			}
		}
		
		public function getPosition():Point {
			return new Point(this.x, this.y);
		}
		
		public function setPosition(X:Number, Y:Number):void {
			this.x = X;
			this.y = Y;
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
	}
}