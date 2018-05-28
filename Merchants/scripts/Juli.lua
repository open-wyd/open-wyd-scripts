function OnUse( npc, player )

	local lvl = player:getLevel()
	local pos = player:getCurrentPosition();

	if( pos.x > 3616 and pos.x < 3675 and pos.y > 3098 and pos.y < 3159 ) then
		iSend.Say(npc, "Tenha uma boa viagem.!");
		iGameServer.DoTeleport(player, 2479, 1649);
	else
		if( lvl > 254 ) then
			iSend.Say(npc, "Tenha uma boa viagem.!");
			iGameServer.DoTeleport(player, 3649, 3134);
		else
			iSend.Say(npc, "Você ainda não possui level 255.");
			end
		end
   end