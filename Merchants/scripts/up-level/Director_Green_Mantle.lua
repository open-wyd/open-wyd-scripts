local event = iGetEvent( "up-level" );

function OnUse(npc, player)

	local lvl = player:getLevel();
	local pmid = player:getPromotionId();
	
   if((pmid >= 0 and pmid <= 1 and lvl >= 101 and lvl <= 150) or lvl > 1000) then
		event:addPlayer(player, 6);
		iSend.Say(npc, "Há algo de bom neste mundo e vale a pena lutar por isso. Prove seu valor!");
   else
        if(pmid >= 2) then
			iSend.Say(npc, player.mob.name..", Existem desafios maiores para você, deixe este para os meros mortais.");
        elseif(lvl >= 150) then
			iSend.Say(npc, "Você deveria ter me procurado antes ( lvl 101~150 ).");
		else
			iSend.Say(npc, "Somente os dignos podem entrar.. fique mais forte e volte ( lvl 101~150 ).");
		end
   end
end