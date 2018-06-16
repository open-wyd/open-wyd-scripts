local inititalRate = 50;

local function getUniqueType(uniqueId)
	if (uniqueId == 5 or uniqueId == 14 or uniqueId == 24 or uniqueId == 34) then
		return 0;
	elseif (uniqueId == 6 or uniqueId == 15 or uniqueId == 25 or uniqueId == 35) then
		return 1;
	elseif (uniqueId == 7 or uniqueId == 16 or uniqueId == 26 or uniqueId == 36) then
		return 2;
	elseif (uniqueId == 8 or uniqueId == 17 or uniqueId == 27 or uniqueId == 37) then
		return 3;
	elseif (uniqueId == 10 or uniqueId == 20 or uniqueId == 30 or uniqueId == 40) then
		return 3;
	end
	
	return -1;
end

function OnUse(player, pSrc, pNumber, pDest)
	
	local oreType = pSrc.itemId - 575;
	if (oreType < 0 or oreType > 3) then
		return FALSE;
	end
	
	local itemAttr = iItems.GetItemById(pDest.itemId);
	local uniqueType = getUniqueType(itemAttr:getUnique());
	if (uniqueType == -1 or uniqueType ~= oreType) then
		iSend.ClientMessage(player, MessageStringTable._NN_Only_Level1_Armor);
		return FALSE;
	end
	
	local gradeId = itemAttr:getGrade();
	if (gradeId <= 0 or gradeId >= 4) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Refine_More);
		return FALSE;
	end
	
	local extraId = itemAttr:getExtra();
	if(extraId <= 0 or extraId > 30000) then
		iLog("OreLengendary, Wrong extraId:"..extraId.." of itemId:"..pDest.itemId);
		return FALSE;
	end
		
	local item = player:getItem(pDest.slot, pDest.type);
	
	local randomNumber = math.random(0, 100);
	if (randomNumber <= inititalRate) then
		item:setId(extraId);
		player:doBuildCurrentScore();
		
		iSend.Item(player, pDest.type, pDest.slot, item);
		iSend.Score(player);
		iSend.Emotion(player, 14, 0);

		iLog(player:getName()..", Ore legendary success from: "..extraId.." to: "..item:getId());
		
		iSend.ClientMessage(player, string.format("%s (%d/%d)", MessageStringTable._NN_Refine_Success, randomNumber, inititalRate));
		
	else
		if ((player:getPhace():getId() / 10) == 0) then
			iSend.Emotion(player, 20, 0);
		else
			iSend.Emotion(player, 15, 0);
		end
	
		iLog(player:getName()..", Ore legendary fail "..item:getId());
		
		iSend.ClientMessage(player, string.format("%s (%d/%d)", MessageStringTable._NN_Fail_To_Refine, randomNumber, inititalRate));
	end
	
	return TRUE;
end
