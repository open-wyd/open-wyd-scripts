---------------------------------------------------------
--                 Promotion config's                  --
---------------------------------------------------------
-- Incremental attributes
local IncrementalAttrByClass = {
	[0]={HP = 3, MP = 1, Defense = 1},
	[1]={HP = 2, MP = 1, Defense = 1},
	[2]={HP = 1, MP = 1, Defense = 1},
	[3]={HP = 1, MP = 1, Defense = 1}
}

local InitScorePoints = {
	[0]=25,
	[1]=23,
	[2]=26,
	[3]=36,
};

local ScoreBonusList = {
	{from=0, to=256, bonusByLevel=5},
	{from=257, to=301, bonusByLevel=10},
	{from=302, to=356, bonusByLevel=20},
	{from=357, to=400, bonusByLevel=5}
};

local SkillBonusList = {
	{from=0,   to=200, bonusByLevel=3},
	{from=201, to=356, bonusByLevel=4},
	{from=357, to=400, bonusByLevel=3}
};

---------------------------------------------------------
--                Promotion entry point                --
---------------------------------------------------------
-- [this function is optional]
function OnGainExp(player, experience) -- TODO: Correct the potential of infinite loop (recursive use of the Creature->addExp)
	return experience;
end

-- [this function is required]
-- item: is the item to be equipped.
-- slotId: destination outfit slot.
-- return FALSE if this item cannot be equipped
function OnEquipItem(player, item, slotId)
	return canEquipItem(player, item, slotId);
end

-- [this function is optional]
-- Possible values for processStepId: 1, 2, 3 and 4. (is an segmentation of exp gain in client)
function OnCheckLevel(player, processStepId)
	return TRUE; -- add here the actions for the process steps of level up.
end

-- [this function is required]
function OnLevelUp(player)
	
	player:setSpecialBonus(player:getSpecialBonus() + 2);
	player:setBaseDefense(player:getBaseDefense() + 1);
	
	--addBonus(player);
	return TRUE;
end

-- [this function is required]
function OnEnergyBonusMaker(player)
	local MaxHp = ((IncrementalAttrByClass[player:getClass()].HP * player:getLevel()) + (2 * player:getBaseCon()));
	local MaxMp = ((IncrementalAttrByClass[player:getClass()].MP * player:getLevel()) + (2 * player:getBaseInt()));
	
	player:setBaseMaxHp(MaxHp);
	player:setBaseMaxMp(MaxMp);
	player:setMaxHp(MaxHp);
	player:setMaxMp(MaxMp);
end

-- [this function is required]
function OnScoreBonusMaker(player)
	local scorePointInUse = (player:getBaseStr() + player:getBaseInt() + player:getBaseDex() + player:getBaseCon());
	local totalPoints = getTotalBonusPoint(player:getLevel(), ScoreBonusList);
	
	player:setScoreBonus((totalPoints + InitScorePoints[player:getClass()]) - scorePointInUse);
end

-- [this function is required]
function OnSkillBonusMaker(player)
	local skillPointInUse = iGameServer.GetSkillPointsConsumedByCreature(player);
	local totalPoints = getTotalBonusPoint(player:getLevel(), SkillBonusList);
	
	if (player:hasQuest(global_OWS.questList.PilulaOrc)) then
		totalPoints = totalPoints + 9;
	end
	
	player:setSkillBonus(totalPoints - skillPointInUse);
end
