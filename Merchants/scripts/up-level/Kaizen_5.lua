local event = iGetEvent( "up-level" );

function OnUse(npc, player)

	local lvl = player:getLevel();
	local pmid = player:getPromotionId();
	
   if((pmid >= 0 and pmid <= 1 and lvl >= 320 and lvl <= 350) or lvl > 1000) then
        event:addPlayer(player, 5);
		iSend.Say(npc, "Filho, não borre as calças pois a batalha será Dura!");
   else
        if(pmid >= 2) then
			iSend.Say(npc, player.mob.name..", Que Diabos de Deus é você ??? ");
        elseif(lvl >= 350) then
			iSend.Say(npc, "Suma daqui.. Você agora esta na linha de fogo soldado..( lvl 320~350 )");
		else
			iSend.Say(npc, "Filho.. Receio que você ainda não esta preparado para esta batalha!..( lvl 320~350 )");
		end
   end
end
