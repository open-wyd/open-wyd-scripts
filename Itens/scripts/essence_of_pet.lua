local MOUNT_ITEM_BASE_ID   = 2330  -- ID base dos mounts (range: 2330-2390)
local MOUNT_ITEM_YOUNG_MAX = 2360  -- Mounts jovens: 2330-2359
local MOUNT_ITEM_ADULT_MAX = 2390  -- Mounts adultos: 2360-2389
local MOUNT_MAX_LEVEL      = 120   -- Nível máximo para mounts adultos
local ESSENCE_BASE_ID      = 2390  -- ID base das essências de pet

local SancRateList = {100, 80, 60, 40, 20, 10, 10, 10, 5, 5, 5, 5};

local function getEssencePetIdByMountId(mountItemId)
	local mountId = (mountItemId - MOUNT_ITEM_BASE_ID) % 30;
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
	if (mountItem:isBetween(MOUNT_ITEM_BASE_ID, MOUNT_ITEM_ADULT_MAX) == false or mountItem:getMountHp() <= 0) then
		return FALSE;
	end
	
	if (getEssencePetIdByMountId(mountItem:getId()) ~= ((pSrc.itemId - ESSENCE_BASE_ID) % 30)) then
		iSend.ClientMessage(player, MessageStringTable._NN_Mount_Not_Match);
		return FALSE;
	end
	
	local level = mountItem:getMountLevel();
	if (level >= MOUNT_MAX_LEVEL and mountItem:isBetween(MOUNT_ITEM_YOUNG_MAX, MOUNT_ITEM_ADULT_MAX)) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Upgrade_More);
		iGameServer.ProcessAdultMount(player, nil);
		return FALSE;
	end
	
	mountItem:setMountHp(20000);
	mountItem:setMountFeed(100);
	
	if (mountItem:isBetween(MOUNT_ITEM_YOUNG_MAX, MOUNT_ITEM_ADULT_MAX)) then
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
			return TRUE;
		end
		
		iLog("Mount refine success "..mountItem:getId().."+"..mountItem:getMountLevel().." ["..player:getName().." / "..iItems.GetItemDumpStr(mountItem).."]");
	end
	
	level = level + 1;
	mountItem:setMountLevel(level);
	mountItem:setMountExp(1);
	
	if ((level >= 25 and mountItem:getId() == MOUNT_ITEM_BASE_ID) or (level >= 35 and mountItem:getId() == MOUNT_ITEM_BASE_ID + 1) or (level >= 100 and mountItem:isBetween(MOUNT_ITEM_BASE_ID + 2, MOUNT_ITEM_YOUNG_MAX))) then
		
		mountItem:setId(mountItem:getId() + 30);
			
		mountItem:setMountLife(math.random(1, 20 + level));
		mountItem:setMountLevel(0);
		mountItem:setMountExp(0);
		 
		iSend.ClientMessage(player, MessageStringTable._NN_Mount_Growth);
		iGameServer.MountProcess(player, mountItem);
	end

	iSend.Emotion(player, 14, 3);

	if (mountItem:isBetween(MOUNT_ITEM_BASE_ID, MOUNT_ITEM_YOUNG_MAX)) then
		iGameServer.MountProcess(player, mountItem);
	elseif (mountItem:isBetween(MOUNT_ITEM_YOUNG_MAX, MOUNT_ITEM_ADULT_MAX)) then
		iGameServer.ProcessAdultMount(player, 0);
	end
	
	iSend.Item(player, pDest.type, pDest.slot, mountItem);
	
	return TRUE;
end
