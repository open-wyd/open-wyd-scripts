function OnUse(player, pSrc, pNumber, pDest)
	if(player:hasQuest(global_OWS.questList.BalanceCompound)) then
		iSend.ClientMessage(player, "Você já realizou a quest)");
		return FALSE;
	end
	
	if (player:getLevel() < 119 or player:getLevel() > 124 or player:getPromotionId() ~= 0) then
		iSend.ClientMessage(player, "Esta quest é apenas para mortais (120-125)");
		return FALSE;
	end
	
	local totalSpecialPoints = 0;
	for specialId = 0, 3, 1 do
		local currentSpecial = player:getBaseSpecial(specialId);
		local resetedPoints = 0;
		if (currentSpecial < 100) then
			player:setBaseSpecial(specialId, 0);
			resetedPoints = currentSpecial;
		else 
			player:setBaseSpecial(specialId, (currentSpecial - 100));
			resetedPoints = 100;
		end
		totalSpecialPoints = totalSpecialPoints + resetedPoints;
	end
	
	player:setSpecialBonus(player:getSpecialBonus() + totalSpecialPoints);
	
	player:doBuildCurrentScore();
	player:addQuest(global_OWS.questList.BalanceCompound);
	iSend.Etc(player);
	
	return TRUE;
end