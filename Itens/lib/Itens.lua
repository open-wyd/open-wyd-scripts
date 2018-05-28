function sendToWater(player, event, level)

	if(player:getCurrentPosition():isBetween(1964, 1772, 1967, 1775)) then
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

function createItem(itemId, effct1, effct2, effct3)
	local item = CItem:new(itemId);
	
	if(effct1 ~= nil) then
		item:setAddValue(0, effct1[1], effct1[2]);
	end
	
	if(effct2 ~= nil) then
		item:setAddValue(1, effct2[1], effct2[2]);
	end
	
	if(effct3 ~= nil) then
		item:setAddValue(2, effct3[1], effct3[2]);
	end
	
	return item;
end

function getClassIdByCorpseId(player)

	local classId = player:getClass();
	if(classId >= 0 and classId <= 3) then
		
		local corpseId = player:getPhace():getId();
		if( corpseId >= 1 and corpseId <= 9 ) then
			return 1;
		elseif( corpseId >= 11 and corpseId <= 19 ) then
			return 2;
		elseif( corpseId >= 21 and corpseId <= 29 ) then
			return 3;
		elseif( corpseId >= 31 and corpseId <= 39 ) then
			return 4;
		else
			return -1;
		end
		
	else
		return -1;
	end
	
	return -1;
end

