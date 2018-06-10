local kaizenItemsConfig = {};

kaizenItemsConfig[4117] = {	-- Caixa_da_Sabedoria
		ev =  {from = 0, to = 1},
		lvl = {from = 39, to = 114},
		reward = {gold = 100000, experience = 50000},
	};

kaizenItemsConfig[4118] = {	-- Lágrima_Angelical
		ev =  {from = 0, to = 1},
		lvl = {from = 114, to = 189},
		reward = {gold = 250000, experience = 100000},
	};

kaizenItemsConfig[4119] = {	-- Coração_do_Kaizen
		ev =  {from = 0, to = 1},
		lvl = {from = 190, to = 264},
		reward = {gold = 400000, experience = 200000},
	};

kaizenItemsConfig[4120] = {	-- Olho_de_Sangue
		ev =  {from = 0, to = 1},
		lvl = {from = 265, to = 319},
		reward = {gold = 600000, experience = 250000},
	};

kaizenItemsConfig[4121] = {	-- Pedra_Espiritual_dos_Elfos
		ev =  {from = 0, to = 1},
		lvl = {from = 320, to = 399},
		reward = {gold = 900000, experience = 300000},
	};

function OnUse(player, pSrc, pNumber, pDest)

	local kaizen =  kaizenItemsConfig[pSrc.itemId];
	local lvl = player:getLevel()
	local ev  = player:getPromotionId();
	
	if((ev >= kaizen.ev.from and ev <= kaizen.ev.to and lvl >= kaizen.lvl.from and lvl <= kaizen.lvl.to) or lvl > 1000) then
		
		local cGold = player:getCoin();
		if((cGold + kaizen.reward.gold) <= 2000000000) then
			player:setCoin(cGold + kaizen.reward.gold);
		end
		
		iSend.ClientMessage(player, string.format(MessageStringTable._DN_get_D_exp_and_gold, kaizen.reward.experience, kaizen.reward.gold));
		
		player:addExp(kaizen.reward.experience);
		
		iSend.ExpGain(player)
		iGameServer.TryLevelUpWithEffects(player);
		
		return TRUE;
	end
	
	iSend.ClientMessage(player, string.format(MessageStringTable._NN_Only_mortal_or_god_level_req, kaizen.lvl.from, kaizen.lvl.to));
	
	return FALSE;
end
