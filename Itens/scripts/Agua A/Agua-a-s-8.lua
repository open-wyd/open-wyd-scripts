local event = iGetEvent("agua-A");

function OnUse( Op, Slot, Beg, player )
	return sendToWater(player, event, 8);
end
