--
-- 4128,Esfera_da_Sorte(N),2,5.0,0,0,0,0,0,EF_GRID,0,
-- 4129,Esfera_da_Sorte(M),2,4.0,0,0,0,0,0,EF_GRID,0,
-- 4130,Esfera_da_Sorte(A),2,1.0,0,0,0,0,0,EF_GRID,0,
--
-- 3986,Shire(30dias),2821,0,430,16384,0,0,EF_AC,500,EF_CLASS,255,EF_DAMAGE,120,EF_MAGIC,45,EF_RESISTALL,0,EF_RUNSPEED,6,
-- 3987,Thoroughbred(30dias),2821,0,40000,16384,0,0,EF_AC,500,EF_CLASS,255,EF_DAMAGE,450,EF_MAGIC,72,EF_RESISTALL,28,EF_RUNSPEED,6,
-- 3988,Klazedale(30dias),2821,0,40000,16384,0,0,EF_AC,500,EF_CLASS,255,EF_DAMAGE,450,EF_MAGIC,72,EF_RESISTALL,0,EF_RUNSPEED,6,
-- 3989,Gullfaxi(30dias),2821,0,40000,16384,0,0,EF_AC,500,EF_CLASS,255,EF_DAMAGE,325,EF_MAGIC,35,EF_RESISTALL,28,EF_RUNSPEED,6,
--
--
-- Lvl 65 Perzen Normal - Entrega Shire
-- Lvl 66 Perzen Mistico - Entrega Thoroughbred
-- Lvl 67 Perzen Arcano - Entrega Klazedale
-- 
--
--

local putItem = CItem:new();
local EsferasRules = {};

EsferasRules [65] = {

	check = function(self, player,npc)
		local fItem = FindItem:new(player);
		if(fItem:findItemId(self.eventItemId, 1) > 0) then
			fItem:clearItems(1);
			fItem:resume();
			return true;
		end
			return false;
	end,
	
	onAction = function(self, player, npc)
		putItem:setId(3986);
		
		if (iGameServer.PutItem(player, putItem) == false) then
			iGameServer.PutItem(player, putItem);
			return false;
		end
			return true;
	end,
	eventItemId = 4128,
};


EsferasRules [66] = {

	check = function(self, player,npc)
		local fItem = FindItem:new(player);
		if(fItem:findItemId(self.eventItemId, 1) > 0) then
			fItem:clearItems(1);
			fItem:resume();
			return true;
		end
			return false;
	end,
	
	onAction = function(self, player, npc)
		putItem:setId(3988);
		
		if (iGameServer.PutItem(player, putItem) == false) then
			iGameServer.PutItem(player, putItem);
			return false;
		end
			return true;
	end,
	eventItemId = 4129,
};

EsferasRules [67] = {

	check = function(self, player,npc)
		local fItem = FindItem:new(player);
		if(fItem:findItemId(self.eventItemId, 1) > 0) then
			fItem:clearItems(1);
			fItem:resume();
			return true;
		end
			return false;
	end,
	
	onAction = function(self, player, npc)
		putItem:setId(3987);
		
		if (iGameServer.PutItem(player, putItem) == false) then
			iGameServer.PutItem(player, putItem);
			return false;
		end
			return true;
	end,
	eventItemId = 4130,
};

function OnUse(npc, player, confirm)
	
	local esferasRules = EsferasRules[npc:getLevel()];
	
	if(esferasRules == nil) then
		Ilog("wrong trainer ruleId "..npc:getLevel());
		return FALSE;
	elseif(esferasRules:check(player, npc) == false) then
		local itemAttr = iItems.GetItemById(esferasRules.eventItemId);
		iSend.Say(npc, "Traga-me a "..itemAttr:getName());
	elseif(esferasRules:onAction(player, npc)) then
		iSend.Say(npc, "Receba sua recompensa!");
		return TRUE;
	end
	
	return FALSE;
end
