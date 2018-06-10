local attributes = {};
-- Helmet
attributes[2] =	{effectId = { 3, 4, 26, 60 }, values = { 5, 10, 6, 2 }, maxValue = {{6, 4, 5, 5},  {6, 4, 5, 5},  {6, 4, 5, 5},  {6, 4, 5, 5},  {6, 4, 5, 5}}}; 
-- Armor
attributes[4] =	{effectId = { 2, 3, 60, 71 }, values = { 6, 5, 2, 5 }, 	maxValue = {{5, 6, 5, 14}, {5, 6, 5, 14}, {5, 6, 5, 14}, {4, 5, 4, 12}, {3, 4, 3, 10}}};
-- Pants
attributes[8] =	{effectId = { 2, 3, 60, 71 }, values = { 6, 5, 2, 5 },  maxValue = {{5, 6, 5, 14}, {5, 6, 5, 14}, {5, 6, 5, 14}, {4, 5, 4, 12}, {3, 4, 3, 10}}};
-- Gloves
attributes[16]= {effectId = { 2, 3, 60, 54 }, values = { 6, 5, 2, 3 },  maxValue = {{5, 6, 5, 6},  {5, 6, 5, 6},  {5, 6, 5, 6},  {4, 5, 4, 4},  {3, 4, 3, 3}}}; 
-- Boots
attributes[32]= {effectId = { 2, 0, 60, 74 }, values = { 6, 0, 2, 3 },  maxValue = {{3, 6, 5, 7},  {3, 6, 5, 7},  {3, 6, 5, 7},  {3, 5, 4, 6},  {1, 4, 3, 5}}}; 

local function getRandomAttributes(pos, grade)

	currAttribute = attributes[pos];
	if(currAttribute == nil) then
		return nil; -- fail
	end
	
	local rand1 = math.random(1,4);
	local rand2 = math.random(1,4);
	
	local ramdomAttributes = {};
	-- Set random sanc value.
	table.insert(ramdomAttributes, {slot = 0, effectId = EF_SANC, value = math.random(0, 4)});
	table.insert(ramdomAttributes, {slot = 1, effectId = currAttribute.effectId[rand1], value = currAttribute.values[rand1] * math.random(0, currAttribute.maxValue[grade][rand1])});
	
	if(rand1 ~= rand2) then
		table.insert(ramdomAttributes, {slot = 1, effectId = currAttribute.effectId[rand1], value = currAttribute.values[rand1] * math.random(0, currAttribute.maxValue[grade][rand1])});
	end
	
	return ramdomAttributes;
end

local ItemGradeList = {
	[1] = {id=1, name="A", uniqueIdList={1, 2, 11, 12, 21, 22, 31, 32}},
	[2] = {id=2, name="B", uniqueIdList={3, 4, 13, 14, 23, 24, 33, 34}},
	[3] = {id=3, name="C", uniqueIdList={5, 6, 15, 16, 25, 26, 35, 36}},
	[4] = {id=4, name="D", uniqueIdList={7, 8, 17, 18, 27, 28, 37, 38}},
	[5] = {id=5, name="E", uniqueIdList={10, 20, 30, 40}} };
	
local function checkIfGradeTypeHasUniqueId(gradeId, uniqueId)
	if(ItemGradeList[gradeId] == nil) then
		return false;
	end
	
	for key, uId in pairs(ItemGradeList[gradeId].uniqueIdList) do
		if(uId == uniqueId) then
			return true;
		end
	end
	
	return false;
end

function OnUse(player, pSrc, pNumber, pDest)

	-- #### Validation #### --
	local itemDest = player:getItem(pDest.slot, ITEM_PLACE_CARRY);
	if(itemDest == nil) then
		return FALSE;
	end
	
	if(iItems.GetItemSanc(itemDest) >= 4) then
		iSend.ClientMessage(player, "Somente para equipamentos inferiores a +4");
		return FALSE;
	end
	
	local itemAttr = iItems.GetItemById(itemDest:getId());

	local pos = itemAttr:getPos();
	if(attributes[pos] == nil) then
		iSend.ClientMessage(player, "Somente para equipamentos de defesa, exceto escudos.");
	end
	
	local gradeId = (((pSrc.itemId - 4016) % 5) + 1);
	if(checkIfGradeTypeHasUniqueId(gradeId, itemAttr:getUnique()) == false) then
		iSend.ClientMessage(player, "Somente para equipamentos de classe "..ItemGradeList[gradeId].name..".");
		return FALSE;
	end
	
	-- #### Apply action #### --
	-- Get Random attributes
	local ramdomAttributes = getRandomAttributes(pos, itemAttr:getGrade());
	if(ramdomAttributes == nil) then
		return FALSE;
	end
	
	-- Save item dump before modify for the logs
	local itemDumpBeforeModify = iItems.GetItemDumpStr(itemDest);
	
	-- Set all ramdom attributes.
	for key, attribute in pairs(ramdomAttributes) do
		itemDest:setAddValue(attribute.slot, attribute.effectId, attribute.value);
	end
	
	iLog(player:getName().."Generate Random Attributes, from "..itemDumpBeforeModify.." to:["..iItems.GetItemDumpStr(itemDest).."]");
	iSend.Item(player, ITEM_PLACE_CARRY, pDest.slot, itemDest);

	return TRUE;
end