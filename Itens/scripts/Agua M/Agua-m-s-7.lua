local event = iGetEvent("agua-M");

function OnUse(player, pSrc, pNumber, pDest)
	return sendToWater(player, event, 7);
end