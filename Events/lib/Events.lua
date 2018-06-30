Time_Sec_OfReset = 10*60;
Time_Nsec_OfReset = (Time_Sec_OfReset-1) * 1000;

-- Variables of water event.
ExitAguaPos = CPosition:new(1966,1769);
ResPawnsBasePos = CPosition:new(0,0);
EndAguaEventSec = 2 * 60;
EndAguaEventNSec = EndAguaEventSec * 1000;

-- Duel event time.
Sec_duelReset = 2 * 60;
NSec_duelReset = Sec_duelReset * 1000;

-- Nightmare time.
sec_Nightmare = (20 * 60);
nSec_Nightmare = (sec_Nightmare*1000) + 2000;


--spawnConfig {
--    pos = {			   <Pos - Configuration of the start position of the spawn.>
--        x=0,             <X - position x of the map>
--        y=0,             <Y - position x of the map>
--        hasWaypoint=false <Waypoint - true if can create default waypoint <default is false.>>
--    },
--    max=1,          <Max - the max of creatures by spawn>
--    minGroup=1,     <MinGroup - the minimum of creatures spawn by turn (interval).>
--    maxGroup=1,     <MaxGroup - the max of creatures spawn by turn (interval), obs.: this value is random, ex math.random(minGroup, maxGroup)> 
--    routeType=2,    <RouteType - type of movement of the spawn, values [1, 2 <default>, 3]>
--    formation=0,    <Formation values [0 <default>, 1, 2]>
--    leader= string, <* Name of leader of the spawn>
--    follower=nil    <Name of follower of the spawn>
--	}
function CreateSpawn(spawnConfig);
	local spawnBuilder = SpawnBuilder:new();
	
	spawnBuilder:setPosition(spawnConfig.pos.x, spawnConfig.pos.y, spawnConfig.pos.hasWaypoint or false);
	
	spawnBuilder:setMax(spawnConfig.max or 1);
	spawnBuilder:setMinGroup(spawnConfig.minGroup or 1);
	if(spawnConfig.maxGroup ~= nil) then
		spawnBuilder:setMaxGroup(spawnConfig.maxGroup);
	else
		spawnBuilder:setMaxGroup(spawnConfig.minGroup or 1);
	end
	
	spawnBuilder:setRouteType(spawnConfig.routeType or 2);
	spawnBuilder:setFormation(spawnConfig.formation or 0);
	
	spawnBuilder:setLeader(spawnConfig.leader);
	
	if(spawnConfig.follower ~= nil) then
		spawnBuilder:setFollower(spawnConfig.follower);
	end
	
	return spawnBuilder:perform();
end
