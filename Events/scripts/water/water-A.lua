local spawnList = {};
-- Room's
spawnList[112] = CreateSpawn({pos={x=1377, y=3554, hasWaypoint=true}, max=24, minGroup=12, leader="water_A_Gargula", follower="water_A_Gargula"});
spawnList[113] = CreateSpawn({pos={x=1341, y=3554, hasWaypoint=true}, max=24, minGroup=12, leader="water_A_Golem_de_Fogo", follower="water_A_Golem_de_Fogo"});
spawnList[114] = CreateSpawn({pos={x=1305, y=3554, hasWaypoint=true}, max=10, minGroup=9,  leader="water_A_Cav.Negro", follower="water_A_Cav.Negro"});
spawnList[115] = CreateSpawn({pos={x=1305, y=3518, hasWaypoint=true}, max=24, minGroup=12, leader="water_A_Dragao_Lich", follower="water_A_Dragao_Lich"});
spawnList[116] = CreateSpawn({pos={x=1305, y=3482, hasWaypoint=true}, max=8,  minGroup=7,  leader="water_A_Taron", follower="water_A_Taron"});
spawnList[117] = CreateSpawn({pos={x=1341, y=3482, hasWaypoint=true}, max=12, minGroup=11, leader="water_A_Morlock", follower="water_A_Morlock"});
spawnList[118] = CreateSpawn({pos={x=1377, y=3482, hasWaypoint=true}, max=10, minGroup=9,  leader="water_A_Anc.Ciclop", follower="water_A_Anc.Ciclop"});
spawnList[119] = CreateSpawn({pos={x=1377, y=3518, hasWaypoint=true}, max=7,  minGroup=6,  leader="water_A_Verme", follower="water_A_Verme"});
-- Boss
spawnList[120] = CreateSpawn({pos={x=1341, y=3518, hasWaypoint=true}, max=10, minGroup=9,  leader="water_A_Treant", follower="water_A_Treant"});
spawnList[121] = CreateSpawn({pos={x=1341, y=3518, hasWaypoint=true}, max=8,  minGroup=7,  leader="Lugefer_Maligno", follower="water_A_Gargula.Fogo"});
spawnList[122] = CreateSpawn({pos={x=1341, y=3518, hasWaypoint=true}, max=8,  minGroup=7,  leader="water_A_Gargula.Fogo", follower="water_A_Ladrao_Tauron"});
spawnList[123] = CreateSpawn({pos={x=1341, y=3518, hasWaypoint=true}, max=10, minGroup=9,  leader="water_A_Assas.Taron", follower="water_A_Taron"});

for key, value in pairs(spawnList) do
	assert(value ~= nil, "Error on create SpawnId: "..key);
end

local EventItem = { CItem:new(3183), CItem:new(3184), CItem:new(3185), CItem:new(3186), CItem:new(3187), CItem:new(3188), CItem:new(3189), CItem:new(3190) };
local Env = { EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ), EnvironmentEvent:new( ) };

-- Sala 1
Env[1].envId = 1;
Env[1]:setName("Gargula's, sala 1");
Env[1].from.x = 1367;
Env[1].from.y = 3544;
Env[1].to.x = 1387;
Env[1].to.y = 3564;
Env[1].center.x = 1377;
Env[1].center.y = 3554;
Env[1]:addSpawn( "Gargula's", 112, spawnList[112]);
-- Sala 2
Env[2].envId = 2;
Env[2]:setName("Golem's de Fogo, sala 2");
Env[2].from.x = 1331;
Env[2].from.y = 3544;
Env[2].to.x = 1351;
Env[2].to.y = 3564;
Env[2].center.x = 1341;
Env[2].center.y = 3554;
Env[2]:addSpawn( "Golem's de Fogo", 113, spawnList[113]);
-- Sala 3
Env[3].envId = 3;
Env[3]:setName("Cavaleiro's Negro's, sala 3");
Env[3].from.x = 1295;
Env[3].from.y = 3544;
Env[3].to.x = 1315;
Env[3].to.y = 3564;
Env[3].center.x = 1305;
Env[3].center.y = 3554;
Env[3]:addSpawn( "Cavaleiro's Negro's", 114, spawnList[114]);
-- Sala 4
Env[4].envId = 4;
Env[4]:setName("Dragões Lich's, sala 4");
Env[4].from.x = 1295;
Env[4].from.y = 3508;
Env[4].to.x = 1315;
Env[4].to.y = 3528;
Env[4].center.x = 1305;
Env[4].center.y = 3518;
Env[4]:addSpawn( "_Dragões Lich's", 115, spawnList[115]);
-- Sala 5
Env[5].envId = 5;
Env[5]:setName("Tauron's da Areia, sala 5");
Env[5].from.x = 1295;
Env[5].from.y = 3472;
Env[5].to.x = 1315;
Env[5].to.y = 3492;
Env[5].center.x = 1305;
Env[5].center.y = 3482;
Env[5]:addSpawn( "_Tauron's da Areia", 116, spawnList[116]);
-- Sala 6
Env[6].envId = 6;
Env[6]:setName("Morlock's, sala 6");
Env[6].from.x = 1331;
Env[6].from.y = 3472;
Env[6].to.x = 1351;
Env[6].to.y = 3492;
Env[6].center.x = 1341;
Env[6].center.y = 3482;
Env[6]:addSpawn( "_Morlock's", 117, spawnList[117]);
-- Sala 7
Env[7].envId = 7;
Env[7]:setName("Anc.Ciclope's, sala 7");
Env[7].from.x = 1367;
Env[7].from.y = 3472;
Env[7].to.x = 1387;
Env[7].to.y = 3492;
Env[7].center.x = 1377;
Env[7].center.y = 3482;
Env[7]:addSpawn( "_Anc.Ciclope's", 118, spawnList[118]);
-- Sala 8
Env[8].envId = 8;
Env[8]:setName("Verme's da Areia, sala 8");
Env[8].from.x = 1367;
Env[8].from.y = 3508;
Env[8].to.x = 1387;
Env[8].to.y = 3528;
Env[8].center.x = 1377;
Env[8].center.y = 3518;
Env[8]:addSpawn( "_Verme's da Areia", 119, spawnList[119]);
-- Sala 9 Boss
Env[9].envId = 9;
Env[9]:setName("Boss, sala 9");
Env[9].from.x = 1331;
Env[9].from.y = 3508;
Env[9].to.x = 1351;
Env[9].to.y = 3528;
Env[9].center.x = 1341;
Env[9].center.y = 3518;
Env[9]:addSpawn( "Boss's 1", 120, spawnList[120]);
Env[9]:addSpawn( "Boss's 2", 121, spawnList[121]);
Env[9]:addSpawn( "Boss's 3", 122, spawnList[122]);
Env[9]:addSpawn( "Boss's 4", 123, spawnList[123]);

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
				bossID = iRandomNumber(120,123);
				Env[envId]:executeSpawn( bossID );
			end
			this:addTask( envId );
			iSend.ClientMessage(player, "você esta participando do evento Água(A) \""..Env[envId]:getName( ).."\"");
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

