local function getFeedIdByFeedItemId(feedItemId)
	if(feedItemId >= 3367) then 
		return (feedItemId - 3367) % 30;
	else
		return (feedItemId - 2420) % 30;
	end
end

local function getFeedIdByMountId(mountItemId)
	local mountId = (mountItemId - 2330) % 30;
	if ((mountId >= 6 and mountId <= 15) or mountId == 27) then
		return 6;
	elseif (mountId == 19) then
		return 7;
	elseif (mountId == 20) then
		return 8;
	elseif (mountId == 21 or mountId == 22 or mountId == 23 or mountId == 28) then
		return 9;
	elseif (mountId == 24 or mountId == 25 or mountId == 26) then
		return 10;
	elseif (mountId == 29) then
		return 19;
	end
	return mountId;
end

function OnUse(player, pSrc, pNumber, pDest)
	
	if (pDest.type ~= 0 or pDest.slot ~= 14) then
		return FALSE;
	end

	local mountItem = player:getMount();
	if (mountItem:isBetween(2330, 2390) == false or mountItem:getMountHp() <= 0) then
		return FALSE;
	end
	
	local mountFeedId = getFeedIdByMountId(mountItem:getId());
	local feedId = getFeedIdByFeedItemId(pSrc.itemId);
	
	if (mountFeedId ~= feedId) then
		iSend.ClientMessage(player, MessageStringTable._NN_Mount_Not_Match);
		return FALSE;
	end
	
	local mountHp = mountItem:getMountHp();
	if ((mountHp + 5000) > 30000) then
		mountItem:setMountHp(30000);
	else
		mountItem:setMountHp(mountHp + 5000);
	end
	
	mountItem:setMountFeed(mountItem:getMountFeed() + 2);
	
	if (mountItem:isBetween(2330, 2360)) then
		iGameServer.MountProcess(player, nil);
	elseif (mountItem:isBetween(2360, 2390)) then
		iGameServer.ProcessAdultMount(player, nil);
	end
	
	iSend.ClientSignalParm(player, global_OWS.protocol.defines.ESCENE_FIELD, global_OWS.protocol.opcode.MSG_SoundEffect, 270);
	iSend.Item(player, pDest.type, pDest.slot, mountItem);

	return TRUE;
end
