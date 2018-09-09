function OnUse(player, pSrc, pNumber, pDest)
	local mountItem = player:getMount();
	local vits = mountItem:getMountLife();
	if(	pDest.type == 0 and pDest.slot == 14 ) then
		if( mountItem:isBetween(2330, 2359) == true ) then
			if( getMountScriptId(mountItem:getId()) == (pSrc.itemId - 3343) ) then
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