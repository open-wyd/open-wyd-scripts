local lanEvent = iGetEvent("territory_ticket");

local LanRules = {};

LanRules[4111] = { 

	check = function(self, player)
		return (player:getLevel() <= 250 and player:getPromotionId() == 0) 
	end,
	errorMessage = "Zona Lan(N) exclusiva para mortais com level menor que 251."
};

LanRules[4112] = {

	check = function(self, player)
		return (player:getPromotionId() == 1 or (player:getLevel() > 250 and player:getPromotionId() == 0));
	end,
	errorMessage = "Zona Lan(M) exclusiva para mortais com level maior que 251 e archs."
	
};

LanRules[4113] = { 

	check = function(self, player)
		return (player:getPromotionId() > 1); 
	end,
	errorMessage = "Zona Lan(A) exclusiva celestial/sub-celestial"
};

function OnUse(player, pSrc, pNumber, pDest)
	
	local item = player:getItem(pSrc.slot, pSrc.type);
	local lanRule = LanRules[item:getId()];
	
	if(lanRule == nil) then
		Ilog("wrong lan ruleId "..item:getId());
		return;
	end
	
	if (lanRule:check(player)) then
		lanEvent:addPlayer(player, item:getId());
		iSend.ClientMessage(player, "Acabe com todos eles!!!");
	else
		iSend.ClientMessage(player, lanRule.errorMessage);
	end
end