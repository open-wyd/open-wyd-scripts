local CapeRules = {};

-- 100 (MerchantId) Chefe Treinamento - Troca emblema do aprendiz (4080) por Capa do Aprendiz (4006)

CapeRules[100] = {

	check = function(self, player, npc)
		if (player:getLevel() < 100 or player:getLevel() > 150 or player:getPromotionId() ~= 0) then
			iSend.Say(npc, "Esta quest é apenas para mortais (101-105)");
			return false;
		end
		
		if (player:getMantle():getId() ~= 0) then
			iSend.Say(npc, "Voce ja possui capa.");
			return false;
		end
		
		if (player:getFamiliar():getId() ~= 4080) then
			local itemAttr = iItems.GetItemById(4080);
			iSend.Say(npc, "Traga-me o item: "..itemAttr:getName());
			return false;
		end
		
		return true;
	end,
	
	onAction = function(self, player, npc)
		player:getMantle():setId(4006);
		player:getFamiliar():reset();
		
	end
};


function OnUse(npc, player, confirm)

	local capeRule = CapeRules[npc:getMerchant()];
	if(capeRule == nil) then
		Ilog("wrong cape ruleId "..npc:getMerchant());
		return FALSE;
	end
	
	if(capeRule:check(player, npc)) then
		capeRule:onAction(player);
		
		player:doBuildCurrentScore();
		
		iSend.Equip(player);
		iSend.Score(player);
		iSend.Item(player, 0, 13, player:getFamiliar());
		iSend.Item(player, 0, 15, player:getMantle());
		iSend.Say(npc, "Você realizou a quest.");
	end
end
