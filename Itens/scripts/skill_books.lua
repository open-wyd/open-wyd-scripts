
function OnUse(player, pSrc, pNumber, pDest)
	
	local bookItem = player:getItem(pSrc.slot, pSrc.type);
	local volatileId = iItems.GetItemAbility(bookItem, EF_VOLATILE);
	local skillToBeLearned = 1 << (volatileId - 7);
	local skillLearned = player:getLearnedSkill();
	if ((skillLearned & skillToBeLearned) ~= 0) then
		iSend.ClientMessage(player, MessageStringTable._NN_Already_Learned_It);
		return FALSE;
	end

	player:setLearnedSkill(skillLearned | skillToBeLearned);
	player:addSkillCondition(44, 20, 20, __sConditionAffect);
	
	iSend.Etc(player);
	iSend.ClientMessage(player, string.format(MessageStringTable._SN_Learn_Sephera, iItems.GetItemById(bookItem:getId()):getName()));
	
	iLog(player:getName().." added skill by bookItemId: "..bookItem:getId());
	
	return TRUE;
end
