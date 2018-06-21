function OnUse( player, pSrc, pNumber, pDest)
	local mount = player:getMount();
	local ref = iItems.GetItemSanc(mount);
	
	if( mount:isBetween(2300, 2330) and pDest.type == 0 and pDest.slot == 14 ) then
		if( iItems.GetBonusItemAbility(mount, EF_INCUDELAY) >= 1 ) then
			--organiza os adds e zera o EF_INCUDELAY
			mount:setAddValue(1, EF_SANC, ref);
			mount:setAddValue(2, EF_INCUDELAY, 0);
			mount:setAddValue(3, 0, 0);
			iSend.ClientMessage(player, "Tempo de incubação zerado! Agora refine com Poeira de Ori ou Lac.");
			iSend.Item(player, pDest.type, pDest.slot, mount);
			return TRUE;
		else
			iSend.ClientMessage(player, "Tempo de incubação já está zerado, refine com Poeira de Ori ou Lac.");
		end
	else
		iSend.ClientMessage(player, "Uso exclusivo em Ovos de montaria.");	
	end
	
	return FALSE;
end