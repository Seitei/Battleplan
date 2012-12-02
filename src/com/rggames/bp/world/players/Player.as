package com.rggames.bp.world.players
{
	import com.rggames.bp.net.NetCode;
	import com.rggames.bp.world.entities.buildings.Throne;

	public class Player
	{
		public var resource:int=10;
		public var throne:Throne;
		public var team:int;
		public var moved:Boolean;
		public var remote:Boolean;
		
		public function Player(team:int)
		{
			this.team=team;
			
		}
	}
}