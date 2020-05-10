-- Trocar as 8 pedras por 1 Sephirot

--  <item id="1742" name="Eternal_Stone" mesh="747" price="5000" pos="1024" N0="18" V0="255" N1="33" V1="0" />
--PEDRAS:
--  <item id="1744" name="Kocuna" mesh="749" price="500000" N0="18" V0="255" N1="33" V1="0" />
--  <item id="1745" name="Veean" mesh="750" price="500000" N0="18" V0="255" N1="33" V1="0" />
--  <item id="1746" name="Keced" mesh="751" price="500000" N0="18" V0="255" N1="33" V1="0" />
--  <item id="1747" name="Gebra" mesh="752" price="500000" N0="18" V0="255" N1="33" V1="0" />
--  <item id="1748" name="Tipalet" mesh="753" price="500000" N0="18" V0="255" N1="33" V1="0" />
--  <item id="1749" name="Nechark" mesh="754" price="500000" N0="18" V0="255" N1="33" V1="0" />
--  <item id="1750" name="Yesord" mesh="755" price="500000" N0="18" V0="255" N1="33" V1="0" />
--  <item id="1751" name="Marcute" mesh="756" price="500000" N0="18" V0="255" N1="33" V1="0" /> 

--SEPHIROT's:
--    <item id="1763" name="Sefirot(Hunter)" mesh="757" price="7000" pos="2048" N0="18" V0="255" N1="33" V1="0" />
--    <item id="1760" name="Sefirot(Transknight)" mesh="757" price="7000" pos="2048" N0="18" V0="255" N1="33" V1="0" />
--    <item id="1761" name="Sefirot(Foema)" mesh="757" price="7000" pos="2048" N0="18" V0="255" N1="33" V1="0" />
--    <item id="1762" name="Sefirot(Beastmaster)" mesh="757" price="7000" pos="2048" N0="18" V0="255" N1="33" V1="0" />

--NPC's:
-- <creature name="Foema_Ancian" level="1" merchant="19" clan="3" class="1" experience="0" gold="0" >
-- <creature name="Mestre_Archi" level="1" merchant="19" clan="3" class="1" experience="0" gold="0" >
-- <creature name="ForeLearner" level="3" merchant="19" clan="3" class="1" experience="0" gold="0" >
-- <creature name="Cap.Cavaleiros" level="1" merchant="19" clan="3" class="1" experience="0" gold="0" >

local SephirotRules = {};
local putItem = CItem:new();

SephirotRules = {
	
	check = function(self, player, npc, fItem)
		if (player:getCoin() < 30000000 ) then
			iSend.Say(npc, "Necessário 30.000.000 de Gold")
			return false;
		end
	
		for pedrasId=1744, 1751, 1 do
			if(fItem:findItemId(pedrasId, 1) ~= 1) then
				iSend.Say(npc, "Traga-me as Pedras corretas!")				
				return false;
			end
		end
		return true;
	end,
	
	onAction = function(self, player, npc, fItem)
		putItem:reset();
		putItem:setId(1760 + npc:getLevel());
		
		if(iGameServer.PutItem(player, putItem) == true) then
			fItem:clearItems(8);
			player:setCoin(player:getCoin() - 30000000)
			fItem:resume();
			iSend.Say(npc, "Você realizou a quest.");
			iSend.Etc(player);
		else
			iSend.ClientMessage(player, "Inventario esta sem espaço.");
		end
	end,
};

function OnUse(npc, player, confirm)
	if (confirm ~= 1) then
		return;
	end
	
	local fItem = FindItem:new(player);

	if(SephirotRules:check(player, npc, fItem)) then
		SephirotRules:onAction(player, npc, fItem);
	end
end