local experienceValue = 2500;

function OnUse(player, pSrc, pNumber, pDest)

	if(player:getPromotionId() > 1) then
		return FALSE;
	end
	
	iSend.ClientMessage(player, string.format(MessageStringTable._NS_GETEXP, experienceValue));
	
	player:addExp(experienceValue);
	
	iSend.Emotion(player, 14, 3);
	iSend.ExpGain(player)
	iGameServer.TryLevelUpWithEffects(player);
	
	iLog(player:getName().." gained "..experienceValue.." of experience of the Eye Wax item");
	
	return TRUE;
end
