package com.rggames.bp.world.entities.buildings
{
	import com.rggames.bp.app.Configs;
	import com.rggames.bp.app.MainStarling;
	import com.rggames.bp.world.entities.units.Unit3;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class Spawner3 extends Spawner
	{
		[Embed(source="assets/spawner3.png")]
		private static var imageA:Class;
		
		public function Spawner3(t:int,lvl:int)
		{
			super();
			team=t;
			level=lvl;
			switch(level)
			{
				case 1:
					cost=Configs.unit3Cost1;
					break;
				case 2:
					cost=Configs.unit3Cost2;
					break;
				case 3:
					cost=Configs.unit3Cost3;
					break;
				case 4:
					cost=Configs.unit3Cost4;
					break;
				case 5:
					cost=Configs.unit3Cost5;
					break;
			}
			power*=level;
			addChild(lines);
			setImageByTeam(imageA,imageA,level,.5);
			unitType=Unit3;
		}
	}
}