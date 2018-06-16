local SancRateList = {100, 80, 60, 40, 20, 10, 10, 10, 5, 5, 5, 5};

local function getEssencePetIdByMountId(mountItemId)
	local mountId = (mountItemId - 2330) % 30;
	if(mountId == 28) then	  -- Fixed id for Sleipnir
		mountId = 21;
	elseif(mountId == 27) then -- Fixed id for Svadilfire
		mountId = 10;
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

	if (getEssencePetIdByMountId(mountItem:getId()) ~= ((pSrc.itemId - 2390) % 30)) then
		iSend.ClientMessage(player, MessageStringTable._NN_Mount_Not_Match);
		return FALSE;
	end

	local level = mountItem:getMountLevel();
	if (level >= 120 and mountItem:isBetween(2360, 2390)) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Upgrade_More);
		iGameServer.ProcessAdultMount(player, nil);
		return FALSE;
	end
	
	mountItem:setMountHp(20000);
	mountItem:setMountFeed(100);
	
	if (mountItem:isBetween(2360, 2390)) then
		local rate = SancRateList[math.floor((mountItem:getMountLevel()/10) + 1)];
		local randomRate = math.random(0, 101);
		
		if (randomRate > rate) then
			if ((player:getPhace():getId() / 10) == 0) then
				iSend.Emotion(player, 15, 0);
			else
				iSend.Emotion(player, 20, 0);
			end
			
			iSend.ClientMessage(player, MessageStringTable._NN_Fail_To_Refine);
			
			if (level > 0 and math.random(0, 5) == 0) then
				mountItem:setMountLevel(level - 1);
			end

			iLog("Mount refine fail "..mountItem:getId().."+"..mountItem:getMountLevel().." ["..player:getName().." / "..iItems.GetItemDumpStr(mountItem).."]");
			
			iGameServer.ProcessAdultMount(player, 0);
			iSend.Item(player, pDest.type, pDest.slot, mountItem);
			return;
		end
		
		iLog("Mount refine success "..mountItem:getId().."+"..mountItem:getMountLevel().." ["..player:getName().." / "..iItems.GetItemDumpStr(mountItem).."]");
	end

	level = level + 1;
	mountItem:setMountLevel(level);
	mountItem:setMountExp(1);

	if ((level >= 25 and mountItem:getId() == 2330) or (level >= 35 and mountItem:getId() == 2331) or (level >= 100 and mountItem:isBetween(2332, 2360))) then
		
		mountItem:setId(mountItem:getId() + 30);
			
		mountItem:setMountLife(math.random(1, 20 + level));
		mountItem:setMountLevel(0);
		mountItem:setMountExp(0);
		 
		iSend.ClientMessage(player, MessageStringTable._NN_Mount_Growth);
		iGameServer.MountProcess(player, nil);
	end

	iSend.Emotion(player, 14, 3);

	if (mountItem:isBetween(2330, 2360)) then
		iGameServer.MountProcess(player, nil);
	elseif (mountItem:isBetween(2360, 2390)) then
		iGameServer.ProcessAdultMount(player, 0);
	end
	
	iSend.Item(player, pDest.type, pDest.slot, mountItem);
	
	return TRUE;
end
