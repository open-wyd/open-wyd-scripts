function OnUse(player, pSrc, pNumber, pDest)
	iSend.Emotion(player, 100, math.random(0, 5));
	return TRUE;
end
