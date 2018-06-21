_AddBonusPVM = "Adicionou 2 horas de BÔNUS PvM (ataque contra monstros).";
function OnUse(player, pSrc, pNumber, pDest)
	if( (not player:hasCondition(30)) ) then
		player:addCondition(30, 100, 100, getTicketHours(2));
		iSend.ClientMessage(player, _AddBonusPVM);
	elseif( player:getCondition(30).affecttime < getTicketDays(5) ) then --se tempo do buff for menor do que 5 dias
		player:addCondition(30, 100, 100, (player:getCondition(30).affecttime+getTicketHours(2)));
		iSend.ClientMessage(player, _AddBonusPVM);
	else
		iSend.ClientMessage(player, "Limite de 5 dias deste bônus, aguarde 2 hrs e tente novamente.");
		return FALSE;
	end
	return TRUE;
end