package com.rggames.bp.world.entities
{
	import com.rggames.bp.app.Configs;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class Entity extends Sprite
	{
		public var dead:Boolean;
		
		protected function setImageByTeam(imageClassA:Class, imageClassB:Class, level:int=1, scale:Number=1, flipBySide:Boolean=true):void
		{
			if(team)
			{
				setImage(imageClassB,scale+scale*(level/Configs.maxLevel),flipBySide);
			}
			else
			{
				setImage(imageClassA,scale+scale*(level/Configs.maxLevel));
			}
		}
		
		
		public function enterFrame(evt:Event):void
		{
			if(dead)
			{
				destroy();
			}
		}
		
		protected function setImage(imageClass:Class, scale:Number=1, flipped:Boolean=false):void
		{
			var img:Image;
			img= new Image(Texture.fromBitmap(new imageClass()));
			if(flipped)
			{
				img.scaleX=-scale;
				img.x=img.width/2;
			}
			else
			{
				img.scaleX=scale;
				img.x=-img.width/2;
			}
			img.scaleY=scale;
			img.y=-img.height/2;
			img.smoothing=TextureSmoothing.TRILINEAR;
			addChild(img);
		}
		
		public var level:int=1;
		public var running:Boolean;
		
		protected var _power:int=1;
		public var cost:int=1;
		
		public var team:int;
		
		public function get power():int
		{
			return _power;
		}

		public function set power(value:int):void
		{
			_power = value;
			if(power<=0)
			{
				dead=true;
			}
		}		
		
		public function start():void
		{
			addEventListener(Event.ENTER_FRAME,enterFrame);
			running=true;
		}
		
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME,enterFrame);
			running=false;
		}
		
		public function Entity()
		{
			super();
		}
		
		public function destroy():void
		{
			stop();
			if(parent)
				parent.removeChild(this);
		}
	}
}