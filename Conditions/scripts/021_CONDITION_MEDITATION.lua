function OnUse(player, sPercent, value, level)
	player:setDefense(player:getDefense() - (level / 3 + 10));
	sPercent.Damage = (sPercent.Damage + (level / 10 + value));
end