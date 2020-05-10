local event = iGetEvent( "up-level" );

function OnUse(npc, player)

	local lvl = player:getLevel();
	local pmid = player:getPromotionId();
	
   if((pmid >= 0 and pmid <= 1 and lvl >= 190 and lvl <= 266) or lvl > 1000) then
        event:addPlayer(player, 3);
		iSend.Say(npc, "Mesmo que morra será bem lembrado!" );
   else
        if(pmid >= 2) then
			iSend.Say(npc, player.mob.name..", Que Diabos de Deus é você ??? " );
        elseif(lvl >= 266) then
			iSend.Say(npc, "Não acha que deva fazer algo mais produtivo ?..( lvl 190~266 )" );
		else
			iSend.Say(npc, "Terá de fazer muito mais reflexões para isto, Filho!!!( lvl 190~266 )" );
		end
   end
end
