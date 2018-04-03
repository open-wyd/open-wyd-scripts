function sendToWater(player, event, level)

	if(player:getCurrentPosition():isBetween(1964, 1772, 1967, 1775)) then
		if(event:addPlayer(player, level)) then
			return TRUE;
		else
			iSend.ClientMessage(player, "Evento em andamento.")
		end
	else
		iSend.ClientMessage(player, "Necessário estar na Zona Elemental da Água para usar.")
	end
	
	return FALSE;
end