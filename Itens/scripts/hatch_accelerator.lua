function OnUse( player, pSrc, pNumber, pDest)
	local item = player:getMount();
	
	if( item:isBetween(2300, 2330) and pDest.type == 0 and pDest.slot == 14 ) then
		local INCUBATE = iItems.GetBonusItemAbility(item, EF_INCUBATE);
		local SANC = iItems.GetItemSanc(item);
		if( INCUBATE > SANC+1 ) then
			local INCUDELAY = math.random(1,9);
			item:setAddValue(0, EF_SANC, SANC+1);
			item:setAddValue(1, EF_INCUBATE, INCUBATE);
			item:setAddValue(2, EF_INCUDELAY, INCUDELAY);
			iSend.ClientMessage(player, MessageStringTable._NN_Refine_Success);
		else
			item:setId(item:getId() + 30);
			item:setMountHp(20000)
			item:setMountLevel(1)
			item:setMountLife(math.random(10, 30));
			item:setMountFeed(30); 
			item:setMountExp(1);
			iSend.ClientMessage(player, MessageStringTable._NN_INCUBATED);
			iGameServer.MountProcess(player, item);	
		end
		
		iSend.Emotion(player, 14, 3);
		iSend.Item(player, pDest.type, pDest.slot, item);		
		return TRUE;
	else
		iSend.ClientMessage(player, "Uso exclusivo em Ovos de montaria.");
	end
	
	return FALSE;
end
