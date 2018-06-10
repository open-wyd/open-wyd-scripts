local event = iGetEvent("agua-M");

function OnUse(player, pSrc, pNumber, pDest)
	return sendToWater(player, event, 4);
end