package com.rggames.bp.world.entities.buildings
{
	import com.rggames.bp.app.Configs;
	import com.rggames.bp.app.MainStarling;
	import com.rggames.bp.world.entities.units.UnitA;
	
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

	public class Spawner1 extends Spawner
	{
		[Embed(source="assets/spawner1.png")]
		private static var imageA:Class;
		
		public function Spawner1(t:int,lvl:int)
		{
			super();
			team=t;
			level=lvl;
			switch(level)
			{
				case 1:
					cost=Configs.unit1Cost1;
					break;
				case 2:
					cost=Configs.unit1Cost2;
					break;
				case 3:
					cost=Configs.unit1Cost3;
					break;
				case 4:
					cost=Configs.unit1Cost4;
					break;
				case 5:
					cost=Configs.unit1Cost5;
					break;
			}
			power*=level;
			addChild(lines);
			setImageByTeam(imageA,imageA,level,.5);
			unitType=UnitA;
		}
	}
}