local lastUsePotion = {};

local function canUsePotion(player)
	local cTime = iGetCurrentTime();
	local lastUse = lastUsePotion[player:getId()];
	
	if(lastUse ~= nil and (cTime - lastUse) < 500) then
		return false;
	end
	
	lastUsePotion[player:getId()] = cTime;
	return true;
end

function OnUse(player, pSrc, pNumber, pDest)

	if(canUsePotion(player) == false) then
		return FALSE;
	end
	
	local itemAttr = iItems.GetItemById(pSrc.itemId);
	
	if (player:getHp() > 0) then
		player:addRecoveryHp(itemAttr:getEffect(EF_HP));
	end
	
	local mp = itemAttr:getEffect(EF_MP);
	if (mp > 0) then
		player:addRecoveryMp(mp);
	end
	
	iSend.SetHpMp(player);

	return TRUE;
end
