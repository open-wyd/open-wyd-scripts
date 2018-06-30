local spawnList = {};
spawnList[124] = CreateSpawn({pos={x=808, y=3678, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_Chaos_Orc", follower="duelLetter_Chaos_Orc"});
spawnList[125] = CreateSpawn({pos={x=808, y=3678, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_Froggy_Knight", follower="duelLetter_Froggy_Knight"});
spawnList[126] = CreateSpawn({pos={x=808, y=3678, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_War_Taurs", follower="duelLetter_War_Taurs"});

spawnList[127] = CreateSpawn({pos={x=865, y=3678, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_Elf_Berserker", follower="duelLetter_Elf_Berserker"});
spawnList[128] = CreateSpawn({pos={x=865, y=3678, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_U._Skeleton", follower="duelLetter_U._Skeleton"});
spawnList[129] = CreateSpawn({pos={x=865, y=3678, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_Chaos_Cyclop", follower="duelLetter_Chaos_Cyclop"});

spawnList[130] = CreateSpawn({pos={x=865, y=3623, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_Wild_Ghoul", follower="duelLetter_Wild_Ghoul"});
spawnList[131] = CreateSpawn({pos={x=865, y=3623, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_Dark.S.Golem", follower="duelLetter_Dark.S.Golem"});
spawnList[132] = CreateSpawn({pos={x=865, y=3623, hasWaypoint=true}, max=50, minGroup=50, leader="duelLetter_Blue_Hydra", follower="duelLetter_Blue_Hydra"});

spawnList[133] = CreateSpawn({pos={x=800, y=3607}, max=100, minGroup=4, leader="duelLetter_Wild_Taurus", follower="duelLetter_Wild_Taurus"});
spawnList[134] = CreateSpawn({pos={x=807, y=3620, hasWaypoint=true}, max=1, minGroup=1, leader="duelLetter_Cruel_Zakum"});

spawnList[135] = CreateSpawn({pos={x=800, y=3607}, max=100, minGroup=4, leader="duelLetter_Guard_G._lock", follower="duelLetter_Guard_G._lock"});
spawnList[136] = CreateSpawn({pos={x=807, y=3620, hasWaypoint=true}, max=1, minGroup=1, leader="duelLetter_W._Gargoyle_K"});

spawnList[137] = CreateSpawn({pos={x=800, y=3607}, max=100, minGroup=4, leader="duelLetter_U.Hell_Chief", follower="duelLetter_U.Hell_Chief"});
spawnList[138] = CreateSpawn({pos={x=807, y=3620, hasWaypoint=true}, max=1, minGroup=1, leader="duelLetter_Rujeper_B._K"});

for key, value in pairs(spawnList) do
	assert(value ~= nil, "Error on create SpawnId: "..key);
end

local Env = { EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ) };
local exitUpLevelPos = CPosition:new(0,0);
-- Sala 1
Env[1].envId = 1;
Env[1]:setName("Quarto Secreto, nivel 1");
Env[1].from.x = 779;
Env[1].from.y = 3654;
Env[1].to.x = 826;
Env[1].to.y = 3696;
Env[1].center.x = 785;
Env[1].center.y = 3687;
Env[1]:addSpawn("Chaos Orc",     124, spawnList[124]);
Env[1]:addSpawn("Froggy Knight", 125, spawnList[125]);
Env[1]:addSpawn("War Taurus",    126, spawnList[126]);
-- Sala 2
Env[2].envId = 2;
Env[2]:setName("Quarto Secreto, nivel 2");
Env[2].from.x = 836;
Env[2].from.y = 3654;
Env[2].to.x = 885;
Env[2].to.y = 3696;
Env[2].center.x = 844;
Env[2].center.y = 3687;
Env[2]:addSpawn( "Elf Berserker",   127, spawnList[127]);
Env[2]:addSpawn( "Undead Skeleton", 128, spawnList[128]);
Env[2]:addSpawn( "Chaos Cyclop",    129, spawnList[129]);
-- Sala 3
Env[3].envId = 3;
Env[3]:setName("Quarto Secreto, nivel 3");
Env[3].from.x = 836;
Env[3].from.y = 3597;
Env[3].to.x = 885;
Env[3].to.y = 3640;
Env[3].center.x = 843;
Env[3].center.y = 3632;
Env[3]:addSpawn( "Wild Ghoul",       130, spawnList[130]);
Env[3]:addSpawn( "Dark Stone Golem", 131, spawnList[131]);
Env[3]:addSpawn( "Blue Hydra",       132, spawnList[132]);
-- Sala 4
Env[4].envId = 4;
Env[4]:setName("Quarto Secreto, nivel 4-Boss");
Env[4].from.x = 779;
Env[4].from.y = 3596;
Env[4].to.x = 829;
Env[4].to.y = 3646;
Env[4].center.x = 785;
Env[4].center.y = 3639;
Env[4]:addSpawn( "Wild Taurus 1", 133, spawnList[133], 800, 3607);
Env[4]:addSpawn( "Wild Taurus 2", 133, spawnList[133], 816, 3607);
Env[4]:addSpawn( "Wild Taurus 3", 133, spawnList[133], 796, 3630);
Env[4]:addSpawn( "Wild Taurus 4", 133, spawnList[133], 820, 3630);
Env[4]:addSpawn( "Cruel Zakum",   134, spawnList[134]);

Env[4]:addSpawn( "Guard Grymlock 1",    135, spawnList[135], 800, 3607);
Env[4]:addSpawn( "Guard Grymlock 2",    135, spawnList[135], 816, 3607);
Env[4]:addSpawn( "Guard Grymlock 3",    135, spawnList[135], 796, 3630);
Env[4]:addSpawn( "Guard Grymlock 4",    135, spawnList[135], 820, 3630);
Env[4]:addSpawn( "Wise Gargoyle King ", 136, spawnList[136]);

Env[4]:addSpawn( "Undead Hell Chief 1", 137, spawnList[137], 800, 3607);
Env[4]:addSpawn( "Undead Hell Chief 2", 137, spawnList[137], 816, 3607);
Env[4]:addSpawn( "Undead Hell Chief 3", 137, spawnList[137], 796, 3630);
Env[4]:addSpawn( "Undead Hell Chief 4", 137, spawnList[137], 820, 3630);
Env[4]:addSpawn( "Rujeper Broken King", 138, spawnList[138]);

local envSpawn = { {124,127,130,133,134}, {125,128,131,135,136}, {126,129,132,137,138} };
local eventMode = 0;
local start = false;
local chekTime = 0;

function onExecute( this, envId )
	
	if ( envId > 4 ) then
		iLog("[duel_letter:onExecute]: unknow envId: "..envId);
		return LUA_ERROR;
	end
	
	local wtime = iGetCurrentTime( );
	local checkPlayer = Env[envId]:checkPlayer( );
	local checkSpawn;
	if( envId > 3 ) then
		checkSpawn = Env[envId]:checkSpawn( -1 );
	else
		checkSpawn = Env[envId]:checkSpawn( envSpawn[eventMode][envId] );
	end
	
	if( checkPlayer <= 0 ) then
		Env[envId]:resetNpc( );
	elseif( checkSpawn <= 0 ) then
		if( envId <= 3 ) then
			local nextEnvId = envId+1;
			if( envId == 3 ) then
				--local roomid = ((wtime-chekTime/1000)/60);
				--if( roomid <= 4 ) then
					Env[4]:executeSpawn( envSpawn[eventMode][5] );
				--end
				Env[4]:executeSpawn( envSpawn[eventMode][4] );
			else
				Env[nextEnvId]:executeSpawn( envSpawn[eventMode][nextEnvId] );
			end
			
			-- Debug
			if(Env.owner:getLevel() > 1000) then
				iSend.Say(Env.owner, "nextEnvId: "..nextEnvId.." - envId+1: "..envId+1);
			end
			
			this:nextEnv( Env[envId], Env[nextEnvId] );
			this:addTask(nextEnvId);

			Env[nextEnvId]:setTime( (wtime+NSec_duelReset) );
			Env[nextEnvId]:sendTime( Sec_duelReset, true );
			
			return TRUE;
			
		elseif( Env[envId]:getTime( ) < wtime ) then
			if ( checkPlayer > 0 ) then
				Env[envId]:removeAllPlayer( exitUpLevelPos );
			end
		else
			this:addTask( envId );
			return TRUE;
		end
		
	elseif( Env[envId]:getTime( ) < wtime or Env.owner == nil ) then -- CHECK TIME FOR STOP EVENT
		if ( checkPlayer > 0 ) then 
			Env[envId]:removeAllPlayer( exitUpLevelPos );
		end
		Env[envId]:resetNpc( );
	else
        this:addTask( envId );
		return TRUE;
	end
	
	eventMode = 0;
	start = false;
	Env.owner = nil;
	return TRUE;
end

function onAddPlayer(this, envId, player)
	
	if(start == true or eventMode ~= 0) then
		iSend.ClientMessage(player, "Aguarde o evento \""..Env[1]:getName( ).."\" terminar.");
		return FALSE;
	end
	
	Env.owner = player;
	eventMode = envId;
	
	Env[1]:executeSpawn( envSpawn[eventMode][1] );
	chekTime = iGetCurrentTime( );
	Env[1]:setTime(chekTime+NSec_duelReset);
	
	if(Env[1]:addGroup(this, player, Env[1].center )) then
		iSend.ClientMessage(player, "você esta participando do evento \""..Env[1]:getName( ).."\"");
		Env[1]:sendTime( Sec_duelReset, true );
		start = true;
		this:addTask( 1 );
		return TRUE;
	end
	
	eventMode = 0;
	Env[1]:resetNpc( );
	return FALSE;
end

function onRemovePlayer( this, envId, player )

	if(Env.owner == player) then
		Env.owner = nil;
	end
	
	if(Env[envId]:removePlayer(player, exitUpLevelPos) == false) then
		return FALSE;
	end
	
	return TRUE;
end
