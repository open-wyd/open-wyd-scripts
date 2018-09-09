function OnUse(player, pSrc, pNumber, pDest)
	local mountItem = player:getMount();
	local vits = mountItem:getMountLife();
	local randomVits = math.random(1,3);
	if(	pDest.type == 0 and pDest.slot == 14 ) then
		if( mountItem:isBetween(2360, 2389) == true ) then
			if( getMountScriptId(mountItem:getId()) == (pSrc.itemId - 3350) ) then
				if( mountItem:getMountHp( ) > 0 ) then
					if( vits >= 1 ) then
						mountItem:setMountHp( 20000 );
						mountItem:setMountFeed( 100 );
						mountItem:setMountLife( vits + randomVits );
						iSend.ClientMessage(player, "!Sua montaria acaba de ganhar ["..randomVits.."] Vit's.");
						iGameServer.MountProcess(player, nil);
						iSend.Emotion(player, 14, 3);
						iSend.Item(player, pDest.type, pDest.slot, mountItem);
						return TRUE;						
					else
						iSend.ClientMessage(player, "Vitalidade inválida para usar Restaurador, precisa ter 1 ou mais." );
					end
				else
					iSend.ClientMessage(player, "Montaria está morta. Precisa estar viva para usar Restaurador.");
				end
			else
				iSend.ClientMessage(player, "Este Restaurador não é desta montaria.");
			end
		else
			iSend.ClientMessage(player, "Somente para montarias adultas.");
		end
	end
	return FALSE;
end