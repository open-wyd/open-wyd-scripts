--	<item id="1721" name="Snowball"
--	<item id="1722" name="Twig"
--	<item id="1723" name="Straw"
--	<item id="1724" name="Hat"
--	<item id="1725" name="Carrot"

--	<item id="1726" name="Grewpain"

function OnUse(npc, player, confirm)
	
	local namePlayer = player:getName();
	
	local snowBall = fItem:findItemId(1721, 10)
	if(snowBall < 10) then 
		local itemAttr = iItems.GetItemById(???);
		isendSay(npc, namePlayer..", você precisa trazer "..itemAttr:getName());
		return;
	end
	
	local twig = fItem:findItemId(1722, 1)
	if(twig < 2) then
		local itemAttr = iItems.GetItemById(???);
		isendSay(npc, namePlayer..", você precisa trazer "..itemAttr:getName());
		return;
	end
	
	local straw = fItem:findItemId(1723, 1)
	if(straw < 4) then
		local itemAttr = iItems.GetItemById(???);
		isendSay(npc, namePlayer..", você precisa trazer "..itemAttr:getName());
		return;
	end
	
	local hat = fItem:findItemId(1724, 1)
	if(Hat < 1) then
		local itemAttr = iItems.GetItemById(???);
		isendSay(npc, namePlayer..", você precisa trazer "..itemAttr:getName());
		return;
	end	
	
	local carrot = fItem:findItemId(1725, 1)
	if(carrot < 1) then
		local itemAttr = iItems.GetItemById(???);
		isendSay(npc, namePlayer..", você precisa trazer "..itemAttr:getName());
		return;
	end
	
	handledItem:reset(rule.repItemId);
	
	iSend.Equip(player);
	iSend.Score(player);
	iSend.Etc(player)

	iSend.Say(npc, "Você realizou a quest.");

	
end	