local putItem = CItem:new();

function OnUse(npc, player, confirm)
	
	local familiar = player:getFamiliar();
	if (familiar:getId() == 447 or familiar:getId() == 692) then
		
		local price = 0;
		if (familiar:getId() == 447) then
			price = 1000000;
		else
			price = 5000000;
		end
		
		local coin = player:getCoin();
		if (coin >= price) then

			familiar:setId(iRandomNumber(1, 4) + familiar:getId());
			
			player:setCoin(coin - price);
			
			iSend.Item(player, ITEM_PLACE_EQUIP, 13, familiar);
			iSend.Etc(player);
			iSend.Say(npc, "Processo completado com sucesso!");
			player:addSkillCondition(44, 20, 20, __sConditionAffect);
			iSend.Score(player);
			
			iLog("etc,jeffi make reset50-100 name:"..player:getName().." level:%d"..player:getLevel());
		else
			if (price == 1000000) then
				iSend.Say(npc, "Voce precisa de 1 milhao (1kk) de gold.");
			else
				iSend.Say(npc, "Voce precisa de 5 milhoes (5kk) de gold.");
			end
		end
	else
		
		local coin = player:getCoin();
		
		if(coin < 1000000) then
			iSend.Say(npc, "Voce precisa de 1 milhao (1kk) de gold.");
			return;
		end
		
		local actionList = 
		{
			{fItem = FindItem:new(player), fItemId = 419, transform = 412, total = 0},
			{fItem = FindItem:new(player), fItemId = 420, transform = 413, total = 0}
		};
		
		local success = false;
		
		for key, value in pairs(actionList) do
			
			local count = value.fItem:findItemID(value.fItemId, 10000);
			if(count >= 10) then
				
				value.total = math.floor(count / 10);
				value.fItem:clearItems(value.total * 10);
				
				count = value.total;
				repeat
				   	putItem:reset();
					putItem:setId(value.transform);
					
					local amount = count;
					if(amount > 120) then
						amount = 120;
					end
					
					putItem:setAddValue(EF_AMOUNT, amount);
					iGameServer.PutItem(player, putItem);
					
					count = (count - amount); 
					
				until( count <= 0 )
				
				success = true;
			end
		
		end
		
		if(success == false) then
			iSend.Say(npc, "Entregue-me os itens corretos para a troca.");
			return;
		end
		
		iSend.Say(npc, "Processo completado com sucesso!");
		
		player:setCoin(coin - 1000000);
		player:addSkillCondition(44, 20, 20, __sConditionAffect);
		
		iSend.Score(player);
		iSend.Carry(player);
		iSend.Etc(player);

		--iLog("etc,jeffi make lac [".. actionList[0].count .."] ori [".. actionList[1].count .."] name:"..player:getName().." level:"..player:getName());
	end
end
