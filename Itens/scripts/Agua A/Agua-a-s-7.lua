local event = iGetEvent("agua-A");

function OnUse(player, pSrc, pNumber, pDest)
	return sendToWater(player, event, 7);
end
