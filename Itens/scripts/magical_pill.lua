function OnUse(player, pSrc, pNumber, pDest)
	
	if(player:hasQuest(global_OWS.questList.PilulaOrc)) then
		return FALSE;
	end
	
	player:setSkillBonus(player:getSkillBonus() + 9);
	player:addQuest(global_OWS.questList.PilulaOrc);
	player:addSkillCondition(44, 20, 20, __sConditionAffect);

	iSend.Emotion(player, 14, 3);
	iSend.Etc(player);
	iLog("Quest, ["..player:getName().."] pilula orc was completed.");
	
	return TRUE;
end
