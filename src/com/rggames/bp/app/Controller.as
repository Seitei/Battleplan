package com.rggames.bp.app
{
	import com.rggames.bp.net.NetCode;

	public class Controller
	{
		public static const PASS_TURN_ACTION:int = 0;
		public static const PLACE_BUILDING_ACTION:int = 1;
		public static const SET_RALLY_POINT_ACTION:int = 2;
		public static const UPGRADE_BUILDING_ACTION:int = 3;
		
		private static var _instance:Controller;
		private static var _netCode:NetCode;
		
		public static function initNetConnection():void {
			_netCode = NetCode.getInstance();
		}
		
		public static function sendMessage(player:int,action:int,data:Object=null):void
		{
			//Manage net message
			if(!MainStarling.instance.getPlayer(player).remote) {
				_netCode.send(player, action, data);
				processMessage(player, action, data);
			}
		}
		
		//Call this from the net
		public static function receiveMessage(player:int, action:int, data:Object=null):void
		{
			if(MainStarling.instance.getPlayer(player).remote) {
				processMessage(player, action, data);
			}
		}
		
		protected static function processMessage(player:int,action:int,data:Object=null):void
		{
			switch(action)
			{
				case PASS_TURN_ACTION:
					Configs.logs+="\rPASS TURN player "+player+"\r";
					MainStarling.instance.passTurn();
					break;
				case PLACE_BUILDING_ACTION:
					Configs.logs+="\rPLACE "+data.buildingType+" level "+data.level+" IN ("+data.x+","+data.y+") player "+player+"\r";
					MainStarling.instance.placeBuilding(data.buildingType,player,data.level,data.id,data.x,data.y);
					break;
				case SET_RALLY_POINT_ACTION:
					Configs.logs+="\rRALLYPOINTS FOR BUILDING "+data.id+" player "+player+"\r";
					MainStarling.instance.setRallyPoints(data.id,player,data.points);
					break;
			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
}