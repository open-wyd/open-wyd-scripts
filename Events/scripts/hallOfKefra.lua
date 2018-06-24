local spawnNames = {"Kefra", "Guardião de Kefra", "Lich_Crunt"};
local kephraSpawn      = SpawnBuilder:new():setPosition(2366, 3905):setMax(1):
							setLeader("hallOfKephra_Kephra"):perform();

local KephraGuardSpawn = SpawnBuilder:new():setPosition(1308, 335):setMax(100):setMinGroup(3):setMaxGroup(3):
							setLeader("hallOfKephra_Kephra_Guard"):setFollower("hallOfKephra_Kephra_Guard"):perform();

local lichCruntSpawn   = SpawnBuilder:new():setPosition(1308, 335):setMax(100):setMinGroup(3):setMaxGroup(3):
							setLeader("hallOfKephra_Hell_Lich"):setFollower("hallOfKephra_Hell_Lich"):perform();

assert(kephraSpawn ~= nil or KephraGuardSpawn ~= nil or lichCruntSpawn ~= nil);

local Env = EnvironmentEvent:new();
Env.envId = 1;
Env:setName("Sala do Kefra");
Env.from.x = 2341;
Env.from.y = 3906;
Env.to.x = 2391;
Env.to.y = 3955;
Env.center.x = 2366;
Env.center.y = 3905;
Env:addSpawn(spawnNames[1], 162, kephraSpawn);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2365, 3910);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2370, 3910);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2365, 3940);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2365, 3942);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2363, 3931);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2364, 3935);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2375, 3931);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2374, 3935);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2357, 3924);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2355, 3922);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2373, 3924);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2372, 3922);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2358, 3937);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2355, 3938);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2373, 3935);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2375, 3937);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2380, 3915);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2377, 3917);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2380, 3946);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2377, 3945);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2346, 3918);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2347, 3917);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2346, 3946);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2347, 3948);
Env:addSpawn(spawnNames[2], 163, KephraGuardSpawn, 2364, 3948);
Env:addSpawn(spawnNames[3], 165, lichCruntSpawn,   2365, 3945);

local run = false;
local lastKephraEnemy = nil;

function bossDie()

	iSend.ClientMessage("O kefra foi derrotado.!");
	iSetGlobalEnvInt64(global_OWS.environmetIdList.HallOfKephraEnvId, 1);
	
	if(lastKephraEnemy == nil or lastKephraEnemy:getPlayer() == nil) then
		return;
	end
	
	iSend.ClientMessage("!"..lastKephraEnemy:getName().." Matou o Kefra.!");
	lastKephraEnemy = nil;
end

function onHit(this, attacker, target, damage)
	if(target:getPhace().itemid == 362) then
		lastKephraEnemy = attacker;
	end
end

function onExecute( this, envId )

	local checkBoss = Env:checkSpawn(162);
	local checkSpawn1 = Env:checkSpawn(163);
	local checkSpawn2 = Env:checkSpawn(164);
	local checkSpawn3 = Env:checkSpawn(165);
	
	if(checkBoss > 0) then
		if(checkSpawn1 < 60) then
			Env:executeSpawn(163);
		end

		if(checkSpawn3 < 60) then
			Env:executeSpawn(165);
		end
		
		this:addTask(envId);
		return TRUE;
	else
		bossDie();
	end
	
	Env:resetNpc( );
	Env:stop( );
	return TRUE;
end

function onAddPlayer(this, envId, player)
	
	if(envId == 2) then
		if( Env:addGroup(this, player, Env.center)) then
			iSend.ClientMessage(player, "você esta participando do evento \""..Env:getName().."\"");
			iLog(player:getName().." -> Entrou no Hall do Kefra");
		else
			return FALSE;
		end
	end
	
	if(run == false) then 
		this:addTask(1);
		Env:start();
		Env:executeSpawn(-1);
		run = true;
	end
	
	return TRUE;
end

function onRemovePlayer(this, envId, player)

	if(Env:removePlayer(player, exitUpLevelPos)) then
		return TRUE;
	end
	
	return FALSE;
end
