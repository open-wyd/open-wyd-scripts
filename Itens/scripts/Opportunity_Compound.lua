function OnUse(player, pSrc, pNumber, pDest)
	if(player:hasQuest(global_OWS.questList.OpportunityCompound)) then
		iSend.ClientMessage(player, "Você já realizou a quest)");
		return FALSE;
	end
	
	if (player:getLevel() < 69 or player:getLevel() > 75 or player:getPromotionId() ~= 0) then
		iSend.ClientMessage(player, "Esta quest é apenas para mortais (70-75)");
		return FALSE;
	end

	local totalSpecialPoints = 0;
	for specialId = 0, 3, 1 do
		local currentSpecial = player:getBaseSpecial(specialId);
		local resetedPoints = 0;
		if (currentSpecial < 50) then
			player:setBaseSpecial(specialId, 0);
			resetedPoints = currentSpecial;
		else 
			player:setBaseSpecial(specialId, (currentSpecial - 50));
			resetedPoints = 100;
		end
		totalSpecialPoints = totalSpecialPoints + resetedPoints;
	end
	
	player:setSpecialBonus(player:getSpecialBonus() + totalSpecialPoints);
	player:doBuildCurrentScore();
	player:addQuest(global_OWS.questList.OpportunityCompound);

	iSend.Etc(player);

	return TRUE;
end