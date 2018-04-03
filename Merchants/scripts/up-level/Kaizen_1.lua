local event = iGetEvent( "up-level" );

function OnUse(npc, player, confirm)

	local lvl = player.BaseScore.Level;
	local pmid = player:getPromotionId( );
	
	
	iSend.Say(npc, "lvl: "..lvl);
	
   if(lvl > 1000 or (pmid >= 0 and pmid <= 1 and lvl >= 35 and lvl <= 99)) then
		event:addPlayer(player, 1);
		iSend.Say(npc, "Isto ai filho.. seja bravo!" );
   else
        if( pmid >= 2 ) then
			iSend.Say(npc, player.mob.name..", Que Diabos de Deus é você ??? " );
        elseif( lvl >= 99 ) then
			iSend.Say(npc, "Deixa de ser ridículo.. Aqui é para levels menores que 100.." );
		else
			iSend.Say(npc, "Pequeno gafanhoto.. Aqui é um local perigoso para ti.. Volte no level 35." );
		end
   end
end
