package com.rggames.bp.world.entities.buildings
{
	import com.rggames.bp.app.MainStarling;
	import com.rggames.bp.world.entities.Entity;
	
	import starling.display.Sprite;
	
	public class Building extends Entity
	{	
		public var id:int;
		
		public function Building()
		{
			super();
			power=400;
		}
		
		public override function destroy():void
		{
			super.destroy();
			MainStarling.instance.buildings.splice(MainStarling.instance.buildings.indexOf(this),1);
		}
	}
}