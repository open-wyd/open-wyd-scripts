
local UnicornRules = {
	[10] = {reqItemId = 917, repItemId = 939},
	[11] = {reqItemId = 923, repItemId = 943},
	[12] = {reqItemId = 918, repItemId = 940},
}

function OnUse(npc, player, confirm)

	local namePlayer = player:getName()

    if(player:hasQuest(global_OWS.questList.Unicorn)) then
        iSend.Say(npc, namePlayer..", você já realizou a quest!");
        return;
    end
	
	
	local rule = UnicornRules[npc:getLevel()];
	local itemAttr = iItems.GetItemById(rule.reqItemId);
	
	
	local handledItem = player:getRight();
		if ((handledItem == nil) or (handledItem:getId() ~= rule.reqItemId))  then
			handledItem = player:getLeft();
		end
		
		if ((handledItem == nil) or (handledItem:getId() ~= rule.reqItemId)) then
			iSend.Say(npc, namePlayer.." traga-me o item "..itemAttr:getName().."+6");
			return;
		end
		
		if (iItems.GetItemSanc(handledItem) ~= 6) then
			iSend.Say(npc, namePlayer.." refina o "..itemAttr:getName().." até +6");
			return;
		end
	
	handledItem:reset(rule.repItemId);
	
	iSend.Equip(player);
	iSend.Score(player);
	iSend.Item(player, 0, 6, player:getRight());
	iSend.Item(player, 0, 7, player:getLeft());
	
	player:addQuest(global_OWS.questList.Unicorn);
	iSend.Say(npc, "Você realizou a quest.");

end