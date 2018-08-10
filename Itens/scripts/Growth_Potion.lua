function getGrowthIdByMountId( mountId )
	if( mountId >= 2333 and mountId <= 2335 ) then
		return 1;
	elseif( mountId >= 2336 and mountId <= 2338 or mountId >= 2341 and mountId <= 2343 ) then
		return 2;
	elseif( mountId >= 2339 and mountId <= 2340 or mountId >= 2344 and mountId <= 2345 ) then
		return 3;
	elseif( mountId >= 2346 and mountId <= 2348 ) then
		return 4;
	elseif( mountId >= 2351 and mountId <= 2353 ) then
		return 5;
	elseif( mountId >= 2354 and mountId <= 2356 ) then
		return 6;
	elseif( mountId >= 2349 and mountId <= 2350 ) then
		return 7;
	else
		return 0;
	end
end
function OnUse(player, pSrc, pNumber, pDest)
	local mountItem = player:getMount();
	local vits = mountItem:getMountLife();
	local newLife;
	if(	pDest.type == 0 and pDest.slot == 14 ) then
		if( mountItem:isBetween(2330, 2359) == true ) then
			if( getGrowthIdByMountId(mountItem:getId()) == (pSrc.itemId - 3343) ) then
				if( mountItem:getMountHp( ) > 0 ) then
					if( vits >= 1 ) then
						mountItem:setId(mountItem:getId() + 30);
						mountItem:setMountHp( 20000 );
						mountItem:setMountFeed( 100 );
						mountItem:setMountLife(math.random(1, 20) + vits);
						mountItem:setMountLevel(0);
						mountItem:setMountExp(0);						
						iSend.ClientMessage(player, MessageStringTable._NN_Mount_Growth);
						iGameServer.MountProcess(player, nil);
						iSend.Emotion(player, 14, 3);
						iSend.Item(player, pDest.type, pDest.slot, mountItem);
						iSend.ClientMessage(player, "!Montaria virou Adulta! Ela tem ["..math.floor(mountItem:getMountLife()).."] Vit's. Não esqueça de dar ração!");
						return TRUE;						
					else
						iSend.ClientMessage(player, "Vitalidade inválida para usar Catalisador, precisa ter 1 ou mais." );
					end
				else
					iSend.ClientMessage(player, "Montaria está morta. Precisa estar viva para tornar Montaria.");
				end
			else
				iSend.ClientMessage(player, "Este catalizador não é desta montaria.");
			end
		else
			iSend.ClientMessage(player, "Somente para crias de montarias.");
		end
	end
	return FALSE;
end
