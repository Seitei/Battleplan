package com.rggames.bp.world.entities.buildings
{
	import com.rggames.bp.app.Configs;
	import com.rggames.bp.app.MainStarling;
	import com.rggames.bp.utils.PathLine;
	import com.rggames.bp.world.entities.units.Unit;
	import com.rggames.bp.world.entities.units.UnitManager;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Spawner extends Building
	{
		public var spawnTimer:Timer = new Timer(900);
		
		public var units:Array=new Array();
		
		
		public var lines:PathLine=new PathLine();
		
		public var unitType:Class;
		
		public function Spawner()
		{
			super();
			addEventListener(TouchEvent.TOUCH,mouseMove);
		}
		
		private var processMouse:Boolean=false;
		public function mouseMove(evt:TouchEvent):void
		{
			var touch:Touch=evt.touches[0];
			var px:Number=touch.globalX;
			var py:Number=touch.globalY;
			if(px<MainStarling.instance.map.width && py<MainStarling.instance.map.height)
			{
				switch(touch.phase)
				{
					case TouchPhase.HOVER:
					{
						break;
					}
					case TouchPhase.BEGAN:
					{
						if(processMouse)
						{
							MainStarling.instance.makePathSpawner=this;
						}
						break;
					}
					case TouchPhase.ENDED:
						processMouse=true;
						break;
				}
			}
		}
		
		public override function start():void
		{
			super.start();
			spawnTimer.delay=Configs.spawnDelay;
			spawnTimer.start();
			spawnTimer.addEventListener(TimerEvent.TIMER, spawn);
			removeChild(lines);
		}
		
		public function spawn(evt:Event):void
		{
			if(UnitManager.getUnits(team).length<Configs.maxUnits/2 && ((units.length<Configs.maxUnitsPerSpawn || Configs.maxUnitsPerSpawn==0) ))
			{
				var unit:Unit=new unitType(team,level);
				unit.x=x;
				unit.y=y;
				MainStarling.instance.addChild(unit);
				unit.spawner=this;
				units.push(unit);
				unit.start();
				unit.lines=lines.lines.slice();
				UnitManager.addUnit(unit);
			}
		}
		
		public override function stop():void
		{
			super.stop();
			spawnTimer.stop();
			spawnTimer.reset();
			addChild(lines);
		}
	}
}