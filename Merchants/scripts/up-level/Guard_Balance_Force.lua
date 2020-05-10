local event = iGetEvent( "up-level" );

function OnUse(npc, player)

	local lvl = player:getLevel();
	local pmid = player:getPromotionId();
	
   if((pmid >= 0 and pmid <= 1 and lvl >= 119 and lvl <= 125) or lvl > 1000) then
		event:addPlayer(player, 8);
		iSend.Say(npc, "Nos ajude a defender a Catedral Achro. Prove sua coragem");
   else
        if(pmid >= 2) then
			iSend.Say(npc, player.mob.name..", Existem desafios maiores para você, deixe este para os meros mortais.");
        elseif(lvl >= 75) then
			iSend.Say(npc, "Você deveria ter me procurado antes ( lvl 120~125 ).");
		else
			iSend.Say(npc, "Treine mais.. O desafio aqui exigirá coragem ( lvl 120~125 ).");
		end
   end
end