local putItem = CItem:new();

-- 36 Treinador 1 - Entrega pote de HP/MP
-- 40 Treinador 2 - Da adicional a arma.
-- 41 Treinador 3 - Adicional no Set e refina para +6
-- 43 Chefe de Treino - Troca itens do Boss

local TrainerRules = {};

TrainerRules[36] = { 

	check = function(self, player, npc)
		local fItem = FindItem:new(player);
		if(fItem:findItemId(self.eventItemId, 1) > 0) then
			fItem:resume();
			return true;
		end
		return false;
	end,

	onAction = function(self, player, npc)
		
		putItem:reset();
		putItem:setId(400);
		putItem:setAddValue(EF_AMOUNT, 5);
		
		if(iGameServer.PutItem(player, putItem) == false) then
			iSend.ClientMessage(player, "Inventario esta sem espaço.");
			return false;
		end
		
		putItem:setId(405);
		
		iGameServer.PutItem(player, putItem);
		return true;
	end,
	eventItemId = 451,
	eventFlag = global_OWS.questList.TrainerOfNewbier_Trainer1
};

TrainerRules[40] = {

	check = function(self, player, npc)
		local fItem = FindItem:new(player);
		if(fItem:findItemId(self.eventItemId, 1) > 0) then
			fItem:resume();
			return true;
		end
		return false;
	end,

	onAction = function(self, player, npc)
		
		local weaponList = {{slotId = 7, item = player:getLeft()}, {slotId = 6, item = player:getRight()}};
		local itemLogDumpStr = "";
		local isSuccess = false;
		
		for _, slotBlock in pairs(weaponList) do
			if(slotBlock.item:getId() ~= 0) then
				local itemDumpStr = iItems.GetItemDumpStr(slotBlock.item);
				
				local itemAttr = iItems.GetItemById(slotBlock.item:getId());
				iItems.SetItemBonus(slotBlock.item, itemAttr:getReqLvl(), 1, player.DropBonus);
				
				slotBlock.item:setAddValue(0, EF_SANC, 6);
				
				iSend.Item(player, ITEM_PLACE_EQUIP, slotBlock.slotId, slotBlock.item);
				
				itemLogDumpStr = itemLogDumpStr.." / ".. iItems.GetItemDumpStr(slotBlock.item);
				isSuccess = true;
			end
		end
		
		if(isSuccess) then
			iSend.Say(npc, player:getName()..", isto lhe dara força");
			iLog("Trainer2["..player:getName().."] {"..itemLogDumpStr.."}");
			
			player:doBuildCurrentScore();
			iSend.Equip(player);
			iSend.Score(player);
		end
		
		return isSuccess;
	end,
	eventItemId = 452,
	eventFlag = global_OWS.questList.TrainerOfNewbier_Trainer2
};

TrainerRules[41] = {
	
	check = function(self, player, npc)
		local fItem = FindItem:new(player);
		if(fItem:findItemId(self.eventItemId, 1) > 0) then
			fItem:resume();
			return true;
		end
		return false;
	end,
	
	onAction = function(self, player, npc)

		local equipList = {{slotId = 1, item = player:getHelmet()},
						   {slotId = 2, item = player:getArmor()}, 
						   {slotId = 3, item = player:getPants()},
						   {slotId = 4, item = player:getGloves()},
						   {slotId = 5, item = player:getBoots()}};
		local itemLogDumpStr = "";
		local isSuccess = false;
		
		for _, slotBlock in pairs(equipList) do
			
			
			if(slotBlock.item:getId() ~= 0) then
				local itemDumpStr = iItems.GetItemDumpStr(slotBlock.item);
				
				-- local itemAttr = iItems.GetItemById(slotBlock.item:getId());
				-- iItems.SetItemBonus(slotBlock.item, itemAttr:getReqLvl(), 1, player.DropBonus);
				-- Necessario colocar os adicionais.
				
				slotBlock.item:setAddValue(0, EF_SANC, 6);
				
				iSend.Item(player, ITEM_PLACE_EQUIP, slotBlock.slotId, slotBlock.item);
				
				itemLogDumpStr = itemLogDumpStr.." / ".. iItems.GetItemDumpStr(slotBlock.item);
				isSuccess = true;
			end
		end
		
		if(isSuccess) then
			iSend.Say(npc, "....");
			iLog("Trainer3["..player:getName().."] {"..itemLogDumpStr.."}");
			
			player:doBuildCurrentScore();
			iSend.Equip(player);
			iSend.Score(player);
		end
		
		return isSuccess;
	end,
	eventItemId = 453,
	eventFlag = global_OWS.questList.TrainerOfNewbier_Trainer3
};

TrainerRules[43] = {

	check = function(self, player, npc)
		local fItem = FindItem:new(player);
		if(fItem:findItemId(self.eventItemId, 1) > 0) then
			fItem:clearItems(1);
			fItem:resume();
			return true;
		end
		return false;
	end,
	
	onAction = function(self, player, npc)
		
		local treasureList = {{id=653, unit=1}, {id=481, unit=1}, {id=400, unit=20}}
		local treasure = treasureList[math.random(1, 3)]; 
		
		putItem:reset(treasure.id);
		if(treasure.unit > 1) then
			putItem:setAddValue(EF_AMOUNT, treasure.unit);
		end
		
		return iGameServer.PutItem(player, putItem);
	end,
	eventItemId = 524,
	eventFlag = global_OWS.questList.TrainerOfNewbier_Leader
};

function OnUse(npc, player, confirm)

	local trainerRule = TrainerRules[npc:getMerchant()];
	
	if(trainerRule == nil) then
		Ilog("wrong trainer ruleId "..npc:getMerchant());
		return FALSE;
	--elseif(player:hasQuest(trainerRule.eventFlag)) then
	--	iSend.Say(npc, "Ja realizou esta quest.");
	elseif(trainerRule:check(player, npc) == false) then
		local itemAttr = iItems.GetItemById(trainerRule.eventItemId);
		iSend.Say(npc, "Traga-me o item: "..itemAttr:getName());
	elseif(trainerRule:onAction(player, npc)) then
		player:addQuest(trainerRule.eventFlag);
		iSend.Say(npc, "Você realizou a quest.");
		return TRUE;
	end
	
	return FALSE;
end
