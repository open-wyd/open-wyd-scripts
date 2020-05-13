function OnUse(npc, player, fItem, confirm)
	local fItem = FindItem:new(player);
	if(fItem:findItemId(697, 10) < 10) then 
		local itemAttr = iItems.GetItemById(697);
		iSend.Say(npc, player:getName()..", você precisa trazer 10 "..itemAttr:getName());
		return;
	end
	
	if(player:getPromotionId() == 0) then
		local n = 1;
		for n = 1, 7, 1 do
			local item = player:getItem(n, 0);
			if( item:getId() ~= 0 )then
				iSend.Say(npc, player:getName()..", desequipe as armas e o set");
				return;
			end
		end
	end
	
	local getScoreList = {
		[0] = function() return player:getBaseStr(); end,
		[1] = function() return player:getBaseInt(); end,
		[2] = function() return player:getBaseDex(); end,
		[3] = function() return player:getBaseCon(); end
	};
	
	local setScoreList = {
		[0] = function(value) player:setBaseStr(value); end,
		[1] = function(value) player:setBaseInt(value); end,
		[2] = function(value) player:setBaseDex(value); end,
		[3] = function(value) player:setBaseCon(value); end
	};

	local i = 0;
	local totalResetedPoints = 0;
	
	for i = 0, 3, 1 do
		if(getScoreList[i]() < 100) then
			resetedPoints = getScoreList[i]();
			setScoreList[i](0);
		else
			resetedPoints = 100;
			setScoreList[i](getScoreList[i]() - 100)
		end
		totalResetedPoints = totalResetedPoints + resetedPoints;
	end
	
	fItem:clearItems(10);
	fItem:resume();
	
	player:setScoreBonus(player:getScoreBonus() + totalResetedPoints);
	player:doBuildCurrentScore();
	iSend.Etc(player);
	iSend.Equip(player);
	iSend.Score(player);

end