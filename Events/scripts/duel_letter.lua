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
Env[1]:addRespawn( "Chaos Orc", 124 , 0,0 );
Env[1]:addRespawn( "Froggy Knight", 125 , 0,0 );
Env[1]:addRespawn( "War Taurus", 126 , 0,0 );
-- Sala 2
Env[2].envId = 2;
Env[2]:setName("Quarto Secreto, nivel 2");
Env[2].from.x = 836;
Env[2].from.y = 3654;
Env[2].to.x = 885;
Env[2].to.y = 3696;
Env[2].center.x = 844;
Env[2].center.y = 3687;
Env[2]:addRespawn( "Elf Berserker", 127 , 0,0 );
Env[2]:addRespawn( "Undead Skeleton", 128 , 0,0 );
Env[2]:addRespawn( "Chaos Cyclop", 129 , 0,0 );
-- Sala 3
Env[3].envId = 3;
Env[3]:setName("Quarto Secreto, nivel 3");
Env[3].from.x = 836;
Env[3].from.y = 3597;
Env[3].to.x = 885;
Env[3].to.y = 3640;
Env[3].center.x = 843;
Env[3].center.y = 3632;
Env[3]:addRespawn( "Wild Ghoul", 130 , 0,0 );
Env[3]:addRespawn( "Dark Stone Golem", 131 , 0,0 );
Env[3]:addRespawn( "Blue Hydra", 132 , 0,0 );
-- Sala 4
Env[4].envId = 4;
Env[4]:setName("Quarto Secreto, nivel 4-Boss");
Env[4].from.x = 779;
Env[4].from.y = 3596;
Env[4].to.x = 829;
Env[4].to.y = 3646;
Env[4].center.x = 785;
Env[4].center.y = 3639;
Env[4]:addRespawn( "Wild Taurus 1", 133 , 800,3607 );
Env[4]:addRespawn( "Wild Taurus 2", 133 , 816,3607 );
Env[4]:addRespawn( "Wild Taurus 3", 133 , 796,3630 );
Env[4]:addRespawn( "Wild Taurus 4", 133 , 820,3630 );
Env[4]:addRespawn( "Cruel Zakum", 134 , 0,0 );

Env[4]:addRespawn( "Guard Grymlock 1", 135 , 800,3607 );
Env[4]:addRespawn( "Guard Grymlock 2", 135 , 816,3607 );
Env[4]:addRespawn( "Guard Grymlock 3", 135 , 796,3630 );
Env[4]:addRespawn( "Guard Grymlock 4", 135 , 820,3630 );
Env[4]:addRespawn( "Wise Gargoyle King ", 136 , 0,0 );

Env[4]:addRespawn( "Undead Hell Chief 1", 137 , 800,3607 );
Env[4]:addRespawn( "Undead Hell Chief 2", 137 , 816,3607 );
Env[4]:addRespawn( "Undead Hell Chief 3", 137 , 796,3630 );
Env[4]:addRespawn( "Undead Hell Chief 4", 137 , 820,3630 );
Env[4]:addRespawn( "Rujeper Broken King", 138 , 0,0 );

local envSpawn = { {124,127,130,133,134}, {125,128,131,135,136}, {126,129,132,137,138} };
local eventMode = 0;
local start = false;
local chekTime = 0;

function onExecute( this, envId )
	
	if ( envId > 4 ) then
		iLog("[duel_letter::onExecute]: unknow envId: "..envId);
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
			
			this:nextEnvId( Env[envId], Env[nextEnvId] );
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
