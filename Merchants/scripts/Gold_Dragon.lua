local tempItem = CItem:new();

local function CombineTreasureMap(player)
	local fItem = FindItem:new(player);
	
	tempItem:reset(485);
	
	for treasureId=788, 793, 1 do
		local count = fItem:findItemId(treasureId, 120);
		if(count > 0) then
			fItem:clearItems(count);
			fItem:resume();
			tempItem:setAddValue(EF_AMOUNT, count);
			iGameServer.PutItem(player, tempItem);
			iLog("treasureMap, replaced ("..count..") items: "..treasureId.." by item: "..tempItem:getId().." player: "..player:getName());
		end
		fItem:clear();
	end

	if (fItem:getItemsCount() <= 0) then
		return false;
	end
	
	
	iSend.ClientMessage(player, MessageStringTable._NN_Congratulations);
	return true;
end

local TreasureList = 
{
	{
		ItemSourceId = 477;
		Target ={{Rate=200, Item = CItem:new(413), {Rate=400, Item = CItem:new(4019)}, {Rate=600, Item = CItem:new(4026)}, {Rate=800, Item = CItem:new(4027)}, {Rate=1000, Item = CItem:new(478)}}}
	},
	{
		ItemSourceId = 478;
		Target ={{Rate=200, Item = CItem:new(3173), {Rate=400, Item = CItem:new(4020)}, {Rate=600, Item = CItem:new(4028)}, {Rate=800, Item = CItem:new(3314)}, {Rate=1000, Item = CItem:new(479)}}}
	}
}

local function getTreasureByRate(treasure, rate)
    for _, target in pairs(treasure.Target) do
	    if(rate < target.Rate) then
	        return target.Item;
	    end
	end
		
	return nil;
end

function OnUse(npc, player, confirm)
	
	---------------- Treasure map
	if(CombineTreasureMap(player) == true) then
		return;
	end
	
	---------------- Treasures 
	local fItem = FindItem:new(player);
	for _, treasure in pairs(TreasureList) do
		
		if(fItem:findItemId(treasure.ItemSourceId, 1) > 0) then
			
			fItem:clearItems(1);
			fItem:resume();
			
			local probability = math.random(1000);
			local item = getTreasureByRate(treasure, probability);
			
			if(item == nil) then
				iSend.Say(npc, MessageStringTable._NN_Next_Chance);
				iLog("treasure, lost item: "..treasure.ItemSourceId.." player: "..player:getName());
			else
				iSend.Say(npc, MessageStringTable._NN_Congratulations);
				iGameServer.PutItem(player, item);
				iLog("treasure, replaced item: "..treasure.ItemSourceId.." by item: "..item:getId().." player: "..player:getName());
			end
			
			return;
		end
		
	end
	
	---------------- Crystals
	for crystalId=421, 427, 1 do
		if(fItem:findItemId(crystalId, 1) ~= 1) then
			break;
		end
	end
	
	local crystalCount = fItem:getItemsCount();
	if(crystalCount == 7) then
		
		local rightWeapon = player:getRight();
		if(rightWeapon:getId() == 0) then
			iSend.Say(npc, MessageStringTable._NN_Equip_Weapon_To_Enchant);
			return;
		end
		
		local sanc = iItems.GetItemSanc(rightWeapon);
		if(sanc > 0) then
			iSend.Say(npc, MessageStringTable._NN_Only_Nomal_Weapons);
			return;
		end

		if((rightWeapon:getId()/10) == 0) then
			iSend.Emotion(player, 23, 0);
		else
			iSend.Emotion(player, 15, 0);
		end
		
		local itemDumpStr1 = iItems.GetItemDumpStr(rightWeapon);
		
		local itemAttr = iItems.GetItemById(rightWeapon:getId());
		iItems.SetItemBonus(rightWeapon, (25 * crystalCount / 10) + itemAttr:getReqLvl(), 1, player.DropBonus);
		
		local itemDumpStr2 = iItems.GetItemDumpStr(rightWeapon);
		
		fItem:clearItems(crystalCount);
		
		iSend.Carry(player);
		iSend.ClientMessage(player, MessageStringTable._SN_I_Wwill_Enchant_Your_Weapon);

		iSend.Item(player, ITEM_PLACE_EQUIP, 6, rightWeapon);

		iSend.Say(npc, string.format(MessageStringTable._SN_Now_I_Will_Enchant_Your, player:getName()));

		player:addSkillCondition(44, 200, 200, __sConditionAffect);
		iSend.Score(player);

		iLog("etc,crystal "..crystalCount.."-"..rightWeapon:getId().." from "..itemDumpStr1.." to "..itemDumpStr2.." player: "..player:getName());
	else
		fItem:clear();
		iSend.Say(npc, MessageStringTable._NN_Gather_7_Clistals);
	end
end
