local Env = { EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ) };

-- Pesadelo 1
Env[1].envId = 1;
Env[1]:setName("Pesadelo dos Abitantes de Erion, N");
Env[1].from.x = 1292;
Env[1].from.y = 301;
Env[1].to.x = 1325;
Env[1].to.y = 365;
Env[1].center.x = 1308;
Env[1].center.y = 335;
Env[1]:addRespawn( "chaos troll 1", 153 , 1305,354 );
Env[1]:addRespawn( "npc 1", 		154 , 1305,354 );
Env[1]:addRespawn( "chaos troll 2", 153 , 1316,346 );
Env[1]:addRespawn( "npc 2", 		154 , 1316,346 );
Env[1]:addRespawn( "chaos troll 3",	153 , 1302,337 );
Env[1]:addRespawn( "npc 3", 		154 , 1302,337 );
Env[1]:addRespawn( "chaos troll 4", 153 , 1313,329 );
Env[1]:addRespawn( "npc 4", 		154 , 1313,329 );
Env[1]:addRespawn( "chaos troll 5", 153 , 1309,312 );
Env[1]:addRespawn( "npc 5", 		154 , 1309,312 );
Env[1]:addRespawn( "Boss", 			155 , 1308,335 );
-- Sala 2
Env[2].envId = 2;
Env[2]:setName("Pesadelo dos Abitantes de Armia, M");
Env[2].from.x = 1023;
Env[2].from.y = 256;
Env[2].to.x = 1151;
Env[2].to.y = 383;
Env[2].center.x = 1077;
Env[2].center.y = 308;
Env[2]:addRespawn( "moloch 1",  156 , 1107,322 );
Env[2]:addRespawn( "npc 1", 	157 , 1107,322 );
Env[2]:addRespawn( "moloch 2", 	156 , 1116,283 );
Env[2]:addRespawn( "npc 2", 	157 , 1116,283 );
Env[2]:addRespawn( "moloch 3", 	156 , 1090,320 );
Env[2]:addRespawn( "npc 3", 	157 , 1090,320 );
Env[2]:addRespawn( "moloch 4", 	156 , 1062,311 );
Env[2]:addRespawn( "npc 4", 	157 , 1062,311 );
Env[2]:addRespawn( "moloch 5", 	156 , 1055,327 );
Env[2]:addRespawn( "npc 5", 	157 , 1055,327 );
Env[2]:addRespawn( "Boss", 		158 , 1077,308 );
-- Sala 3
Env[3].envId = 3;
Env[3]:setName("Pesadelo dos Abitantes de Arzam, A");
Env[3].from.x = 1158;
Env[3].from.y = 141;
Env[3].to.x = 1271;
Env[3].to.y = 214;
Env[3].center.x = 1210;
Env[3].center.y = 180;
Env[3]:addRespawn( "Cyclop 1", 	159 , 1235,178 );
Env[3]:addRespawn( "npc 1", 	160 , 1235,178 );
Env[3]:addRespawn( "Cyclop 2", 	159 , 1220,178 );
Env[3]:addRespawn( "npc 2", 	160 , 1220,178 );
Env[3]:addRespawn( "Cyclop 3", 	159 , 1212,197 );
Env[3]:addRespawn( "npc 3", 	160 , 1212,197 );
Env[3]:addRespawn( "Cyclop 4", 	159 , 1227,153 );
Env[3]:addRespawn( "npc 4", 	160 , 1227,153 );
Env[3]:addRespawn( "Cyclop 5", 	159 , 1209,157 );
Env[3]:addRespawn( "npc 5", 	160 , 1209,157 );
Env[3]:addRespawn( "Cyclop 6", 	159 , 1192,153 );
Env[3]:addRespawn( "npc 6", 	160 , 1192,153 );
Env[3]:addRespawn( "Cyclop 7", 	159 , 1172,174 );
Env[3]:addRespawn( "npc 7", 	160 , 1172,174 );
Env[3]:addRespawn( "Cyclop 8", 	159 , 1185,194 );
Env[3]:addRespawn( "npc 8", 	160 , 1172,174 );
Env[3]:addRespawn( "boss", 	161 , 1210,180 );

local spawns = { {153,154,155}, {156,157,158}, {159,160,161} };
local initBoss = (20*(60*1000));
local bossTime = { 0,0,0 };
local spawnUnit = { 20, 30, 40 }; 
local initTime = { {0,0},{0,0},{0,0} };
local wtime = 0;

function onExecute(this, envId)

	wtime = iGetCurrentTime();
	if(initTime[envId][1] ~= 2) then
		if( initTime[envId][1] == 0 and initTime[envId][2] < wtime) then
			initTime[envId][1] = 1;
			initTime[envId][2] = wtime+ (60*1000);
			Env[envId]:executeSpawn(spawns[envId][2]);
			Env[envId]:sendTime( 60, true );
		elseif(initTime[envId][1] == 1 and initTime[envId][2] < wtime) then
			initTime[envId][1] = 2;
			Env[envId]:executeSpawn(spawns[envId][1]);
			Env[envId]:sendTime(sec_Nightmare, true);
		end
		this:addTask(envId);
		return TRUE;
	end
	
	local checkMonster = Env[envId]:checkSpawn(spawns[envId][1]);
	local checkNpc = Env[envId]:checkSpawn(spawns[envId][2]);
	local checkPlayer = Env[envId]:checkPlayer();
	
	if(Env[envId]:getTime() > wtime) then
		if(checkNpc > 0 and checkPlayer > 0) then
		
			if(bossTime[envId] ~= 0) then
				if( bossTime[envId] < wtime ) then
					Env[envId]:resetNpc( );
					Env[envId]:executeSpawn(spawns[envId][3]);
					bossTime[envId] = 0;
				elseif(checkMonster < spawnUnit[envId]) then
					Env[envId]:executeSpawn(spawns[envId][1]);
				end
				
				this:addTask( envId );
				return TRUE;
			else
				if(Env[envId]:checkSpawn(spawns[envId][3]) > 0) then
					this:addTask( envId );
					return TRUE;
				end
			end
		end
	end
	
	Env[envId]:removeAllPlayer( ResPawnsBasePos );
	Env[envId]:resetNpc( );
	Env[envId]:stop( );
	bossTime[envId] = 0;
	initTime[envId][1] = 0;
	return TRUE;
end

function onAddPlayer(this, envId, player)
	
	if(	Env[envId]:checkPlayer( ) <= 0 ) then
		if( Env[envId]:addGroup( this, player, Env[envId].center ) ) then
			wtime = iGetCurrentTime( );
			Env[envId]:setTime(wtime + nSec_Nightmare);
			Env[envId]:sendTime( 60, true );
			Env[envId]:start( );
			bossTime[envId] = wtime+initBoss;
			initTime[envId][1] = 0;
			initTime[envId][2] = wtime+(60*1000);
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

