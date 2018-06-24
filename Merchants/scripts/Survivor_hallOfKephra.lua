local hallOfKefraEvent = iGetEvent( "hallOfKefra" );

function OnUse(npc, player, confirm)

	if(player:hasQuest(global_OWS.questList.HallOfKefraIsAllowed)) then
		iSend.Say(npc, "Você ja pode ir, passe pelo Teleport.");
		return TRUE;
	end
	
	local findItem = FindItem:new(player);
	if(findItem:findItemId(4127, 1) == 1) then
		findItem:clearItems(1);
		
		player:addQuest(global_OWS.questList.HallOfKefraIsAllowed);
	    player:addSkillCondition(44, 20, 20, __sConditionAffect);
		
		iSend.Score(player);
		iSend.Carry(player);
		iSend.Etc(player);
		
		if(iGetGlobalEnvInt64(global_OWS.environmetIdList.HallOfKephraEnvId) == nil) then
			hallOfKefraEvent:addPlayer(player, 1);
		end
	else
		iSend.Say(npc, "Você necessita de 1 Pergaminho Selado." );
	end
		
	return TRUE;
end
