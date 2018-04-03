local EventItem = { CItem:new(778), CItem:new(779), CItem:new(780), CItem:new(781), CItem:new(782), CItem:new(783), CItem:new(784), CItem:new(785) };
local Env = { EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ) };

-- Sala 1
Env[1].envID = 1;
Env[1]:setName("_Dark_Elf_, sala 1");
Env[1].from.x = 1239;
Env[1].from.y = 3671;
Env[1].to.x = 1260;
Env[1].to.y = 3692;
Env[1].center.x = 1250;
Env[1].center.y = 3682;
Env[1]:addRespawn( "__Dark_Elf_", 10 , 1250,3682 );
-- Sala 2
Env[2].envID = 2;
Env[2]:setName("_Undead_Troll_, sala 2");
Env[2].from.x = 1203;
Env[2].from.y = 3671;
Env[2].to.x = 1224;
Env[2].to.y = 3693;
Env[2].center.x = 1214;
Env[2].center.y = 3682;
Env[2]:addRespawn( "__Undead_Troll_", 11 , 1214,3682 );
-- Sala 3
Env[3].envID = 3;
Env[3]:setName("_Odd_Frog_, sala 3");
Env[3].from.x = 1167;
Env[3].from.y = 3671;
Env[3].to.x = 1188;
Env[3].to.y = 3693;
Env[3].center.x = 1178;
Env[3].center.y = 3682;
Env[3]:addRespawn( "__Odd_Frog_", 12 , 1178,3682 );
-- Sala 4
Env[4].envID = 4;
Env[4]:setName("_Imp_, sala 4");
Env[4].from.x = 1167;
Env[4].from.y = 3635;
Env[4].to.x = 1188;
Env[4].to.y = 3656;
Env[4].center.x = 1178;
Env[4].center.y = 3646;
Env[4]:addRespawn( "__Imp_", 13 , 1178,3646 );
-- Sala 5
Env[5].envID = 5;
Env[5]:setName("_Grim_Lock_, sala 5");
Env[5].from.x = 1167;
Env[5].from.y = 3598;
Env[5].to.x = 1188;
Env[5].to.y = 3620;
Env[5].center.x = 1178;
Env[5].center.y = 3610;
Env[5]:addRespawn( "__Grim_Lock_", 14 , 1178,3610 );
-- Sala 6
Env[6].envID = 6;
Env[6]:setName("_Dark_Elf_Witch, sala 6");
Env[6].from.x = 1203;
Env[6].from.y = 3599;
Env[6].to.x = 1224;
Env[6].to.y = 3620;
Env[6].center.x = 1214;
Env[6].center.y = 3610;
Env[6]:addRespawn( "__Dark_Elf_Witch", 15 , 1214,3610 );
-- Sala 7
Env[7].envID = 7;
Env[7]:setName("_Gagoil_, sala 7");
Env[7].from.x = 1239;
Env[7].from.y = 3599;
Env[7].to.x = 1260;
Env[7].to.y = 3620;
Env[7].center.x = 1250;
Env[7].center.y = 3610;
Env[7]:addRespawn( "__Gagoil_", 16 , 1250,3610 );
-- Sala 8
Env[8].envID = 8;
Env[8]:setName("_Water_Golem_, sala 8");
Env[8].from.x = 1239;
Env[8].from.y = 3635;
Env[8].to.x = 1260;
Env[8].to.y = 3656;
Env[8].center.x = 1250;
Env[8].center.y = 3646;
Env[8]:addRespawn( "__Water_Golem_", 17 , 1250,3646 );
-- Sala 9 Boss
Env[9].envID = 9;
Env[9]:setName("Boss, sala 9");
Env[9].from.x = 1201;
Env[9].from.y = 3632;
Env[9].to.x = 1228;
Env[9].to.y = 3659;
Env[9].center.x = 1214;
Env[9].center.y = 3645;
Env[9]:addRespawn( "_Demon_Lord_", 18 , 1214,3645 );
Env[9]:addRespawn( "_Death_Knight", 19 , 1214,3645 );
Env[9]:addRespawn( "_Wise_Gagoil_", 20 , 1214,3645 );
Env[9]:addRespawn( "_Gold_Hydra", 21 , 1214,3645 );

local bossID = 0;

function onExecute( this, envID )
	
	--Log( this..", envID Started, player: "..envID:getName( ) );
	
	local checkPlayer = Env[envID]:checkPlayer( );
	local checkSpawn;
	
	if( envID ~= 9 ) then
		checkSpawn = Env[envID]:checkSpawn( -1 );
	else
		checkSpawn = Env[envID]:checkSpawn( bossID );
	end
	
	if( checkSpawn <= 0 ) then
		if ( envID ~= 9 and checkPlayer > 0 )then
			if(  Env[envID].owner ~= nil ) then
				iGameServer.PutItem(Env[envID].owner, EventItem[envID]);
			end
			Env[envID]:removeAllPlayer( ExitAguaPos );
			Env[envID].owner = nil;
			Env[envID]:stop( );
		else
			if( Env[envID]:getTime( ) < iGetCurrentTime( ) ) then
				Env[envID]:removeAllPlayer( ExitAguaPos );
				Env[envID].owner = nil;
				Env[envID]:stop( );
			else
				this:addTask( envID );
			end
		end
	elseif( Env[envID]:getTime( ) < iGetCurrentTime( ) ) then
		if ( checkPlayer > 0 )then
			Env[envID]:removeAllPlayer( ExitAguaPos );
		end
		Env[envID].owner = nil;
		Env[envID]:stop( );
	elseif( checkPlayer > 0 ) then
		this:addTask( envID );
	else
		Env[envID].owner = nil;
		Env[envID]:stop( );
	end
	--Log( "checkPlayer: "..checkPlayer.." checkSpawn:"..checkSpawn.." OnExecute...time: "..event.Time.." WorldTime: ".. iGetCurrentTime( ) )	
end

function onAddPlayer( this, envID, player )
	
	if(	Env[envID]:checkPlayer( ) <= 0 ) then
		if( Env[envID]:addGroup( this, player, Env[envID].center ) ) then
			Env[envID]:setTime( iGetCurrentTime( )+EndAguaEventNSec );
			Env[envID]:sendTime( EndAguaEventSec, true );
			Env[envID]:start( );
			Env[envID].owner = player;	
			if( envID ~= 9 ) then
				Env[envID]:executeSpawn( -1 );
			else
				bossID = iRandomNumber(18,21);
				Env[envID]:executeSpawn( bossID );
			end
			this:addTask( envID );
			iSend.ClientMessage(player, "você esta participando do evento Água(M) \""..Env[envID]:getName( ).."\"");
			return TRUE;
		end
		return FALSE;
	end
	iSend.ClientMessage(player, "este evento já esta sendo realizado, aguarde.");
	return FALSE;
end

function onRemovePlayer( this, envID, player )
	
	if( Env[envID].owner ~= nil and Env[envID].owner == player ) then
		Env[envID].owner = nil;
	end
	
	if( Env[envID]:removePlayer( player, ExitAguaPos ) ) then
		return TRUE;
	end
	
	return FALSE;
end

