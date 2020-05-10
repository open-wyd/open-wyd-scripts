	function OnUse(player, pSrc, pNumber, pDest)

	if (player:getLevel() < 199 or player:getLevel() > 205 or player:getPromotionId() ~= 0) then
		iSend.ClientMessage(player, "Esta quest é apenas para mortais (200-205)");
		return false;
	end
	
	if 	(player:hasQuest(global_OWS.questList.MolarGargol))then
		iSend.ClientMessage(player, "Você já realizou esta quest.");
		return false;
	end

	
	local item, sancValue;
	local setSanc = 4;
	
	local i=1;
	while i<= 5 do
		item = player:getItem(i, 0);
		sancValue = iItems.GetItemSanc(item);
		if( sancValue < setSanc )then
			iItems.SetItemSanc(item, setSanc, 0);
			iSend.Item(player, 0, i, item);
		end
		i=i+1;
	end
	
	player:addQuest(global_OWS.questList.MolarGargol);
	iSend.ClientMessage(player, "Quest realizada!");
	
	return TRUE;
end