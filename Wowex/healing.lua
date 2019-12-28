--------------------
-- Healing Engine --
--------------------

-- What is needed?
-- - Sort all healable units into tables.
--   - Role
--   - Players and NPCs in a single table (Healable NPCs)
--   - Priority Healing Targets (Unit has a debuff, unit has a certain name, etc..)
-- - Friendly units around unit
-- - Universal Dispel function
-- - How many units in a cone infront of the player

-- Can use to filter conditions to ignore healing
local function CanHeal(unit)
  if DebuffAny(unit,WowEx.Collections.ignoreHealingBuff) then
    print('Cant heal')
    return false
  else
    return true
  end
end

healableUnits = {
  ['Tank'] = {},
  ['Standard'] = {},
  ['Priority'] = {},
}

-- Figure out in game role (Mainly just tanks)
local function IsTank(unit)
  if isClassic == 1 then
    local unitRole = ExUnitGroupRolesAssigned(unit)
    if unitRole == "TANK" then
      --print('Unit is a tank')
      return true
    end
  end
  --print('Unit is not a tank')
  return false
end

-- Assign a role to a unit and add them to a table
local function AddHealable(_unit)
  local isPlayer = ExUnitIsPlayer(_unit)
  local type, zero, server_id, instance_id, zone_uid, NPCID, spawn_uid = strsplit("-", _unit)
  local id = tonumber(NPCID)
   if ExUnitExists(_unit) and UnitLineOfSight('player',_unit) and not ExUnitIsDeadOrGhost(_unit) and UnitHealthPercent(_unit) > 0 and CanCooperate(_unit) and CanHeal(_unit) then
     if isPlayer == true or (id ~= nil and WowEx.Collections.healableNPC[id]) then
        -- tank (Tanks and select NPCs (Dude from PGs))
        if IsTank(_unit) or (id ~= nil and id == 72218) then
          addUnit(_unit,healableUnits.Tank)
        end
        -- standard (All healable units)
        addUnit(_unit,healableUnits.Standard)

        -- priority (UnitID or Buff/Debuff)
      end
   end
end

function updateTableValues(unitGroup)
  if table.getn(unitGroup) == 0 then
    print('Table Empty')
    return
  end
  for i=1,#unitGroup do
    local unit = unitGroup[i].unit
    unitGroup[hp] = UnitHealthPercent(unit)
    local dist = unitGroup[i].distToPlayer

    print(tostring(unitGroup[i].unit))
    print(tostring(unitGroup[i].hp))
    print(tostring(unitGroup[i].distToPlayer))
  end
end

-- Update healing roster
function UpdateHealing()
  healableUnits.lowest = nil;
  healableUnits.lowestTank = nil;

  AddHealable('player') -- player isnt being added to tables
  for i=1,#targets.FriendlyUnits do
    local unit = targets.FriendlyUnits[i].unit
    AddHealable(unit)
    targetCleanup(healableUnits.Standard)
    targetCleanup(healableUnits.Tank)

    -- Update health and distance values

    table.sort(healableUnits.Standard, function(x,y) return x.hp < y.hp end)
    table.sort(healableUnits.Tank, function(x,y) return x.hp < y.hp end)

    if table.getn(healableUnits.Standard) > 0 then
      healableUnits.lowest = healableUnits.Standard[1].unit
    end
    if table.getn(healableUnits.Tank) > 0 then
      healableUnits.lowestTank = healableUnits.Tank[1].unit
    end
  end
end

-----------------------
-- Healing Fucntions --
-----------------------

-- dynamic healing values, change based on mana
-- valueA is lower, valueB is higher
function DynamicPercent(valueA,valueB)
  local mana = ExUnitPower('player') / ExUnitPowerMax('player') * 100
  local scale = mana * 0.01
  local diff = valueB - valueA
  return valueA + (diff * scale)
end

-- Friendly Units Infront (Need Cone Support)
function FriendlyUnitsInfront(range,healthThreshold,degrees)
  local count = 0
  for i = 1,#healableUnits.Standard do
    local unit = healableUnits.Standard[i].unit
    if UnitIsFacing(unit,'player') and UnitDistance('player',unit) <= range and UnitHealthPercent(unit) <= healthThreshold then
      count = count + 1
    end
  end
  return count
end

-- Friendly units around unit that need healing
function FriendlyAroundUnit(unit,range,healthThreshold)
  if ExUnitExists(unit) then
    local total = 0
    for i = 1,#healableUnits.Standard do
      local _unit = healableUnits.Standard[i].unit
      if UnitDistance(_unit,unit) <= range and UnitHealthPercent(_unit) <= healthThreshold then
        total = total + 1
      end
    end
    return total
  end
end

function FriendliesWithBuff(buff)
  local count = 0
  for i = 1,#healableUnits.Standard do
    local unit = healableUnits.Standard[i].unit
    if Buff(unit,buff) then
      count = count + 1
    end
  end
  return count
end

function LowestFriendlyWithoutBuff(buff)
  for i = 1,#healableUnits.Standard do
    local unit = healableUnits.Standard[i].unit
    if not Buff(unit,buff) then
      return unit
    end
  end
end

local dispelSpecs = {
    [62] = { ["Curse"] = true},
    [63] = { ["Curse"] = true},
    [64] = { ["Curse"] = true},
    [65] = { ["Disease"] = true, ["Magic"] = true, ["Poison"] = true},
    [66] = { ["Disease"] = true, ["Poison"] = true},
    [70] = { ["Disease"] = true, ["Poison"] = true},
    [102] = { ["Curse"] = true, ["Poison"] = true},
    [103] = { ["Curse"] = true, ["Poison"] = true},
    [105] = { ["Curse"] = true, ["Magic"] = true, ["Poison"] = true},
    [256] = { ["Disease"] = true, ["Magic"] = true},
    [257] = { ["Disease"] = true, ["Magic"] = true},
    [258] = { ["Disease"] = true},
    [262] = { ["Curse"] = true},
    [263] = { ["Curse"] = true},
    [264] = { ["Curse"] = true, ["Magic"] = true},
    [269] = { ["Disease"] = true, ["Poison"] = true},
    [270] = { ["Disease"] = true, ["Magic"] = true, ["Poison"] = true},
}

function Dispel(spell)
  for i=1,#healableUnits.Standard do
    local currentSpec = GetSpecialization()
    local id = GetSpecializationInfo(currentSpec)
    -- Spec checks. Maybe move to table for cleaner look
    local magic = false
    local disease = false
    local poison = false
    local curse = false
    if id == 65 or id == 105 or id == 256 or id == 257 or id == 264 or id == 270 then
      magic = true
    end
    if id == 65 or id == 66 or id == 70 or id == 256 or id == 257 or id == 258 or id == 269 or id == 270 then
      disease = true
    end
    if id == 65 or id == 66 or id == 70 or id == 102 or id == 103 or id == 105 then
      poison = true
    end
    if id == 62 or id == 63 or id == 64 or id == 102 or id == 103 or id == 105 or id == 262 or id == 263 or id == 264 then
      curse = true
    end
    local unit = healableUnits.Standard[i].unit
    local name = ObjectName(unit)
    for i=1,40 do
      local debuffName,_,_,_,_,endTime,_,_,_,spellID = ExUnitDebuff(unit,i)
      local count = DebuffCountAny(unit,spellID)
      if endTime == nil then
        endTime = 999
      end
      local duration = endTime - GetTime()
      if WowEx.Collections.PvEDispels[spellID] and WowEx.Collections.PvEDispels[spellID].Time >= duration and WowEx.Collections.PvEDispels[spellID].Count >= count and (WowEx.Collections.PvEDispels[spellID].Radius ~= nil and FriendlyAroundUnit(unit,WowEx.Collections.PvEDispels[spellID].Radius,100) or WowEx.Collections.PvEDispels[spellID].Radius == nil) <= 1 then
        if WowEx.Collections.PvEDispels[spellID].Type == 'Magic' and magic == true then
          --print('Found a Magic debuff on '..name)
          TryCast(spell,unit)
        end
        if WowEx.Collections.PvEDispels[spellID].Type == 'Poison' and poison == true then
          --print('Found a Poison debuff on '..name)
          TryCast(spell,unit)
        end
        if WowEx.Collections.PvEDispels[spellID].Type == 'Curse' and curse == true then
          --print('Found a Curse debuff on '..name)
          TryCast(spell,unit)
        end
        if WowEx.Collections.PvEDispels[spellID].Type == 'Disease' and disease == true then
          --print('Found a Disease debuff on '..name)
          TryCast(spell,unit)
        end
      else
        --print('Have no debuff to dispel')
      end
    end
  end
end
