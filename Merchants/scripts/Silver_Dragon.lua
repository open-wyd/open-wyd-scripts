--	<item id="1721" name="Snowball"
--	<item id="1722" name="Twig"
--	<item id="1723" name="Straw"
--	<item id="1724" name="Hat"
--	<item id="1725" name="Carrot"
--	<item id="1726" name="Grewpain"

local RequiredItems = {
		[1721] = {quantity = 10}, 
		[1722] = {quantity = 2}, 
		[1723] = {quantity = 4}, 
		[1724] = {quantity = 1}, 
		[1725] = {quantity = 1}		
};

local PutItem = CItem:new(1726);

function OnUse(npc, player, fItem, confirm)
	
	local namePlayer = player:getName();
	local currentCoin = player:getCoin();
	local fItem = FindItem:new(player);
	
	if(player:getCoin() < 2000000) then
		iSend.Say(npc, namePlayer..", preciso que traga 2.000.000 de gold");
		return; 
	end
	
	for key, value in pairs(RequiredItems) do
		if(fItem:findItemId(key, value.quantity) < value.quantity) then
			local itemAttr = iItems.GetItemById(key);
			iSend.Say(npc, player:getName()..", preciso de "..value.quantity.." "..itemAttr:getName());
			return;
		end
	end	

	if(iGameServer.PutItem(player, PutItem) == true) then
		player:setCoin(player:getCoin() - 2000000)
		fItem:clearItems(18)
		fItem:resume();
		iSend.Say(npc, "Obrigado!!"..player:getName().." você merece essa recompensa");
		iSend.Etc(player);
	else
		iSend.ClientMessage(player, "Inventario esta sem espaço.");
	end
	
	iSend.Equip(player);
	iSend.Score(player);
	iSend.Etc(player)

	iSend.Say(npc, "Você realizou a quest.");

end	
