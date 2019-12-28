local id = 9
if not Rotations[id] then
    Rotations[id] = {}
end
local this = Rotations[id]

-- <SPELLS
SPELL_CORRUPTION = {25311, 11672, 11671, 7648, 6223, 6222, 172}
SPELL_IMMOLATE = {25309, 11668, 11667, 11665, 2941, 1094, 707, 348}
SPELL_CURSEOFAGONY = {11713, 11712, 11711, 6217, 1014, 980}
SPELL_SHADOWBOLT = {25307, 11661, 11660, 11659, 7641, 1106, 1088, 705, 695, 686}
SPELL_LIFETAP = {11689, 11688, 11687, 1456, 1455, 1454}
SPELL_DEMONSKIN = {11735, 11734, 11733, 1086, 706, 696, 687}
SPELL_HEALTHSTONE = {11730, 11729, 5699, 6202, 6201}
SPELL_PET = {697, 688}
SPELL_HEALTH_FUNNEL = {11695, 11694, 11693, 3700, 3699, 3698, 755}
-- SPELLS/>

ITEM_HEALTHSTONES = {19005, 19004, 5512, 5511, 5509, 5510, 9421}

function getSoulShardCount()
    return GetItemCount(6265)
end

function getHealthStone()
    for i=1, #ITEM_HEALTHSTONES do
        if GetItemCount(ITEM_HEALTHSTONES[i]) > 0 then
            return ITEM_HEALTHSTONES[i]
        end
    end
end

function dotsExists(unit)
    if AuraRemains(unit, getBest(SPELL_CORRUPTION)) > 3 and AuraRemains(unit, getBest(SPELL_CURSEOFAGONY)) > 3 then
        return true
    else
        return false
    end
end

function rebuff()
    local hasPet = ExUnitExists('pet')
    -- Stop casting health funnel if pet is almost full.
    if UnitHealthPercent('pet') >= 90 and getChannelID() == getBest(SPELL_HEALTH_FUNNEL) then
        stopCasting()
    end
    local manaPercent = UnitPower('player') / UnitPowerMax('player') * 100
     -- Demon Skin Buff
    if not HasBuff('player', getBest(SPELL_DEMONSKIN)) then TryCast(getBest(SPELL_DEMONSKIN), 'player') end
    -- Summon pet (Void walker or imp depending on what we have access to)
    if not hasPet and getSoulShardCount() > 0 then
        TryCast(getBest(SPELL_PET), 'player')
        return
    end
    -- Create healthstone
    if not getHealthStone() and getSoulShardCount() > 0 then
        TryCast(getBest(SPELL_HEALTHSTONE), 'player')
    end
    -- Heal pet
    if hasPet and UnitHealthPercent('pet') < 60 and UnitHealthPercent('player') > 80 then
        TryCast(getBest(SPELL_HEALTH_FUNNEL),  'player')
    end
    -- mana filler out of combat
    if UnitHealthPercent('player') == 100 and manaPercent < 100 then TryCast(getBest(SPELL_LIFETAP), 'player') end
    -- Delete extra soulshards since its unnecesary bag space.
    if getSoulShardCount() > 1 then
        for b=0,4 do
            for s=1,36 do
                n=GetContainerItemLink(b,s);
                if n and string.find(n,"Soul Shard") then
                    PickupContainerItem(b,s);
                    DeleteCursorItem();
                    break
                end
            end
        end
    end

end

function this.RestNeeded()
    return false
end

function this.PrepareNeeded()
    if not UnitAffectingCombat("player") then return true end
end

function this.CombatNeeded()
    return UnitAffectingCombat("player")
end

function this.ExecuteRest()
end

-- OOC
function this.ExecutePrepare()
  rebuff()
end

function this.ExecuteCombat()
    local manaPercent = UnitPower('player') / UnitPowerMax('player') * 100
    local healthPercentage = UnitHealthPercent('player')
    local isCasting = CastingInfo('player')
    local hasPet = ExUnitExists('pet')
    local enemies = UnitsAroundUnit('player', 40)

    if UnitHealthPercent('player') < 65 and getHealthStone() and GetItemCooldown(getHealthStone()) == 0 then
        useItem(getHealthStone(), 'player')
    end

    if not ExUnitExists('target') or UnitIsDeadOrGhost('target') then
        return
    end

    if hasPet and (not UnitExists('pettarget') or not UnitIsUnit('target', 'pettarget')) then
        ExecuteMacro('/petattack')
    end

    if ChannelInfo('player') ~= nil then
        return
    end

    -- < DOTS
    if UnitHealthPercent('target') > 30 then
        --TryCastDot(getBest(SPELL_IMMOLATE), 'target') -- This shit eats mana!
        TryCastDot(getBest(SPELL_CORRUPTION), 'target')
        TryCastDot(getBest(SPELL_CURSEOFAGONY), 'target')
    end
    -- DOTS/>

    -- drain soul to get soul shard if we have 0 or mana is less than 40 to proc spirit tap talent
    if UnitHealthPercent('target') <= 10 and (getSoulShardCount() == 0 or manaPercent < 40) then
        stopCasting()
        TryCast(1120, 'target')
        return
    end

    -- <Wand and dot is more Mana Effective DPS
    if HasWandEquipped() and canWand() and dotsExists('target') then
        TryCast(5019, 'target') -- WAND SPAM TO CONSERVE MANA (MP5)
        return
    end
    -- EXECUTION/>

    -- Mana filler if health is full and mana is less than 100%
    if UnitHealthPercent('player') == 100 and manaPercent < 100 then
        TryCast(getBest(SPELL_LIFETAP), 'player')
    end

    --
    if not HasWandEquipped() then
        TryCast(getBest(SPELL_SHADOWBOLT), 'target')
    end
end
