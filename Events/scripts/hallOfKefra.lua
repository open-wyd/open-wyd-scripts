local Env = EnvironmentEvent:new();
-- Sala 1
Env.envId = 1;
Env:setName("Hall de Kefra");
Env.from.x = 2341;
Env.from.y = 3906;
Env.to.x = 2391;
Env.to.y = 3955;
Env.center.x = 2366;
Env.center.y = 3905;
Env:addRespawn("Kefra", 162 , 2366,3931, false );

Env:addRespawn("Guardião de Kefra", 163 , 2365, 3910 );
Env:addRespawn("Lich_Crunt", 165 , 2370, 3910 );

Env:addRespawn("Guardião de Kefra", 163 , 2365, 3940 );
Env:addRespawn("Lich_Crunt", 165 , 2365, 3942 );

Env:addRespawn("Guardião de Kefra", 163 , 2363, 3931 );
Env:addRespawn("Lich_Crunt", 165 , 2364, 3935 );

Env:addRespawn("Guardião de Kefra", 163 , 2375, 3931 );
Env:addRespawn("Lich_Crunt", 165 , 2374, 3935 );

Env:addRespawn("Guardião de Kefra", 163 , 2357, 3924 );
Env:addRespawn("Lich_Crunt", 165 , 2355, 3922 );

Env:addRespawn("Guardião de Kefra", 163 , 2373, 3924 );
Env:addRespawn("Lich_Crunt", 165 , 2372, 3922 );

Env:addRespawn("Guardião de Kefra", 163 , 2358, 3937 );
Env:addRespawn("Lich_Crunt", 165 , 2355, 3938 );

Env:addRespawn("Guardião de Kefra", 163 , 2373, 3935 );
Env:addRespawn("Lich_Crunt", 165 , 2375, 3937 );

Env:addRespawn("Guardião de Kefra", 163 , 2380, 3915);
Env:addRespawn("Lich_Crunt", 165 , 2377, 3917 );

Env:addRespawn("Guardião de Kefra", 163 , 2380, 3946);
Env:addRespawn("Lich_Crunt", 165 , 2377, 3945 );

Env:addRespawn("Guardião de Kefra", 163 , 2346, 3918);
Env:addRespawn("Lich_Crunt", 165 , 2347, 3917 );

Env:addRespawn("Guardião de Kefra", 163 , 2346, 3946);
Env:addRespawn("Lich_Crunt", 165 , 2347, 3948 );

Env:addRespawn("Guardião de Kefra", 163 , 2364, 3948);
Env:addRespawn("Lich_Crunt", 165 , 2365, 3945 );

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
