local Env = { };
local exitUpLevelPos = CPosition:new(0,0);

-- Sala 1
Env[4111] = EnvironmentEvent:new( );
Env[4111].envId = 4111;
Env[4111]:setName("Territorio (N)");
Env[4111].from.x = 3604;
Env[4111].from.y = 3604;
Env[4111].to.x = 3690;
Env[4111].to.y = 3690;
Env[4111].center.x = 3683;
Env[4111].center.y = 3640;
-- Sala 2
Env[4112] = EnvironmentEvent:new( );  
Env[4112].envId = 4112;
Env[4112]:setName("Territorio (M)");
Env[4112].from.x = 3732;
Env[4112].from.y = 3476;
Env[4112].to.x = 3819;
Env[4112].to.y = 3563;
Env[4112].center.x = 3810;
Env[4112].center.y = 3525;
-- Sala 3
Env[4113] = EnvironmentEvent:new( );
Env[4113].envId = 4113;
Env[4113]:setName("Territorio (A)");
Env[4113].from.x = 3860;
Env[4113].from.y = 3604;
Env[4113].to.x = 3946;
Env[4113].to.y = 3690;
Env[4113].center.x = 3865;
Env[4113].center.y = 3683;


function onExecute( this, envId )
	
	if (Env[envId]:checkPlayer( ) > 0)then 
		Env[envId]:removeAllPlayer( exitUpLevelPos );
	end
	
	Env[envId]:stop( );
	return TRUE;
end

function onAddPlayer( this, envId, player )
	if(	Env[envId]:isStarted() == false ) then
		this:addScheduler( Time_Sec_OfReset, envId );
	end
	
	Env[envId]:start( );
	
	if( Env[envId]:addPlayer( this, player, Env[envId].center ) ) then
		iSend.ClientMessage(player, "Você entrou na quest \""..Env[envId]:getName( ).."\"");
		return TRUE;
	end
	
	return FALSE;
end

function onRemovePlayer( this, envId, player )
	
	if( Env[envId]:removePlayer( player, exitUpLevelPos ) ) then
		return TRUE;
	end
	return FALSE;
end

