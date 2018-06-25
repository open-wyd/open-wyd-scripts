local sancGrade = {1, 1, 1, 1, 1};

function OnUse(player, pSrc, pNumber, pDest)
	
	local item = player:getItem(pDest.slot, pDest.type);
	
	if(iItems.GetItemAbility(item, EF_VOLATILE) ~= 0) then
		iSend.ClientMessage(player, MessageStringTable._NN_Only_To_Equips);
		return false;
	end
	
	if (iItems.GetItemAbility(item, EF_NOSANC) ~= 0) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Refine_More);
		return false;
	end
	
	if (item:isBetween(2300, 2330) and iItems.GetBonusItemAbility(item, EF_INCUDELAY) > 0) then
		iSend.ClientMessage(player, MessageStringTable._NN_Incu_Wait_More);
		return false;
	end

	local sancValue = iItems.GetItemSanc(item);
	if (sancValue < 0 or sancValue >= 6) then
		iSend.ClientMessage(player, MessageStringTable._NN_Cant_Refine_More);
		return false;
	end

	if (sancValue == 0) then
		local addSlot = item:getSlotByAdd(EF_SANC);
		if(addSlot < 0) then
			addSlot = item:getSlotByAddRange(116, 125);
			if(addSlot < 0) then
				addSlot = item:getSlotByAdd(0);
			end
		end
		
		if(addSlot < 0) then
			iSend.ClientMessage(player, MessageStringTable._NN_Cant_Refine_More);
			return false;
		end
		
		item:setAddValue(addSlot, EF_SANC, 0);
	end

	local rateSucess = iItems.GetSuccessRate(item, 0) - math.random(0, 100);
	if (rateSucess >= 0) then

		local ItemGrade = iItems.GetItemAbility(item, EF_ITEMLEVEL);
		if (ItemGrade >= 1 and ItemGrade <= 5) then
			sancValue = sancValue + sancGrade[ItemGrade];
			if (sancValue >= 6) then
				sancValue = 6;
			end
		else
			sancValue = sancValue + 1;
		end

		iItems.SetItemSanc(item, sancValue, 0);
		
		player:doBuildCurrentScore();
		iSend.Score(player);
		
		iLog(string.format("refine success %d+%d - %d", item:getId(), sancValue, item:getSlotByAdd(EF_SANC)));

		iSend.ClientMessage(player, MessageStringTable._NN_Refine_Success);

		if (item:isBetween(2300, 2330)) then
			item:setAddValue(2, EF_INCUDELAY, math.random(1,9));

			local incubate = iItems.GetBonusItemAbility(item, EF_INCUBATE);

			if (sancValue >= incubate) then
				item:setId(item:getId() + 30);
				
				item:setMountHp(20000)
				item:setMountLevel(1)
				item:setMountLife(math.random(10, 30));
				item:setMountFeed(30);
				item:setMountExp(1);

				iSend.ClientMessage(player, MessageStringTable._NN_INCUBATED);
				iGameServer.MountProcess(player, item);
			end
		end
		
		iSend.Emotion(player, 14, 3);
		
	else
		iSend.ClientMessage(player, string.format("%s", MessageStringTable._NN_Fail_To_Refine));
		
		iLog(string.format("Refine fail %d+%d - %d", item:getId(), sancValue, item:getSlotByAdd(EF_SANC)));

		local sancsucess = iItems.GetItemSancSuccess(item);
		if (math.random(0, 4) <= 2) then
			if (sancValue <= 5) then
				sancsucess = sancsucess + 1;
			end
		end
		
		iItems.SetItemSanc(item, sancValue, sancsucess);

		if ((player:getPhace():getId() / 10) == 0) then
			iSend.Emotion(player, 15, 0);
		else
			iSend.Emotion(player, 20, 0);
		end
	end
	
	iSend.Item(player, pDest.type, pDest.slot, item);
	
	return TRUE;
end
