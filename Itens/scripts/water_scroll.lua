local waterNEvent = iGetEvent("water-N");
local waterMEvent = iGetEvent("water-M");
local waterAEvent = iGetEvent("water-A");

local function sendToWater(player, event, level)

	if(player:getCurrentPosition():isBetween(1964, 1772, 1967, 1775) or player:getLevel() > 1000) then
		if(event:addPlayer(player, level)) then
			return TRUE;
		else
			iSend.ClientMessage(player, "Evento em andamento.")
		end
	else
		iSend.ClientMessage(player, "Necessário estar na Zona Elemental da Água para usar.")
	end
	
	return FALSE;
end

function OnUse(player, pSrc, pNumber, pDest)
	
	local scrollItem = player:getItem(pSrc.slot, pSrc.type);
	if(scrollItem:isBetween(3173, 3181)) then
		return sendToWater(player, waterNEvent, (scrollItem:getId() - 3173) + 1);
	elseif(scrollItem:isBetween(777, 785)) then
		return sendToWater(player, waterMEvent, (scrollItem:getId() - 777) + 1);
	elseif(scrollItem:isBetween(3182, 3190)) then
		return sendToWater(player, waterAEvent, (scrollItem:getId() - 3182) + 1);
	end
	
	return FALSE;
end
