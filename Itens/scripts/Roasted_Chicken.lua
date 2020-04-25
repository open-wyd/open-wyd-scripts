_AddBonusPVM = "Adicionou 4 horas de BÔNUS PvM (ataque contra monstros).";
function OnUse(player, pSrc, pNumber, pDest)
	if( (not player:hasCondition(30)) ) then
		player:addCondition(30, 0, 1000, getTicketHours(4));
		iSend.ClientMessage(player, _AddBonusPVM);
	elseif( player:getCondition(30).time < getTicketDays(5) ) then --se tempo do buff for menor do que 5 dias
		player:addCondition(30, 0, 1000, (player:getCondition(30).time + getTicketHours(4)));
		iSend.ClientMessage(player, _AddBonusPVM);
	else
		iSend.ClientMessage(player, "Limite de 5 dias deste bônus, aguarde 4 hrs e tente novamente.");
		return FALSE;
	end
	
	return TRUE;
end