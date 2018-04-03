function OnUse( player )

	if( iGetGlobalEnvInt64(74) ~= 1 ) then
		iSend.ClientMessage(player, "O Kefra precisa ser derrotado antes de prosseguir.");
		return FALSE;
	end
	
	iGameServer.DoTeleport(player, 3253, 1702);
	iSend.ClientMessage(player, "Você está agora no Continente Desconhecido.");
end
