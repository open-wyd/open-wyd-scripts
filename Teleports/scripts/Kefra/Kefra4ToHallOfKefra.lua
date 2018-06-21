local hallOfKefraEvent = iGetEvent( "hallOfKefra" );

function OnUse(player)
	
	local HallOfKephraStatusId = iGetGlobalEnvInt64(global_OWS.environmetIdList.HallOfKephraEnvId);
	local hour = tonumber(os.date("%H"));
	local questId = global_OWS.questList.HallOfKefraIsAllowed;
	
	if( (player:hasQuest(questId) and HallOfKephraStatusId == nil or player:hasQuest(questId) and HallOfKephraStatusId ~= nil and HallOfKephraStatusId ~= 1) and hour >= 0) then
		hallOfKefraEvent:addPlayer(player, 2);
		player:removeQuest(questId);
	elseif(player:hasQuest(questId) and HallOfKephraStatusId == 1) then 
		iGameServer.DoTeleport(player, 2367, 3906);
		player:removeQuest(questId);
	elseif((player:hasQuest(questId) and HallOfKephraStatusId == nil or player:hasQuest(questId) and HallOfKephraStatusId ~= nil and HallOfKephraStatusId ~= 1) and hour < 18) then
		iSend.ClientMessage(player, "Só poderá enfrentar o Kefra a partir dàs 18hrs.");
	end
	return TRUE;
end
