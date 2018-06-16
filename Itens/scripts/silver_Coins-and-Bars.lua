function OnUse(player, pSrc, pNumber, pDest)
	local coin = player:getCoin();
	local itemid = math.floor(pSrc.itemId);
	local coins = {1000000, 5000000, 10000000, 50000000};	--itemid: 4026, 4027, 4028, 4029
	local bars = {100000000, 1000000000};					--itemid: 4010, 4011
	local value;
	
	if( itemid >= 4026 and itemid <= 4029 ) then
		value = coins[itemid-4025];
	elseif( itemid == 4010 or itemid == 4011) then
		value = bars[itemid-4009];
	end
	
	if( coin+value < 2000000000 ) then
		player:setCoin(coin+value);
		iSend.Etc(player);
		iSend.ClientMessage(player, "Ganhou "..math.floor(value/1000000).."kk em GOLD.");
		return TRUE;
	else
		iSend.ClientMessage(player, "Libere mais espaço em GOLD no seu inventário.");
		return FALSE;
	end
end