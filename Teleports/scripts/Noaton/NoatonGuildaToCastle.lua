function OnUse( player )
	if( getCastleOwner() ~= player:getGID() ) then
		iSend.ClientMessage(player, "Somente membros da guilda campea.")
		return FALSE
	end
	doTeleport(player, 1107, 1721)
end
