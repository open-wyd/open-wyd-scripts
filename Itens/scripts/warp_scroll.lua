function OnUse(player, pSrc, pNumber, pDest)
	
	local savePos = player:getSavePos();
	
	if(savePos:validate() == false) then
		iSend.ClientMessage(player, MessageStringTable._NN_Not_Was_Set_Warp);
		return FALSE;
	end
	
	local mapFramePos = {x = savePos.x/128, y = savePos.y/128};
	if ((mapFramePos.x == 9 and mapFramePos.y == 1) or (mapFramePos.x == 8 and mapFramePos.y == 2)) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Use_That_Here);
		return FALSE;
	end

	local currentPosition = player:getCurrentPosition();
	local mapAttr = iGameServer.GetMapAttribute(currentPosition);
	if (mapAttr & 4 == 4) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Use_That_Here);
		return FALSE;
	end

	tResult = iGameServer.DoTeleport(player, savePos);
	
	iLog(string.format("%s, Teleport warp scrool from: {%d, %d} to: {%d, %d} %s", player:getName(), currentPosition.x, currentPosition.y, savePos.x, savePos.y, tostring(tResult)));
	
	if(tResult) then
		return TRUE;
	else
		return FALSE;
	end
end
