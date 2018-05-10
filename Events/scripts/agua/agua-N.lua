local EventItem = { CItem:new(3174), CItem:new(3175), CItem:new(3176), CItem:new(3177), CItem:new(3178), CItem:new(3179), CItem:new(3180), CItem:new(3181) };
local Env = { EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ) };

-- Sala 1
Env[1].envId = 1;
Env[1]:setName("Orc's, sala 1");
Env[1].from.x = 1112;
Env[1].from.y = 3544;
Env[1].to.x = 1132;
Env[1].to.y = 3564;
Env[1].center.x = 1122;
Env[1].center.y = 3554;
Env[1]:addRespawn( "Orc's", 100 , 1122,3554 );
-- Sala 2
Env[2].envId = 2;
Env[2]:setName("Troll's, sala 2");
Env[2].from.x = 1076;
Env[2].from.y = 3544;
Env[2].to.x = 1096;
Env[2].to.y = 3564;
Env[2].center.x = 1086;
Env[2].center.y = 3554;
Env[2]:addRespawn( "Troll's", 101 , 1086,3554 );
-- Sala 3
Env[3].envId = 3;
Env[3]:setName("Hunter_Troll's, sala 3");
Env[3].from.x = 1040;
Env[3].from.y = 3544;
Env[3].to.x = 1060;
Env[3].to.y = 3564;
Env[3].center.x = 1050;
Env[3].center.y = 3554;
Env[3]:addRespawn( "Hunter_Troll's", 102 , 1050,3554 );
-- Sala 4
Env[4].envId = 4;
Env[4]:setName("Dreadtaurs's, sala 4");
Env[4].from.x = 1040;
Env[4].from.y = 3508;
Env[4].to.x = 1060;
Env[4].to.y = 3528;
Env[4].center.x = 1050;
Env[4].center.y = 3518;
Env[4]:addRespawn( "_Dreadtaurs's", 103 , 1050,3518 );
-- Sala 5
Env[5].envId = 5;
Env[5]:setName("Cyclops's, sala 5");
Env[5].from.x = 1040;
Env[5].from.y = 3472;
Env[5].to.x = 1060;
Env[5].to.y = 3492;
Env[5].center.x = 1050;
Env[5].center.y = 3482;
Env[5]:addRespawn( "_Cyclops's", 104 , 1050,3482 );
-- Sala 6
Env[6].envId = 6;
Env[6]:setName("OrcMage's, sala 6");
Env[6].from.x = 1076;
Env[6].from.y = 3472;
Env[6].to.x = 1096;
Env[6].to.y = 3492;
Env[6].center.x = 1086;
Env[6].center.y = 3482;
Env[6]:addRespawn( "_OrcMage's", 105 , 1086,3482 );
-- Sala 7
Env[7].envId = 7;
Env[7]:setName("Caveira's, sala 7");
Env[7].from.x = 1112;
Env[7].from.y = 3472;
Env[7].to.x = 1132;
Env[7].to.y = 3492;
Env[7].center.x = 1122;
Env[7].center.y = 3482;
Env[7]:addRespawn( "_Caveira's", 106 , 1122,3482 );
-- Sala 8
Env[8].envId = 8;
Env[8]:setName("Stone_Golem's, sala 8");
Env[8].from.x = 1112;
Env[8].from.y = 3508;
Env[8].to.x = 1132;
Env[8].to.y = 3528;
Env[8].center.x = 1122;
Env[8].center.y = 3518;
Env[8]:addRespawn( "_Boss's", 107 , 1122,3518 );
-- Sala 9 Boss
Env[9].envId = 9;
Env[9]:setName("Stone_Golem's, sala 9");
Env[9].from.x = 1076;
Env[9].from.y = 3508;
Env[9].to.x = 1096;
Env[9].to.y = 3528;
Env[9].center.x = 1086;
Env[9].center.y = 3518;
Env[9]:addRespawn( "Boss's 1", 108 , 1086,3518 );
Env[9]:addRespawn( "Boss's 1", 109 , 1086,3518 );
Env[9]:addRespawn( "Boss's 1", 110 , 1086,3518 );
Env[9]:addRespawn( "Boss's 1", 111 , 1086,3518 );

local bossID = 0;

function onExecute( this, envId )
	
	local checkPlayer = Env[envId]:checkPlayer( );
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
			Env[envId]:stop( );
		else
			if( Env[envId]:getTime( ) < iGetCurrentTime( ) ) then
				Env[envId]:removeAllPlayer( ExitAguaPos );
				Env[envId].owner = nil;
				Env[envId]:stop( );
			else
				this:addTask( envId );
			end
		end
	elseif( Env[envId]:getTime( ) < iGetCurrentTime( ) ) then
		if ( checkPlayer > 0 )then
			Env[envId]:removeAllPlayer( ExitAguaPos );
		end
		Env[envId].owner = nil;
		Env[envId]:stop( );
	elseif( checkPlayer > 0 ) then
		this:addTask( envId );
	else
		Env[envId].owner = nil;
		Env[envId]:stop( );
	end
end

function onAddPlayer( this, envId, player )
	
	if(	Env[envId]:checkPlayer( ) <= 0 ) then
		if( Env[envId]:addGroup( this, player, Env[envId].center ) ) then
			Env[envId]:setTime( iGetCurrentTime( )+EndAguaEventNSec );
			Env[envId]:sendTime( EndAguaEventSec, true );
			Env[envId]:start( );
			Env[envId].owner = player;	
			if( envId ~= 9 ) then
				Env[envId]:executeSpawn( -1 );
			else
				bossID = iRandomNumber(108,111);
				Env[envId]:executeSpawn( bossID );
			end
			this:addTask( envId );
			iSend.ClientMessage(player, "você esta participando do evento Água(N) \""..Env[envId]:getName( ).."\"");
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

