package com.rggames.bp.world.entities.units
{
	import com.rggames.bp.app.Configs;
	import com.rggames.bp.app.MainStarling;
	import com.rggames.bp.world.entities.Entity;
	import com.rggames.bp.world.entities.buildings.Spawner;
	
	import flash.geom.Point;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Unit extends Entity
	{
		public var spawner:Spawner;
		public var lines:Array;
		private var dir:Point;
		private var target:Point;
		
		public function Unit()
		{
			super();
		}
		
		protected function damageTarget(target:Entity):void
		{
			if(target.dead || dead)return;
			var p1:int=power;
			var p2:int=target.power;
			power-=p2;
			target.power-=p1;
		}
		
		public override function enterFrame(evt:Event):void
		{
			super.enterFrame(evt);
			if(dead)return;
			
			var spd:Number=.5+5.5*(Configs.unitSpeed/10);
			
			if(!target && lines.length>0)
			{
				target=lines.shift();
				
				dir=new Point(target.x-x,target.y-y);
				
				dir.normalize(spd);
			}
			else if(!target && lines.length<=0)
			{
				if(Configs.throneDestination)
				{
					
					dir=new Point((team?MainStarling.instance.playerA.throne.x:MainStarling.instance.playerB.throne.x)-x,(team?MainStarling.instance.playerA.throne.y:MainStarling.instance.playerB.throne.y)-y);
					
					dir.normalize(spd);
				}
				else
				{
					destroy();
					return;
				}
			}
			
			if(target && Point.distance(target, new Point(x,y))<3)
			{
				target=null;
			}
			
			
			x+=dir.x;
			y+=dir.y;
			
			for each(var unit:Entity in UnitManager.getUnits(int(!team)))
			{
				if(!unit.dead && Point.distance(new Point(x,y),new Point(unit.x,unit.y))<20)
				{
					damageTarget(unit);
					break;
				}
			}
			for each(unit in MainStarling.instance.buildings)
			{
				if(unit.team!=team)
				{
					if(!unit.dead && Point.distance(new Point(x,y),new Point(unit.x,unit.y))<40)
					{
						damageTarget(unit);
						break;
					}
				}
			}
			
			unit=team?MainStarling.instance.playerA.throne:MainStarling.instance.playerB.throne;
			
			if(!unit.dead && Point.distance(new Point(x,y),new Point(unit.x,unit.y))<80)
			{
				damageTarget(unit);
			}
		}
		
		public override function destroy():void
		{
			super.destroy();
			spawner.units.splice(spawner.units.indexOf(this),1);
			UnitManager.removeUnit(this);
		}
	}
}