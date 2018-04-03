local event = iGetEvent( "hallkefra" );

function OnUse( player )
	local kefraMorreu = iGetGlobalEnvInt64(74);
	local hour = tonumber(os.date( "%H" ));
	
	if( (player:checkQuest( 64 ) and kefraMorreu == nil or player:checkQuest(64) and kefraMorreu ~= nil and kefraMorreu ~= 1) and hour >= 0 ) then
		event:addPlayer(player, 2)
		player:removeQuest( 64 )
	elseif( player:checkQuest( 64 ) and kefraMorreu == 1 ) then 
		iGameServer.DoTeleport(player, 2367, 3906);
		player:removeQuest( 64 )
	elseif( (player:checkQuest( 64 ) and kefraMorreu == nil or player:checkQuest(64) and kefraMorreu ~= nil and kefraMorreu ~= 1) and hour < 18 ) then
		iSend.ClientMessage(player, "Só poderá enfrentar o Kefra a partir dàs 18hrs.");
	end
	return TRUE;
end
