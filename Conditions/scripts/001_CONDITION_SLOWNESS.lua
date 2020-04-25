function OnUse(player, sPercent, value, level)
	
	sPercent.RunSpeed = (sPercent.RunSpeed - value);
	sPercent.AttSpeed = (sPercent.AttSpeed - 30);

	if (player:getPhace():getId() > 50) then
		player:setInt(player:getInt() - 40);
	end
end