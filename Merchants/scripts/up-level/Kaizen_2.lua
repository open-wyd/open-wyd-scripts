local event = iGetEvent( "up-level" );

function OnUse(npc, player)

	local lvl = player:getLevel();
	local pmid = player:getPromotionId( );
	
   if((pmid >= 0 and pmid <= 1 and lvl >= 115 and lvl <= 190) or lvl > 1000) then
		event:addPlayer(player, 2);
		iSend.Say(npc, "Lembre-se, a melhor defesa é o maior ataque!.")
   else
        if(pmid >= 2) then
			iSend.Say(npc, player.mob.name..", Que Diabos de Deus é você ??? ");
        elseif(lvl >= 190) then
			iSend.Say(npc, "Deixa de ser ridículo.. Aqui é para levels menores que 190..");
		else
			iSend.Say(npc, "Volte no level 116. Por enquanto, up nestes monstros da volta.");
		end
   end
end

