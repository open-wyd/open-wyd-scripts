local event = iGetEvent("agua-M");

function OnUse( Op, Slot, Beg, player )
	return sendToWater(player, event, 1);
end