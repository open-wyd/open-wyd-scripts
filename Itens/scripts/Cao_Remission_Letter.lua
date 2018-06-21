function OnUse( player, pSrc, pNumber, pDest)
	local CP = player:getPKPoint();
	
	if( CP < 150 ) then
		player:setPKPoint(150);
		iSend.PKInfo(player);
		if ((player:getPhace():getId() / 10) == 0) then
			iSend.Emotion(player, 15, 0);
		else
			iSend.Emotion(player, 20, 0);
		end
		return TRUE;
	else
		iSend.ClientMessage(player, "Seu CP já está no máximo.")
	end
	
	return FALSE
end