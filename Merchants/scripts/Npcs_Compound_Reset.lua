-- 2 (clan) Sacerdote_Kruno Troca Balance's_Piece (4123) por Pure Divine Circle {{id=448}, {id=449}, {id=450}}
-- 0 (clan) Sacerd._Amelia Troca Full Divine Circle Piece (692) por Full Divine Circle {{id=693}, {id=694}, {id=695}}

local CompoundRules = {};
local putItem = CItem:new();

CompoundRules[2] = {

	check = function(self, player, npc, fItem)
		if (player:getLevel() < 69 or player:getLevel() > 75 or player:getPromotionId() ~= 0) then
			iSend.Say(npc, "Esta quest é apenas para mortais (70-75)");
			return false;
		end

		if (fItem:findItemId(4123, 1) ~= 1) then
			local itemAttr = iItems.GetItemById(4123);
			iSend.Say(npc, "Traga-me o item: "..itemAttr:getName());
			return false;
		end
		
		return true;
	end,
	
	eventItemId = 4124,
};

CompoundRules[0] = {

	check = function(self, player, npc, fItem)
		if (player:getLevel() < 119 or player:getLevel() > 125 or player:getPromotionId() ~= 0) then
			iSend.Say(npc, "Esta quest é apenas para mortais (120-125)");
			return false;
		end

		if (fItem:findItemId(4125, 1) ~= 1) then
			local itemAttr = iItems.GetItemById(4125);
			iSend.Say(npc, "Traga-me o item: "..itemAttr:getName());
			return false;
		end
		
		return true;
	end,

	eventItemId = 4126,
};


function OnUse(npc, player, confirm)

	local compoundRule = CompoundRules[npc:getClan()];
		
	local fItem = FindItem:new(player);
	
	if(compoundRule:check(player, npc, fItem)) then
		putItem:reset(compoundRule.eventItemId);
		
		if(iGameServer.PutItem(player, putItem) == true) then
			fItem:clearItems(1);
			fItem:resume();

			iSend.Etc(player);
		else
			
		end
	
	end
end