kappaAttrList = {
	[787] ={conditionValue=1, conditionTime=getTicketMin(10)},  -- Kappa
	[1764]={conditionValue=2, conditionTime=getTicketMin(10)},  -- Competent
	[1765]={conditionValue=3, conditionTime=getTicketMin(10)},  -- Mental
	[3310]={conditionValue=1, conditionTime=getTicketMin(30)},   -- Kappa 30m
	[3311]={conditionValue=2, conditionTime=getTicketHours(1)},  -- Competent 60m
	[3312]={conditionValue=3, conditionTime=getTicketHours(1)},  -- Mental 60m
	[3319]={conditionValue=1, conditionTime=getTicketHours(20)}, -- Kappa 20h
	[3320]={conditionValue=2, conditionTime=getTicketHours(20)}, -- Competent 20h
	[3321]={conditionValue=3, conditionTime=getTicketHours(20)}, -- Mental 20h
};
		
function OnUse(player, pSrc, pNumber, pDest)
	
	kappa = kappaAttrList[pSrc.itemId];
	if(kappa == nil) then
		return FALSE;
	end
	
	if(player:addCondition(4, kappa.conditionValue, 0, kappa.conditionTime) == false) then
		return FALSE;
	end
	
	iLog(player:getName().." used kappa potion, value:"..kappa.conditionValue.." time:"..kappa.conditionTime);
	
	return TRUE;
end
