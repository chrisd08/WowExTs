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

local corruption = getBest(SPELL_CORRUPTION)
local immolate = getBest(SPELL_IMMOLATE)
local curseOfAgony = getBest(SPELL_CURSEOFAGONY)
local shadowbolt = getBest(SPELL_SHADOWBOLT)
local lifetap = getBest(SPELL_LIFETAP)
local demonskin = getBest(SPELL_DEMONSKIN)
local healthstone = getBest(SPELL_HEALTHSTONE)
local pet = getBest(SPELL_PET)
local healthFunnel = getBest(SPELL_HEALTH_FUNNEL)

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
    if (corruption ~= nil and AuraRemains(unit,corruption) > 3) then
      if curseOfAgony == nil then
        return true
      elseif AuraRemains(unit,curseOfAgony > 3) then
        return true
      end
    else
        return false
    end
end

local function petCare()
  local hasPet = ExUnitExists('pet')
  -- Summon pet (Void walker or imp depending on what we have access to)
  if pet ~= nil and (ExUnitIsDeadOrGhost('pet') or not hasPet) and getSoulShardCount() > 0 and LocalPlayer.LastCastSucceeded ~= pet then
    TryCast(pet,'player')
    return
  end
  if pet ~= nil and (ExUnitIsDeadOrGhost('pet') or not hasPet) and getSoulShardCount() == 0 and LocalPlayer.LastCastSucceeded ~= pet then
    TryCast(688,'player')
    return
  end

  -- Stop casting health funnel if pet is almost full.
  if healthFunnel ~= nil and UnitHealthPercent('pet') >= 90 and getChannelID() == healthFunnel then
      stopCasting()
  end
  -- Heal pet
  if healthFunnel ~= nil and hasPet and UnitHealthPercent('pet') < 60 and UnitHealthPercent('player') > 80 then
      TryCast(healthFunnel,'player')
  end

end

function rebuff()
    local hasPet = ExUnitExists('pet')
    local manaPercent = UnitPower('player') / UnitPowerMax('player') * 100

     -- Demon Skin Buff
    if demonskin ~= nil and not HasBuff('player',demonskin) then TryCast(demonskin,'player') end

    -- Create healthstone
    if healthStone ~= nil and not getHealthStone() and getSoulShardCount() > 0 then
        TryCast(healthStone,'player')
    end

    -- mana filler out of combat
    if lifetap ~= nil and UnitHealthPercent('player') >= 80 and manaPercent < 100 then TryCast(lifetap, 'player') end

    -- Delete extra soulshards since its unnecesary bag space.
    if getSoulShardCount() > 5 then
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
  if not IsMoving('player') then
    petCare()
  end
  rebuff()
end

function this.ExecuteCombat()
    local manaPercent = ExUnitPower('player') / ExUnitPowerMax('player') * 100
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

    if not IsMoving('player') then
      petCare()
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
      if corruption ~= nil then
        TryCastDot(corruption,'target')
      end
      if curseOfAgony ~= nil then
        TryCastDot(curseOfAgony,'target')
      end
    end
    -- DOTS/>

    -- drain soul to get soul shard if we have 0 or mana is less than 40 to proc spirit tap talent
    if IsSpellKnown(1120) and UnitHealthPercent('target') <= 10 and (getSoulShardCount() <= 5 or manaPercent < 40) then
        stopCasting()
        TryCast(1120, 'target')
        return
    end

    -- Mana filler if health is full and mana is less than 100%
    if lifetap ~= nil and UnitHealthPercent('player') >= 80 and manaPercent < 50 then
        TryCast(lifetap, 'player')
    end

    -- Decide if we want to wand or cast SB
    if manaPercent >= 45 and shadowbolt ~= nil then TryCast(shadowbolt, 'target') end
    if manaPercent < 45 and not IsMoving('player') and HasWandEquipped() and canWand() then
      --TryCast(5019, 'target') -- WAND SPAM TO CONSERVE MANA (MP5)

      return
    end

    -- -- <Wand and dot is more Mana Effective DPS
    --   if not IsMoving('player') and HasWandEquipped() and canWand() and (UnitHealthPercent('target') <= 30 or dotsExists('target')) then
    --       TryCast(5019, 'target') -- WAND SPAM TO CONSERVE MANA (MP5)
    --       return
    --   end
    --
    -- -- Mana filler if health is full and mana is less than 100%
    -- if lifetap ~= nil and UnitHealthPercent('player') >= 80 and manaPercent < 45 then
    --     TryCast(lifetap, 'player')
    -- end
    --
    -- if shadowbolt ~= nil and not HasWandEquipped() then
    --     TryCast(shadowbolt, 'target')
    -- end
end
