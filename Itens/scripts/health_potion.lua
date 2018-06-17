local function getConditionTimeByItemId(potionItemId)
	if(potionItemId == 3313) then
		return getTicketHours(1);
	elseif(potionItemId == 3364) then
		return getTicketDays(7);
	elseif(potionItemId == 3365) then
		return getTicketDays(15);
	elseif(potionItemId == 3366) then
		return getTicketDays(30);
	end
	
	return nil;
end

function OnUse(player, pSrc, pNumber, pDest)
	
	if(player:hasCondition(35)) then
		iSend.ClientMessage(player, string.format(MessageStringTable._NS_Item_is_already_in_use, iItems.GetItemById(pSrc.itemId):getName()));
		return FALSE;
	end
	
	local conditionTime = getConditionTimeByItemId(pSrc.itemId);
	if(player:addCondition(35, 1, 0, conditionTime) == false) then
		return FALSE;
	end
	
	iLog(player:getName().." used item: "..iItems.GetItemById(pSrc.itemId):getName());
	
	return TRUE;
end
