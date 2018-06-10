_AddBonusExp = "Adicionou 2 horas de BÔNUS EXP.";
function OnUse(player, pSrc, pNumber, pDest)
	if( (not player:hasCondition(39)) ) then
		player:addCondition(39, 100, 100, getTicketHours(2));
		iSend.ClientMessage(player, _AddBonusExp);
	elseif( player:getCondition(39).affecttime < getTicketDays(5) ) then --se tempo do buff for menor do que 5 dias
		player:addCondition(39, 100, 100, (player:getCondition(39).affecttime+getTicketHours(2)));
		iSend.ClientMessage(player, _AddBonusExp);
	else
		iSend.ClientMessage(player, "Limite de 5 dias deste bônus, aguarde 2 hrs e tente novamente.");
		return FALSE;
	end
	return TRUE;
end