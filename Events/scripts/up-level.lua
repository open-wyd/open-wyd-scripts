local Env = { EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ),  EnvironmentEvent:new( ), EnvironmentEvent:new( ) };
local exitUpLevelPos = CPosition:new(0,0);

-- Sala 1
Env[1].envId = 1;
Env[1]:setName("Defensor da alma");
Env[1].from.x = 2379;
Env[1].from.y = 2077;
Env[1].to.x = 2426;
Env[1].to.y = 2132;
Env[1].center.x = 2398;
Env[1].center.y = 2105;
-- Sala 2
Env[2].envId = 2;
Env[2]:setName("Jardin Dos Deuses");
Env[2].from.x = 2228;
Env[2].from.y = 1700;
Env[2].to.x = 2257;
Env[2].to.y = 1728;
Env[2].center.x = 2236;
Env[2].center.y = 1714;
-- Sala 3
Env[3].envId = 3;
Env[3]:setName("Ressurreição do Cavaleiro Negro");
Env[3].from.x = 459;
Env[3].from.y = 3887;
Env[3].to.x = 497;
Env[3].to.y = 3916;
Env[3].center.x = 467;
Env[3].center.y = 3902;
-- Sala 4
Env[4].envId = 4;
Env[4]:setName("Hydra Imortal");
Env[4].from.x = 666;
Env[4].from.y = 3727;
Env[4].to.x = 703;
Env[4].to.y = 3762;
Env[4].center.x = 668;
Env[4].center.y = 3754;
-- Sala 5
Env[5].envId = 5;
Env[5]:setName("Inicio da Infelicidade");
Env[5].from.x = 1312;
Env[5].from.y = 4027;
Env[5].to.x = 1348;
Env[5].to.y = 4054;
Env[5].center.x = 1324;
Env[5].center.y = 4041;
-- Sala 6
Env[6].envId = 6;
Env[6]:setName("Formatura de Cavaleiros Aprendizes");
Env[6].from.x = 2230;
Env[6].from.y = 1562;
Env[6].to.x = 2258;
Env[6].to.y = 1592;
Env[6].center.x = 2244;
Env[6].center.y = 1577;
-- Sala 7
Env[7].envId = 7;
Env[7]:setName("Benção de Deus");
Env[7].from.x = 2639;
Env[7].from.y = 1964;
Env[7].to.x = 2670;
Env[7].to.y = 2003;
Env[7].center.x = 2652;
Env[7].center.y = 1983;

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

