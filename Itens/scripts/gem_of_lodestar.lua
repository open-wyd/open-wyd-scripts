function OnUse(player, pSrc, pNumber, pDest)

	local currentPosition = player:getCurrentPosition();
	local mapAttr = iGameServer.GetMapAttribute(currentPosition);
	if (mapAttr & 4 and player:getLevel() < 1000) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Use_That_Here);
		return FALSE;
	end
	
	local mapFramePos = {x = currentPosition.x/128, y = currentPosition.y/128};
	local isForceSave = (mapFramePos.x == 9 and mapFramePos.y == 1) or (mapFramePos.x == 8 and mapFramePos.y == 2);
	
	if (isForceSave == false and (iGameServer.GetMapArenaId(currentPosition) ~= global_OWS.map.zoneIdList.None or iGameServer.GetMapVillageId(currentPosition) ~= global_OWS.map.zoneIdList.None)) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Use_That_Here);
		return FALSE;
	end			
	
	if ((player:getPhace():getId() / 10) == 0) then
		iSend.Emotion(player, 23, 0);
	else
		iSend.Emotion(player, 15, 0);
	end
	
	player:setSavePos(currentPosition);
	
	iLog("StarGem, "..player:getName().." save position{"..currentPosition.x..", "..currentPosition.y.."}");

	iSend.ClientMessage(player, MessageStringTable._NN_Set_Warp);
	return TRUE;
end
