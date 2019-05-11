
function getTotalBonusPoint(level, bonusList)
    local totalPoints = 0;
    for key, value in pairs(bonusList) do
        if (level >= value.from) then
            if (level > value.to) then
                totalPoints = totalPoints +
                                  ((value.to - value.from) * value.bonusByLevel);
            else
                totalPoints = totalPoints +
                                  ((level - value.from) * value.bonusByLevel);
            end
        else
            break;
        end
    end

    return totalPoints;
end

local MobTypes = {
    MORTAL = 2,
    ARCH = 1,
    CELESTIAL = 3,
    SUB_CELESTIAL = 4,
    HARDCORE = 5
}

function getMobTypeByPromotionId(promotionId)
    if (promotionId == 0) then
        return MobTypes.MORTAL;
    elseif (promotionId == 1) then
        return MobTypes.ARCH;
    elseif (promotionId == 2) then
        return MobTypes.CELESTIAL;
    elseif (promotionId == 3) then
        return MobTypes.SUB_CELESTIAL;
    end

    return MobTypes.HARDCORE;
end

function canEquipItem(player, item, Pos)

    if (Pos == 15) then
        return FALSE;
    end

    local itemAttr = iItems.GetItemById(item:getId())
    if (itemAttr == nil) then
        return FALSE;
    end

    if (Pos ~= -1) then

        local tpos = iItems.GetItemAbility(item, EF_POS);

        if (((tpos >> Pos) & 1) == 0) then
            return FALSE;
        end

        if (Pos == 6 or Pos == 7) then

            local otherHand = nil;

            if (Pos == 7) then
                otherHand = player:getRight();
            else
                otherHand = player:getLeft();
            end

            if (otherHand:getId() ~= 0) then

                local itemAttr2 = iItems.GetItemById(otherHand:getId());
                local otherpos = iItems.GetItemAbility(otherHand, EF_POS);

                if (tpos == 64 or otherpos == 64) then
                    if (itemAttr:getUnique() == 46) then
                        if (otherpos ~= 128) then
                            return FALSE;
                        end
                    elseif (itemAttr2:getUnique() == 46) then
                        if (tpos ~= 128) then
                            return FALSE;
                        end
                    else
                        return FALSE;
                    end
                end
            end
        end
    end

    local playerMobType = getMobTypeByPromotionId(player:getPromotionId());
    local itemMobType = iItems.GetItemAbility(item, EF_MOBTYPE);

    if (itemMobType == MobTypes.ARCH and playerMobType == MobTypes.MORTAL) then
        return FALSE;
    elseif (itemMobType == MobTypes.MORTAL and playerMobType ~= MobTypes.MORTAL) then
        return FALSE;
    elseif (itemMobType == MobTypes.CELESTIAL and (playerMobType == MobTypes.MORTAL or playerMobType == MobTypesARCH)) then
        return FALSE;
    elseif (playerMobType ~= MobTypes.MORTAL and Pos == 1 and item:getId() ~= 747 and not item:isBetween(3500, 3507)) then
        return FALSE;
    end

    local lvl, str, spt, agi, con = 0, 0, 0, 0, 0
    if (playerMobType == MobTypes.MORTAL) then
        lvl = iItems.GetItemAbility(item, EF_LEVEL);
        str = iItems.GetItemAbility(item, EF_REQ_STR);
        spt = iItems.GetItemAbility(item, EF_REQ_INT);
        agi = iItems.GetItemAbility(item, EF_REQ_DEX);
        con = iItems.GetItemAbility(item, EF_REQ_CON);

        local weapontype = (iItems.GetItemAbility(item, EF_WTYPE) % 10);
        local divweapon = weapontype / 10;

        if (Pos == 7 and weapontype ~= 0) then

            local rate = 100;

            if (divweapon == 0 and weapontype > 1) then
                rate = 130;
            elseif (divweapon == 6 and weapontype > 1) then
                rate = 150;
            end

            lvl = lvl * rate / 100;
            str = str * rate / 100;
            spt = spt * rate / 100;
            agi = agi * rate / 100;
            con = con * rate / 100;
        end
    end

    local result = (
            lvl < player:getLevel() or
            str < player:getBaseStr() or
            spt < player:getBaseInt() or
            agi < player:getBaseDex() or
            con < player:getBaseCon()
        );

    if (result == false) then
        return FALSE;
    end

    return TRUE;
end