local HuntingScrolls = {};

-- Armia
HuntingScrolls[3432] = { CPosition:new(2370, 2106), CPosition:new(2508, 2101), CPosition:new(2526, 2109), CPosition:new(2529, 1882), CPosition:new(2126, 1600), CPosition:new(2005, 1617), CPosition:new(2241, 1474), CPosition:new(1858, 1721), CPosition:new(2250, 1316), CPosition:new(1989, 1755) };

-- Dungeon
HuntingScrolls[3433] = { CPosition:new(290, 3799), CPosition:new(724, 3781), CPosition:new(481, 4062), CPosition:new(876, 4058), CPosition:new(855, 3922), CPosition:new(808, 3876), CPosition:new(959, 3813), CPosition:new(926, 3750), CPosition:new(1096, 3730), CPosition:new(1132, 3800) };
	
-- SubMundo
HuntingScrolls[3434] = { CPosition:new(1242 , 4035), CPosition:new(1264 , 4017), CPosition:new(1333 , 3994), CPosition:new(1358 , 4041), CPosition:new(1462 , 4033), CPosition:new(1326 , 3788), CPosition:new(1493 , 3777), CPosition:new(1437 , 3741), CPosition:new(1389 , 3740), CPosition:new(1422 , 3810) };
	
-- Kult
HuntingScrolls[3435] = { CPosition:new(1376 , 1722), CPosition:new(1426 , 1686), CPosition:new(1381 , 1861), CPosition:new(1326 , 1896), CPosition:new(1510 , 1723), CPosition:new(1543 , 1726), CPosition:new(1580 , 1758), CPosition:new(1182 , 1714), CPosition:new(1634 , 1727), CPosition:new(1237 , 1764) };
	
-- Kefra
HuntingScrolls[3436] = { CPosition:new(2367 , 4024), CPosition:new(2236 , 4044), CPosition:new(2236 , 3993), CPosition:new(2209 , 3989), CPosition:new(2453 , 4067), CPosition:new(2485 , 4043), CPosition:new(2537 , 3897), CPosition:new(2489 , 3919), CPosition:new(2269 , 3910), CPosition:new(2202 , 3866) };
	
-- Nipple
HuntingScrolls[3437] = { CPosition:new(3664 , 3024), CPosition:new(3582 , 3007), CPosition:new(3514 , 3008), CPosition:new(3819 , 2977), CPosition:new(3517 , 2889), CPosition:new(3745 , 2977), CPosition:new(3639 , 2877), CPosition:new(3650 , 2727), CPosition:new(3660 , 2773), CPosition:new(3746 , 2879) };


function OnUse(Op, Slot, Beg, player)
	
	local item = player:getItem(Slot, Beg);
	local scroll =  HuntingScrolls[item:getId()];
	
	if(iGameServer.DoTeleport(player, scroll[Op])) then
		return TRUE;
	else
		return FALSE;
	end
end
