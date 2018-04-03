___MSG_IN_TELEPORT___ = "Teleportado!"

function doTeleport(player, x, y)
	iGameServer.DoTeleport(player, x, y);
	iSend.ClientMessage(player, ___MSG_IN_TELEPORT___);
end