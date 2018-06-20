local duelEvent = iGetEvent("duel_letter");

local function sendToDuelEvent(player, level)

	if(player:getCurrentPosition():isBetween(1045, 1689, 1047, 1691)) then
		if(duelEvent:addPlayer(player, level)) then
			return TRUE;
		else
			iSend.ClientMessage(player, "Evento em andamento.")
		end
	else
		iSend.ClientMessage(player, "Necessário estar no Altar de Thor para usar.")
	end
	
	return FALSE;
end

function OnUse(player, pSrc, pNumber, pDest)
	
	if(pSrc.itemId == 3172) then
		return sendToDuelEvent(player, 1);
	elseif(pSrc.itemId ==  3171 ) then
		return sendToDuelEvent(player, 2);
	elseif(pSrc.itemId ==  1731) then
		return sendToDuelEvent(player, 3);
	end
	
	return FALSE;
end
