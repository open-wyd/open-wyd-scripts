function OnUse( player )

	local new_pos = { x=0, y=0 }
	if( getCastleOwner() ~= player:getGID() ) then
		iSend.ClientMessage(player, "Somente membros da guilda campea.")
		return FALSE
	end
	
	doTeleport(player, 1107, 1721);
end
