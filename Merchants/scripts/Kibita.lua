-- *Bônus de caça -> Caçando no canal em que se é cidadão, você receberá 10% de bônus de drop
-- *Caso kefra seja morto no serve da qual você pertence a taxa subirá para 20% e a cada 100x000x000 de xp recebida subirá mais 1% de bonus drop.
-- * Se o bonus de drop alcanaçar 80% a xp recebida irá aumentar.


-- Cidadania
---- Taxa de registro de Cidadão para personagem Mortal:
---- (level do personagem) x 10.000 Gold
---- Exemplo: (Lvl 70) x 10.000 = 700.000 Gold
 
---- Taxa de registro de Cidadão para personagem Arch:
---- (level do personagem + 200) x 10.000 Gold
---- Exemplo: (Lvl 70 + 200) x 10.000 = 2.700.000 Gold
	

-- Skill Soul (Necessário ser cidadão do canal.)
---- (5334) Transknight = Água
---- (5335) Foema = Sol
---- (5336) Beastmaster = Terra
---- (5337) Huntress = Vento

---		Mortais
----		Permanente
----			Só para mortais com o level superior a 370
---				Possui a pedra secreta de acordo com classe (Esta será consumida.)
----		Temporario (1h de uso)
----			Não colcoa uma Skill, é apenas adicionado um Buffer/Condition
----			A Kibita só disponibiliza a funcionalidade no intervalo de horário das 9 AM até as 21 PM
----			Só pode ser para mortais até o level 370
----			Será necessário possui um resto de Lac
----			Obs.: por um parametro para definir o bonus por config

function OnUse(npc, player, confirm)
	
	local citizenshipId = player:getCitizenshipId();
	if(citizenshipId == 0) then
		local level = player:getLevel() + 1;
		if(player:getPromotionId() > 1) then
			level = level + 200;
		end
		
		local reqGold = (level * 10000);
		local totalCoin = (player:getCoin() - reqGold);
		if(totalCoin < 0) then
			iSend.ClientMessage(player, string.format("Você precisa de %i gold para virar um cidadão", reqGold));
			return;
		end
		
		player:setCoin(totalCoin);
		player:setCitizenshipId(iGetChannelId());
		
		iSend.ClientMessage(player, string.format("Agora você é cidadão do canal %i", iGetChannelId()));
		iSend.Etc(player);
		return;
	end
	
	-- Debug
	-- player:setCitizenshipId(0);
	
	if(player:getPromotionId() > 1) then
		iSend.Say(npc, "Soul apenas para mortal.");
		return;
	end
	
	local cChannelId = iGetChannelId();
	if(citizenshipId ~= cChannelId) then
		return;
	end
	
	if((player:getLearnedSkill() & params.skills.SoulLimit) ~= 0) then
		iSend.Say(npc, "Você já possui a Soul permanente");
		return;
	end
	
	if(player:hasCondition(params.conditions.CONDITION_EDGE_OF_SOUL)) then
		iSend.Say(npc, "Você já possui a Soul");
		return;
	end
	
	local isPermanent = (player:getLevel() >= 369);
	local fItem = FindItem:new(player);
	local reqItemId = 420;
	
	if(isPermanent) then
		reqItemId = (5334 + player:getClass());
	end
	
	if(fItem:findItemId(reqItemId, 1) < 1) then
		local itemAttr = iItems.GetItemById(reqItemId);
		iSend.ClientMessage(player, 'Traga-me o item "'..itemAttr:getName()..'\"');
		return;
	end
	
	if(isPermanent) then
		player:setLearnedSkill(player:getLearnedSkill() | params.skills.SoulLimit);
	else
		player:addCondition(params.conditions.CONDITION_EDGE_OF_SOUL, 0, 0, getTicketHours(1));
	end
	
	fItem:clearItems(1);
	fItem:resume();
	
	iSend.Etc(player);
	iSend.ClientMessage(player, "Você ganhou a Soul!");
end
