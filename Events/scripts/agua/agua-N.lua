local EventItem = { CItem:new(3174), CItem:new(3175), CItem:new(3176), CItem:new(3177), CItem:new(3178), CItem:new(3179), CItem:new(3180), CItem:new(3181) };
local Env = { EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ) };

-- Sala 1
Env[1].envID = 1;
Env[1]:setName("Orc's, sala 1");
Env[1].from.x = 1112;
Env[1].from.y = 3544;
Env[1].to.x = 1132;
Env[1].to.y = 3564;
Env[1].center.x = 1122;
Env[1].center.y = 3554;
Env[1]:addRespawn( "Orc's", 100 , 1122,3554 );
-- Sala 2
Env[2].envID = 2;
Env[2]:setName("Troll's, sala 2");
Env[2].from.x = 1076;
Env[2].from.y = 3544;
Env[2].to.x = 1096;
Env[2].to.y = 3564;
Env[2].center.x = 1086;
Env[2].center.y = 3554;
Env[2]:addRespawn( "Troll's", 101 , 1086,3554 );
-- Sala 3
Env[3].envID = 3;
Env[3]:setName("Hunter_Troll's, sala 3");
Env[3].from.x = 1040;
Env[3].from.y = 3544;
Env[3].to.x = 1060;
Env[3].to.y = 3564;
Env[3].center.x = 1050;
Env[3].center.y = 3554;
Env[3]:addRespawn( "Hunter_Troll's", 102 , 1050,3554 );
-- Sala 4
Env[4].envID = 4;
Env[4]:setName("Dreadtaurs's, sala 4");
Env[4].from.x = 1040;
Env[4].from.y = 3508;
Env[4].to.x = 1060;
Env[4].to.y = 3528;
Env[4].center.x = 1050;
Env[4].center.y = 3518;
Env[4]:addRespawn( "_Dreadtaurs's", 103 , 1050,3518 );
-- Sala 5
Env[5].envID = 5;
Env[5]:setName("Cyclops's, sala 5");
Env[5].from.x = 1040;
Env[5].from.y = 3472;
Env[5].to.x = 1060;
Env[5].to.y = 3492;
Env[5].center.x = 1050;
Env[5].center.y = 3482;
Env[5]:addRespawn( "_Cyclops's", 104 , 1050,3482 );
-- Sala 6
Env[6].envID = 6;
Env[6]:setName("OrcMage's, sala 6");
Env[6].from.x = 1076;
Env[6].from.y = 3472;
Env[6].to.x = 1096;
Env[6].to.y = 3492;
Env[6].center.x = 1086;
Env[6].center.y = 3482;
Env[6]:addRespawn( "_OrcMage's", 105 , 1086,3482 );
-- Sala 7
Env[7].envID = 7;
Env[7]:setName("Caveira's, sala 7");
Env[7].from.x = 1112;
Env[7].from.y = 3472;
Env[7].to.x = 1132;
Env[7].to.y = 3492;
Env[7].center.x = 1122;
Env[7].center.y = 3482;
Env[7]:addRespawn( "_Caveira's", 106 , 1122,3482 );
-- Sala 8
Env[8].envID = 8;
Env[8]:setName("Stone_Golem's, sala 8");
Env[8].from.x = 1112;
Env[8].from.y = 3508;
Env[8].to.x = 1132;
Env[8].to.y = 3528;
Env[8].center.x = 1122;
Env[8].center.y = 3518;
Env[8]:addRespawn( "_Boss's", 107 , 1122,3518 );
-- Sala 9 Boss
Env[9].envID = 9;
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
				bossID = iRandomNumber(108,111);
				Env[envID]:executeSpawn( bossID );
			end
			this:addTask( envID );
			iSend.ClientMessage(player, "você esta participando do evento Água(N) \""..Env[envID]:getName( ).."\"");
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

