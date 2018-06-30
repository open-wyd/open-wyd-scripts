local spawnList = {N={}, M={}, A={}};
spawnList.N.Soldier = CreateSpawn({pos={x=1308, y=335}, max=20, minGroup=3, maxGroup=5, leader="_p_Chaos_Troll", follower="_p_Chaos_Troll"});
spawnList.N.Boss	= CreateSpawn({pos={x=1308, y=335}, max=1, minGroup=1, leader="_Pesadelo.Erion"});
spawnList.N.Npc 	= CreateSpawn({pos={x=1308, y=335}, max=5, minGroup=1, leader="_p_Cidadao.Erio"});

assert(spawnList.N.Soldier ~= nil or spawnList.N.Boss ~= nil or spawnList.N.Npc ~= nil);

spawnList.M.Soldier = CreateSpawn({pos={x=1151, y=383}, max=30, minGroup=3, maxGroup=5, leader="_p_Moloch", follower="_p_Moloch"});
spawnList.M.Boss	= CreateSpawn({pos={x=1151, y=383}, max=1, minGroup=1, leader="_Pesadelo.Armia"});
spawnList.M.Npc 	= CreateSpawn({pos={x=1151, y=383}, max=5, minGroup=1, leader="_p_Cidadao.Arm"});

assert(spawnList.M.Soldier ~= nil or spawnList.M.Boss ~= nil or spawnList.M.Npc ~= nil);

spawnList.A.Soldier = CreateSpawn({pos={x=1210, y=180}, max=40, minGroup=3, maxGroup=5, leader="_p_Cyclop", follower="_p_Cyclop"});
spawnList.A.Boss	= CreateSpawn({pos={x=1210, y=180}, max=1, minGroup=1, leader="_Pesadelo.Arzam"});
spawnList.A.Npc 	= CreateSpawn({pos={x=1210, y=180}, max=8, minGroup=1, leader="_p_Cidadao.Arza"})

assert(spawnList.A.Soldier ~= nil or spawnList.A.Boss ~= nil or spawnList.A.Npc ~= nil);

local Env = { EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ) };

-- Nightmare N
Env[1].envId = 1;
Env[1]:setName("Pesadelo dos Abitantes de Erion, N");
Env[1].from.x = 1292;
Env[1].from.y = 301;
Env[1].to.x = 1325;
Env[1].to.y = 365;
Env[1].center.x = 1308;
Env[1].center.y = 335;
Env[1]:addSpawn("chaos troll 1", 153, spawnList.N.Soldier, 1305, 354);
Env[1]:addSpawn("npc 1",         154, spawnList.N.Npc,     1305, 354);
Env[1]:addSpawn("chaos troll 2", 153, spawnList.N.Soldier, 1316, 346);
Env[1]:addSpawn("npc 2",         154, spawnList.N.Npc,     1316, 346);
Env[1]:addSpawn("chaos troll 3", 153, spawnList.N.Soldier, 1302, 337);
Env[1]:addSpawn("npc 3",         154, spawnList.N.Npc,     1302, 337);
Env[1]:addSpawn("chaos troll 4", 153, spawnList.N.Soldier, 1313, 329);
Env[1]:addSpawn("npc 4",         154, spawnList.N.Npc,     1313, 329);
Env[1]:addSpawn("chaos troll 5", 153, spawnList.N.Soldier, 1309, 312);
Env[1]:addSpawn("npc 5",         154, spawnList.N.Npc,     1309, 312);
Env[1]:addSpawn("Boss",          155, spawnList.N.Boss,    1308, 335);
-- Nightmare M
Env[2].envId = 2;
Env[2]:setName("Pesadelo dos Abitantes de Armia, M");
Env[2].from.x = 1023;
Env[2].from.y = 256;
Env[2].to.x = 1151;
Env[2].to.y = 383;
Env[2].center.x = 1077;
Env[2].center.y = 308;
Env[2]:addSpawn("moloch 1", 156, spawnList.M.Soldier, 1107, 322);
Env[2]:addSpawn("npc 1",    157, spawnList.M.Npc,     1107, 322);
Env[2]:addSpawn("moloch 2", 156, spawnList.M.Soldier, 1116, 283);
Env[2]:addSpawn("npc 2",    157, spawnList.M.Npc,     1116, 283);
Env[2]:addSpawn("moloch 3", 156, spawnList.M.Soldier, 1090, 320);
Env[2]:addSpawn("npc 3",    157, spawnList.M.Npc,     1090, 320);
Env[2]:addSpawn("moloch 4", 156, spawnList.M.Soldier, 1062, 311);
Env[2]:addSpawn("npc 4",    157, spawnList.M.Npc,     1062, 311);
Env[2]:addSpawn("moloch 5", 156, spawnList.M.Soldier, 1055, 327);
Env[2]:addSpawn("npc 5",    157, spawnList.M.Npc,     1055, 327);
Env[2]:addSpawn("Boss",     158, spawnList.M.Boss,    1077, 308);
-- Nightmare A
Env[3].envId = 3;
Env[3]:setName("Pesadelo dos Abitantes de Arzam, A");
Env[3].from.x = 1158;
Env[3].from.y = 141;
Env[3].to.x = 1271;
Env[3].to.y = 214;
Env[3].center.x = 1210;
Env[3].center.y = 180;
Env[3]:addSpawn("Cyclop 1", 159, spawnList.A.Soldier, 1235, 178);
Env[3]:addSpawn("npc 1",    160, spawnList.A.Npc,     1235, 178);
Env[3]:addSpawn("Cyclop 2", 159, spawnList.A.Soldier, 1220, 178);
Env[3]:addSpawn("npc 2",    160, spawnList.A.Npc,     1220, 178);
Env[3]:addSpawn("Cyclop 3", 159, spawnList.A.Soldier, 1212, 197);
Env[3]:addSpawn("npc 3",    160, spawnList.A.Npc,     1212, 197);
Env[3]:addSpawn("Cyclop 4", 159, spawnList.A.Soldier, 1227, 153);
Env[3]:addSpawn("npc 4",    160, spawnList.A.Npc,     1227, 153);
Env[3]:addSpawn("Cyclop 5", 159, spawnList.A.Soldier, 1209, 157);
Env[3]:addSpawn("npc 5",    160, spawnList.A.Npc,     1209, 157);
Env[3]:addSpawn("Cyclop 6", 159, spawnList.A.Soldier, 1192, 153);
Env[3]:addSpawn("npc 6",    160, spawnList.A.Npc,     1192, 153);
Env[3]:addSpawn("Cyclop 7", 159, spawnList.A.Soldier, 1172, 174);
Env[3]:addSpawn("npc 7",    160, spawnList.A.Npc,     1172, 174);
Env[3]:addSpawn("Cyclop 8", 159, spawnList.A.Soldier, 1185, 194);
Env[3]:addSpawn("npc 8",    160, spawnList.A.Npc,     1172, 174);
Env[3]:addSpawn("boss",     161, spawnList.A.Boss);

local intervalForStart = 5;
local spawns = {{153,154,155}, {156,157,158}, {159,160,161}};
local initBoss = (18*(60*1000));;
local bossTime = {0,0,0};
local spawnUnit = {20, 30, 40}; 
local steps = {{callback = nil, timer = 0}, {callback = nil, timer = 0}, {callback = nil, timer = 0}};
local wtime = 0;

local function finalizeEvent(envId)
	Env[envId]:removeAllPlayer(ResPawnsBasePos);
	Env[envId]:resetNpc();
	Env[envId]:stop();
	bossTime[envId] = 0;
	steps[envId].callback = nil;
end
-- Step 5 - Wait boss died.
local function cb_WaitBossDied(envId)
	-- If boss not is present, then finalize event.
	return (Env[envId]:checkSpawn(spawns[envId][3]) > 0);
end
-- Step 4 - Spawn Boss
local function cb_SpawnBoss(envId)
	Env[envId]:resetNpc();
	Env[envId]:executeSpawn(spawns[envId][3]);
	steps[envId].callback = cb_WaitBossDied;
	return true;
end
-- Step 3 - Defend citizens
local function cb_DefendCitizens(envId)
	if(Env[envId]:checkSpawn(spawns[envId][2]) <= 0) then -- check if exist citizens. 
		return false;
	end

	if(bossTime[envId] < wtime) then
		steps[envId].callback = cb_SpawnBoss;
	else
		if(Env[envId]:checkSpawn(spawns[envId][1]) < spawnUnit[envId]) then
			Env[envId]:executeSpawn(spawns[envId][1]);  -- Respawn soldiers.
		end
	end
	return true;
end
-- Step 2 - First spawn of nightmare soldiers and send the timer.
local function cb_SpawnNightmareSoldiers(envId)
	if(steps[envId].timer < wtime) then
		Env[envId]:executeSpawn(spawns[envId][1]);
		Env[envId]:sendTime(sec_Nightmare, true);
		
		steps[envId].callback = cb_DefendCitizens;
	end
	return true;
end
-- Step 1 - Spawn all Npcs citizens
local function cb_SpawnCitizens(envId)
	if(steps[envId].timer < wtime) then
		Env[envId]:executeSpawn(spawns[envId][2]);
		Env[envId]:sendTime(intervalForStart, true);
		
		steps[envId].callback = cb_SpawnNightmareSoldiers;
		steps[envId].timer = wtime + (intervalForStart * 1000);
	end
	return true;
end

function onExecute(this, envId)
	
	wtime = iGetCurrentTime();
	if(Env[envId]:getTime() <= wtime) then
		return finalizeEvent(envId);
	end
	
	-- If players not is present, then finalize event.
	if(Env[envId]:checkPlayer() <= 0) then 
		return finalizeEvent(envId);
	end
	
	if(steps[envId].callback(envId)) then
		this:addTask(envId);
		return TRUE;
	end
	
	return finalizeEvent(envId);
end

function onAddPlayer(this, envId, player)
	
	if(	Env[envId]:checkPlayer( ) <= 0 ) then
		if( Env[envId]:addGroup( this, player, Env[envId].center ) ) then
			wtime = iGetCurrentTime( );
			Env[envId]:setTime(wtime + nSec_Nightmare);
			Env[envId]:sendTime(intervalForStart, true);
			Env[envId]:start( );
			bossTime[envId] = (wtime + initBoss);
			steps[envId].callback = cb_SpawnCitizens;
			steps[envId].timer = (intervalForStart * 1000);
			this:addTask( envId );
			iSend.ClientMessage(player, "você esta participando do evento \""..Env[envId]:getName( ).."\"");
			return TRUE;
		end
		return FALSE;
	end
	iSend.ClientMessage(player, "este evento já esta sendo realizado, aguarde.");
	return FALSE;
end

function onRemovePlayer(this, envId, player)

	if(Env[envId]:removePlayer(player, ResPawnsBasePos)) then
		return TRUE;
	end
	
	return FALSE;
end

