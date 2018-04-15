function OnUse(npc, player, confirm)
	
	local mount = player:getMount();
	if (mount:isBetween(2330, 2390) == false) then
		iSend.Say(npc, "Você não possui uma montaria valida.");
		return;
	end
	
	if (mount:getValue(0) > 0) then
		iSend.Say(npc, "A montaria ainda está viva!");
		return;
	end
	
	local itemAttr = Items.GetItemById(mount:getId());
	local price = itemAttr:getPrice();
	
	if (confirm == 0) then
		iSend.Say(npc, "Para reviver ["..itemAttr:getName().."] sera necessario "..price.." de gold.");
		return;
	end
	
	if (player.Coin < price) then
		iSend.Say(npc, "Nao possui gold sufuciente!");
		return;
	end

	if (price < 0 or price > 2000000000) then
		iLog("etc, ["..player:getName().."] mount ressurect index:"..mount:getId().." Wrong price:"..price);
		return;
	end

	player.Coin = (player.Coin - price);

	local vitality = (iItems.GetItemAbility(mount, 79) - iRandomNumber(0, 3));

	if (vitality > 0) then
		iSend.Say(npc, "Ele foi Curado");
		mount:setValue(0, 20);
		mount.stEffect[1].cValue = vit;
		mount.stEffect[2].cEffect = 5;
	else
		iSend.Say(npc, "Desculpe, nao pude salva-lo.");
		mount:reset();
	end
	
	player:doBuildCurrentScore();
	iGameServer.MountProcess(player, nil);
	
	iSend.Item(player, ITEM_PLACE_EQUIP, 14, mount);
	iSend.Score(player);
	iSend.Etc(player);

	iLog("etc, ["..player:getName().."] mount ressurect index:"..mount:getId().." vit:"..vitality.." - "..mount.stEffect[1].cEffect);
end
