local nightmareEvent = iGetEvent("nightmare");

local function sendToNightmareEvent(player, level)

	--if(player:getCurrentPosition():isBetween(1045, 1689, 1047, 1691)) then
		if(nightmareEvent:addPlayer(player, level)) then
			return TRUE;
		else
			iSend.ClientMessage(player, "Evento em andamento.")
		end
	--else
	--	iSend.ClientMessage(player, "Necessário estar no Altar de Thor para usar.")
	--end
	
	return FALSE;
end

function OnUse(player, pSrc, pNumber, pDest)
	
	if(pSrc.itemId == 3324) then
		return sendToNightmareEvent(player, 1);
	elseif(pSrc.itemId ==  3325 ) then
		return sendToNightmareEvent(player, 2);
	elseif(pSrc.itemId ==  3326) then
		return sendToNightmareEvent(player, 3);
	end
	
	return FALSE;
end
