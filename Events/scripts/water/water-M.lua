local spawnList = {};
-- Room's
spawnList[10] = CreateSpawn({pos={x=1250, y=3682, hasWaypoint=true}, max=24, minGroup=12, leader="water_M_Dark_Elf", follower="water_M_Dark_Elf"});
spawnList[11] = CreateSpawn({pos={x=1214, y=3682, hasWaypoint=true}, max=24, minGroup=12, leader="water_M_Undead_Troll", follower="water_M_Undead_Troll"});
spawnList[12] = CreateSpawn({pos={x=1178, y=3682, hasWaypoint=true}, max=10, minGroup=9,  leader="water_M_Odd_Frog", follower="water_M_Odd_Frog"});
spawnList[13] = CreateSpawn({pos={x=1178, y=3646, hasWaypoint=true}, max=24, minGroup=12, leader="water_M_Imp", follower="water_M_Imp"});
spawnList[14] = CreateSpawn({pos={x=1178, y=3610, hasWaypoint=true}, max=8,  minGroup=7,  leader="water_M_Grim_Lock", follower="water_M_Grim_Lock"});
spawnList[15] = CreateSpawn({pos={x=1214, y=3610, hasWaypoint=true}, max=12, minGroup=11, leader="water_M_Dark_Elf_Witch", follower="water_M_Dark_Elf_Witch"});
spawnList[16] = CreateSpawn({pos={x=1250, y=3610, hasWaypoint=true}, max=10, minGroup=9,  leader="water_M_Gagoil", follower="water_M_Gagoil"});
spawnList[17] = CreateSpawn({pos={x=1250, y=3646, hasWaypoint=true}, max=7,  minGroup=6,  leader="water_M_Water_Golem", follower="water_M_Water_Golem"});
-- Boss
spawnList[18] = CreateSpawn({pos={x=1214, y=3646, hasWaypoint=true}, max=10, minGroup=9,  leader="water_M_Demon_Lord", follower="water_M_Death_Knight"});
spawnList[19] = CreateSpawn({pos={x=1214, y=3646, hasWaypoint=true}, max=8,  minGroup=7,  leader="water_M_Boss_Death_Knight", follower="water_M_Dark_Knight"});
spawnList[20] = CreateSpawn({pos={x=1214, y=3646, hasWaypoint=true}, max=8,  minGroup=7,  leader="water_M_Wise_Gagoil", follower="water_M_Boss_follower_Gagoil"});
spawnList[21] = CreateSpawn({pos={x=1214, y=3646, hasWaypoint=true}, max=10, minGroup=9,  leader="water_M_Gold_Hydra", follower="water_M_Gold_Hydra"});

for key, value in pairs(spawnList) do
	assert(value ~= nil, "Error on create SpawnId: "..key);
end

local EventItem = {CItem:new(778), CItem:new(779), CItem:new(780), CItem:new(781), CItem:new(782), CItem:new(783), CItem:new(784), CItem:new(785)};
local Env = {EnvironmentEvent:new(), EnvironmentEvent:new(), EnvironmentEvent:new(), EnvironmentEvent:new(), EnvironmentEvent:new(), EnvironmentEvent:new(), EnvironmentEvent:new(), EnvironmentEvent:new(), EnvironmentEvent:new()};

-- Sala 1
Env[1].envId = 1;
Env[1]:setName("_Dark_Elf_, sala 1");
Env[1].from.x = 1239;
Env[1].from.y = 3671;
Env[1].to.x = 1260;
Env[1].to.y = 3692;
Env[1].center.x = 1250;
Env[1].center.y = 3682;
Env[1]:addSpawn( "__Dark_Elf_", 10, spawnList[10]);
-- Sala 2
Env[2].envId = 2;
Env[2]:setName("_Undead_Troll_, sala 2");
Env[2].from.x = 1203;
Env[2].from.y = 3671;
Env[2].to.x = 1224;
Env[2].to.y = 3693;
Env[2].center.x = 1214;
Env[2].center.y = 3682;
Env[2]:addSpawn( "__Undead_Troll_", 11, spawnList[11]);
-- Sala 3
Env[3].envId = 3;
Env[3]:setName("_Odd_Frog_, sala 3");
Env[3].from.x = 1167;
Env[3].from.y = 3671;
Env[3].to.x = 1188;
Env[3].to.y = 3693;
Env[3].center.x = 1178;
Env[3].center.y = 3682;
Env[3]:addSpawn( "__Odd_Frog_", 12, spawnList[12]);
-- Sala 4
Env[4].envId = 4;
Env[4]:setName("_Imp_, sala 4");
Env[4].from.x = 1167;
Env[4].from.y = 3635;
Env[4].to.x = 1188;
Env[4].to.y = 3656;
Env[4].center.x = 1178;
Env[4].center.y = 3646;
Env[4]:addSpawn( "__Imp_", 13, spawnList[13]);
-- Sala 5
Env[5].envId = 5;
Env[5]:setName("_Grim_Lock_, sala 5");
Env[5].from.x = 1167;
Env[5].from.y = 3598;
Env[5].to.x = 1188;
Env[5].to.y = 3620;
Env[5].center.x = 1178;
Env[5].center.y = 3610;
Env[5]:addSpawn( "__Grim_Lock_", 14, spawnList[14]);
-- Sala 6
Env[6].envId = 6;
Env[6]:setName("_Dark_Elf_Witch, sala 6");
Env[6].from.x = 1203;
Env[6].from.y = 3599;
Env[6].to.x = 1224;
Env[6].to.y = 3620;
Env[6].center.x = 1214;
Env[6].center.y = 3610;
Env[6]:addSpawn( "__Dark_Elf_Witch", 15, spawnList[15]);
-- Sala 7
Env[7].envId = 7;
Env[7]:setName("_Gagoil_, sala 7");
Env[7].from.x = 1239;
Env[7].from.y = 3599;
Env[7].to.x = 1260;
Env[7].to.y = 3620;
Env[7].center.x = 1250;
Env[7].center.y = 3610;
Env[7]:addSpawn( "__Gagoil_", 16, spawnList[16]);
-- Sala 8
Env[8].envId = 8;
Env[8]:setName("_Water_Golem_, sala 8");
Env[8].from.x = 1239;
Env[8].from.y = 3635;
Env[8].to.x = 1260;
Env[8].to.y = 3656;
Env[8].center.x = 1250;
Env[8].center.y = 3646;
Env[8]:addSpawn( "__Water_Golem_", 17, spawnList[17]);
-- Sala 9 Boss
Env[9].envId = 9;
Env[9]:setName("Boss, sala 9");
Env[9].from.x = 1201;
Env[9].from.y = 3632;
Env[9].to.x = 1228;
Env[9].to.y = 3659;
Env[9].center.x = 1214;
Env[9].center.y = 3645;
Env[9]:addSpawn( "_Demon_Lord_",  18, spawnList[18]);
Env[9]:addSpawn( "_Death_Knight", 19, spawnList[19]);
Env[9]:addSpawn( "_Wise_Gagoil_", 20, spawnList[20]);
Env[9]:addSpawn( "_Gold_Hydra",   21, spawnList[21]);

local bossID = 0;

function onExecute( this, envId )
	
	local checkPlayer = Env[envId]:checkPlayer();
	local checkSpawn;
	
	if( envId ~= 9 ) then
		checkSpawn = Env[envId]:checkSpawn( -1 );
	else
		checkSpawn = Env[envId]:checkSpawn( bossID );
	end
	
	if( checkSpawn <= 0 ) then
		if ( envId ~= 9 and checkPlayer > 0 )then
			if(  Env[envId].owner ~= nil ) then
				iGameServer.PutItem(Env[envId].owner, EventItem[envId]);
			end
			Env[envId]:removeAllPlayer( ExitAguaPos );
			Env[envId].owner = nil;
			Env[envId]:stop();
		else
			if( Env[envId]:getTime() < iGetCurrentTime() ) then
				Env[envId]:removeAllPlayer( ExitAguaPos );
				Env[envId].owner = nil;
				Env[envId]:stop();
			else
				this:addTask( envId );
			end
		end
	elseif( Env[envId]:getTime() < iGetCurrentTime() ) then
		if ( checkPlayer > 0 )then
			Env[envId]:removeAllPlayer( ExitAguaPos );
		end
		Env[envId].owner = nil;
		Env[envId]:stop();
	elseif( checkPlayer > 0 ) then
		this:addTask( envId );
	else
		Env[envId].owner = nil;
		Env[envId]:stop();
	end
end

function onAddPlayer( this, envId, player )
	
	if(	Env[envId]:checkPlayer() <= 0 ) then
		if( Env[envId]:addGroup( this, player, Env[envId].center ) ) then
			Env[envId]:setTime( iGetCurrentTime()+EndAguaEventNSec );
			Env[envId]:sendTime( EndAguaEventSec, true );
			Env[envId]:start();
			Env[envId].owner = player;	
			if( envId ~= 9 ) then
				Env[envId]:executeSpawn( -1 );
			else
				bossID = iRandomNumber(18,21);
				Env[envId]:executeSpawn( bossID );
			end
			this:addTask( envId );
			iSend.ClientMessage(player, "você esta participando do evento Água(M) \""..Env[envId]:getName().."\"");
			return TRUE;
		end
		return FALSE;
	end
	iSend.ClientMessage(player, "este evento já esta sendo realizado, aguarde.");
	return FALSE;
end

function onRemovePlayer( this, envId, player )
	
	if( Env[envId].owner ~= nil and Env[envId].owner == player ) then
		Env[envId].owner = nil;
	end
	
	if( Env[envId]:removePlayer( player, ExitAguaPos ) ) then
		return TRUE;
	end
	
	return FALSE;
end

