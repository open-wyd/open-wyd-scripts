local event = iGetEvent( "up-level" );

function OnUse(npc, player)

	local lvl = player:getLevel();
	local pmid = player:getPromotionId();
	
   if((pmid >= 0 and pmid <= 1 and lvl >= 39 and lvl <= 115) or lvl > 1000) then
		event:addPlayer(player, 1);
		iSend.Say(npc, "Isto ai filho.. seja bravo!");
   else
        if(pmid >= 2) then
			iSend.Say(npc, player.mob.name..", Que Diabos de Deus é você ??? ");
        elseif(lvl >= 115) then
			iSend.Say(npc, "Deixa de ser ridículo.. Aqui é para levels menores que 115..");
		else
			iSend.Say(npc, "Pequeno gafanhoto.. Aqui é um local perigoso para ti.. Volte no level 40.");
		end
   end
end
