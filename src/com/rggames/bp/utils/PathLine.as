package com.rggames.bp.utils
{
	import com.rggames.bp.world.entities.buildings.Spawner;
	
	import flash.display.Shape;
	import flash.geom.Point;
	
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class PathLine extends Sprite
	{
		public var lines:Array = new Array();
		
		private var lastP:Point;
		
		public function PathLine()
		{
			super();
			
		}
		
		public function addPoint(p:Point,spawner:Spawner):void
		{
			if(!lastP || Point.distance(lastP,p)>10)
			{
				var line:Quad=new Quad(3,3,spawner.team?0xFF991111:0xFF119911,true);
				line.x=p.x;
				line.y=p.y;
				if(lastP)
				{
					line.width=Point.distance(lastP,p)+1;
					line.rotation=Math.atan2(p.y-lastP.y,p.x-lastP.x)+Math.PI;
				}
				lastP=p;
				addChild(line);
				lines.push(new Point(p.x+spawner.x,p.y+spawner.y));
			}
		}
		
		public function removePoints():void
		{
			removeChildren();
			lastP=null;
			lines=new Array();
		}
	}
}