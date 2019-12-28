local LibClassicDurations = LibStub("LibClassicDurations")
LibClassicDurations:Register("WowEx") -- tell library it's being used and should start working

---------------
-- Last Cast --
---------------
local Cache = HeroCache
local spellcache =
  setmetatable(
  {},
  {
    __index = function(t, v)
      local a = {GetSpellInfo(v)}
      if GetSpellInfo(v) then
        t[v] = a
      end
      return a
    end
  }
)
function GetSpellInfoEx(spell)
  return unpack(spellcache[spell])
end

LocalPlayer = {
  LastCastSucceeded = 0,
  LastCastSucceeded2 = 0,
  LastCastSucceeded3 = 0
}

local LineOfSightExceptions = {
  [44566] = true,
  [46753] = true,
  [56754] = true,
  [61463] = true,
  [72156] = true,
  [76267] = true,
  [76379] = true,
  [76585] = true,
  [76973] = true,
  [76974] = true,
  [77182] = true,
  [91331] = true,
  [91005] = true,
  [91808] = true,
  [96028] = true,
  [97259] = true,
  [97260] = true,
  [96759] = true,
  [98363] = true,
  [98696] = true,
  [99801] = true,
  [100354] = true,
  [100360] = true,
  [120436] = true,
  [118460] = true,
  [116939] = true,
  [119072] = true,
  [119397] = true,
  [119072] = true,
  [118460] = true,
  [118462] = true,
  [120368] = true,
  [122450] = true,
  [124167] = true,
  [123371] = true,
  [128154] = true,
  [128429] = true,
  [125050] = true,
  [122578] = true,
  [127231] = true,
  [127230] = true,
  [127235] = true,
  [122773] = true,
  [122778] = true,
  [128429] = true,
  [114537] = true,
  [105906] = true,
  [100362] = true,
  [98363] = true,
  [96759] = true,
  [91808] = true,
  [91005] = true,
  [131863] = true, --BIG BOY MANOR
  [137625] = true,
  [137405] = true,
  [137626] = true,
  [137614] = true,
  [137627] = true,
  [137119] = true,
  [138959] = true,
  [138530] = true,
  [140447] = true, --HENTA
  [143648] = true,
  [140393] = true, -- Tendril's Gore
  [146256] = true, -- Laminaria
  [147376] = true, -- Barrier
  [148890] = true, -- Wall of Ice
  [149907] = true, -- Wall of Ice
  [133392] = true,
  [131199] = true --Pridze
}

function ObjectId(unit)
  if not IsGuid(unit) then
    return -1
  end
  return tonumber(unit('-(%d+)-%x+$'), 10)
end

local function _EnumVisibleObjects()
  local wowObjects = {}
  local objectCount = GetObjectCount()
  for i = 1, objectCount, 1 do
    local wowObject = GetObjectWithIndex(i)
	if IsGuid(wowObject) then
		wowObjects[wowObject] = wowObject
	end
  end
  return wowObjects
end

function EnumVisibleObjects()
	local test = Cache.Get("Entities", "Objects", "List",function() return _EnumVisibleObjects() end )
	return test
end

-------------------
-- Buffs/Debuffs --
-------------------
local function _UnitBuff(UnitID)
  local Buffs = {}
  for i = 1, 40 do
    local Infos = { ExUnitBuff(UnitID, i) }
    if not Infos[10] then break end
    Buffs[i] = Infos
  end
  return Buffs
end

function HasBuff(target, spell, own, index)
  if not ExUnitExists(target) then return false end
  local Buffs = GetUnitBuffs(target)
  for i = 1, #Buffs do
    local Buff = Buffs[i]
    if Buff[1] == spell or tonumber(spell) == tonumber(Buff[10]) and (own and Buff[7] == own or true) then
      if index then
        return Buff[index]
      end
      local name, _, count, buffType, duration, expiration, caster, isStealable,
      _,spellId,_, isBoss = unpack(Buff);
      return name, count, expiration, caster, buffType, isStealable, isBoss
    end
  end
end

local function _UnitDebuff(UnitID)
  local Buffs = {}
  for i = 1, 40 do
    local Infos = { ExUnitDebuff(UnitID, i) }
    if not Infos[10] then break end
    Buffs[i] = Infos
  end
  return Buffs
end

function HasDebuff(target, spell, own, index)
  if not ExUnitExists(target) then return false end
  local Buffs = GetUnitDebuffs(target)
  for i = 1, #Buffs do
    local Buff = Buffs[i]
    if Buff[1] == spell or tonumber(spell) == tonumber(Buff[10]) and (own and Buff[7] == own or true) then
      if index then
        return Buff[index]
      end
      local name, _, count, debuffType, duration, expiration, caster, isStealable,
      _,spellId,_, isBoss = unpack(Buff);
      return name, count, expiration, caster, debuffType, isStealable, isBoss
    end
  end
end

function GetUnitDebuffs(target)
	local debuffs = Cache.Get("UnitInfo", target, "Debuffs",function() return _UnitDebuff(target) end )
	return debuffs
end

function GetUnitBuffs(target)
	local debuffs = Cache.Get("UnitInfo", target, "Buffs",function() return _UnitBuff(target) end )
	return debuffs
end
function Buff(target, spell)
  return HasBuff(target, spell, 'PLAYER') ~= nil
end

function BuffCount(target, spell)
  local _,count = HasBuff(target, spell, 'PLAYER')
  return count or 0
end

function BuffDuration(target, spell)
  local buff,_,expires = HasBuff(target, spell, 'PLAYER')
  return buff and (expires - GetTime()) or 0
end

function BuffAny(target, spell)
  return HasBuff(target, spell) ~= nil
end

function BuffCountAny(target, spell)
  local _,count = HasBuff(target, spell)
  return count or 0
end

-- /script print(BuffDurationAny('player', 'Arcane Intellect'))
function BuffDurationAny(target, spell)
  local buff,
    _,
    expires = HasBuff(target, spell)
  return buff and (expires - GetTime()) or 0
end

function Debuff(target, spell)
  return HasDebuff(target, spell, 'PLAYER') ~= nil
end

function DebuffCount(target, spell)
  local _,count = HasDebuff(target, spell, 'PLAYER')
  return count or 0
end

function DebuffDuration(target, spell)
  local buff,_,expires = HasDebuff(target, spell, 'PLAYER')
  return buff and (expires - GetTime()) or 0
end

function DebuffAny(target, spell)
  return HasDebuff(target, spell) ~= nil
end

function DebuffCountAny(target, spell)
  local _,count = HasDebuff(target, spell)
  return count or 0
end

function DebuffDurationAny(target, spell)
  local buff,
    _,
    expires = HasDebuff(target, spell)
  return buff and (expires - GetTime()) or 0
end

------------
-- Spells --
------------
-- /script print(SpellCooldown('Kill Command'))
function SpellCooldown(spell)
  local start,duration = GetSpellCooldown(spell)
  if not start then
    return 0
  end
  return start ~= 0 and (start + duration - GetTime()) or 0
end

-- /script print(SpellRecharge('Barbed Shot'))
function SpellRecharge(spell)
  local time = GetTime()
  local _,
    _,
    start,
    duration = GetSpellCharges(spell)
  if start and (start + duration - time) > duration then
    return 0
  end
  return start and (start + duration - time)
end

-- /script print(SpellCharges('Barbed Shot'))
function SpellCharges(spell)
  local charges,
    maxCharges,
    start,
    duration = GetSpellCharges(spell)
  if duration and charges ~= maxCharges then
    charges = charges + ((GetTime() - start) / duration)
  end
  return charges or 0
end

-- /script print(gcd())
function gcd()
  local class = select(3, ExUnitClass('player'))
  -- Some class's always have GCD = 1
  if class == 4 or (class == 11 and GetShapeshiftForm() == 2) or (class == 10 and GetSpecialization() ~= 2) then
    return 1
  end
  return math.floor((1.5 / ((GetHaste() / 100) + 1)) * 10 ^ 3) / 10 ^ 3
end

-- /script print(GetSelectedTalent(7))
function GetSelectedTalent(tier)
  _,s = GetTalentTierInfo(tier, 1)
  return s
end

-- /script IsAttacking()
function IsAttacking()
  if IsCurrentSpell(6603) then
    return true
  else
    return false
  end
end

function MeleeStartAttack()
  CallSecureFunction('RunMacroText', '/startattack')
end


----------
-- Unit --
----------

function UnitHealthPercent(unit)
  if not unit then
    return 0
  end
  return ExUnitHealth(unit) / ExUnitHealthMax(unit) * 100
end

function ExecuteMacro(macroText)
  CallSecureFunction('RunMacroText', macroText)
end

function Self(unit)
  if not ExUnitExists(unit) then
    return false
  else
    return ExUnitIsUnit(unit,'player')
  end
end

function round2(num, idp)
  mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function ttd(unit)
  if unit == nil then
    timeToDie = 0
  end
  if ExUnitExists(unit) and not ExUnitIsDead(unit) then
    if hpStart == nil then
      hpStart = 0
    end
    if hpCurrent == nil then
      hpCurrent = 0
    end
    if timeStart == nil then
      timeStart = 0
    end
    if hpStart == 0 and timeStart == 0 then
      hpStart = RealMobHealth.GetUnitHealth("target")
      timeStart = GetTime()
    else
      hpCurrent = RealMobHealth.GetUnitHealth("target")
      timeCurrent = GetTime()
      print(timeCurrent - timeStart)
      if hpCurrent >= hpStart then
        hpStart = hpCurrent
        timeToDie = 0
      else
        if ((timeCurrent - timeStart) == 0) or ((hpStart - hpCurrent) == 0) then
          timeToDie = 0
        else
          timeToDie = round2(hpCurrent / ((hpStart - hpCurrent) / (timeCurrent - timeStart)),2)
        end
      end
    end
    if timeToDie == nil then
      timeToDie = 0
      return timeToDie
    else
      --print(ttd)
      return timeToDie
    end
  end
end

-- party check
function PartyCheck()
  if IsInRaid() then
      return 3
  elseif IsInGroup() then
      return 2
  else
      return 1
  end
end

-- function Interupt(interuptSpell,ccSpell)
--   for i = 1,#targets.HarmfulTargets do
--     local _,_,_,startTime,endTime,_,_,_spellid = ExUnitCastingInfo(targets.HarmfulTargets[i].unit)
--
--     local castLength = (endTime - startTime) / 1000 or 0
--     local secondsDone = GetTime() - (startTime / 1000) or 0
--     local remaining = ((secondsDone / castLength) * 100) or 0
--
--     local unit = targets.HarmfulTargets[i].unit
--     if WowEx.Collections.PvEInterrupt[spellid] then
--       print('Casting a spell on the list')
--       percent = WowEx.Collections.PvEInterrupt[spellid].Percent or math.random(30,50)
--       print('Percent to interupt is '..percent)
--       if WowEx.Collections.PvEInterrupt[spellid].useKick and percent < remaining then
--         TryCast(interuptSpell,unit)
--       end
--       if WowEx.Collections.PvEInterrupt[spellid].useCC and percent < remaining  then
--         TryCast(ccSpell,unit)
--       end
--     end
--   end
-- end

function CanCooperate(unit)
    if not unit then
        return false
    end

    if ExUnitIsVisible(unit)
            and not ExUnitIsCharmed(unit)
            and ExUnitReaction('player', unit) > 4
            and not ExUnitIsDeadOrGhost(unit)
            and ExUnitIsConnected(unit) then
        return true
    end

    return false
end

--------------
-- Position --
--------------
-- /script print(_UnitLocation('player'))
local function _UnitLocation(unit)
  local UnitLocationX, UnitLocationY, UnitLocationZ = GetUnitPosition(unit)
    local unit_location = {
      [1] = UnitLocationX,
      [2] = UnitLocationY,
      [3] = UnitLocationZ
    }
  return unit_location
end

-- /script print(UnitLocation('target'))
function UnitLocation(unit)
  if unit then
      return Cache.Get("UnitInfo", unit, "Position", function() return _UnitLocation(unit) end)
  end
  return nil
end

-------------
-- Casting --
-------------
local function _UnitLineOfSight(unita, unitb)
  -- Disable LoS for classic temp
  -- if isClassic ~= 1 then
  --   return true
  -- end
  if not unita or not unitb then
    return false
  end

  if (unita and unita == 'player') and (unitb and unitb == 'player') then
    return true
  end

  if IsGuid(unitb) then
    local id = ObjectId(otherUnit)
    if WowEx.Collections.LineOfSightExceptions[id] then
      return true
    end
  end

  local ax,ay,az = unpack(UnitLocation(unitb))
  local bx,by,bz = unpack(UnitLocation(unita))
  return TraceLine(ax, ay, az, bx, by, bz, 0x100010) == 1
end

function UnitLineOfSight(unita, unitb)
  local result = Cache.Get("UnitInfo", unitb, "LoS",function() return _UnitLineOfSight(unita, unitb) end )
  return result
end

-- /script print(UnitDistance('player', 'target'))
local function _UnitDistance(unit, otherUnit)
  local ax,ay,az = unpack(UnitLocation(unit)) -- 'Attacker'
  local bx,by,bz = unpack(UnitLocation(otherUnit)) -- 'Defender'
  -- local reach = 0
  -- reach = (UnitCombatReach(unit) or 0)+ (UnitBoundingRadius(otherUnit) or 0)
  if ax == nil or bx == nil then
    return math.huge
  end
  return math.sqrt((bx - ax) * (bx - ax) + (by - ay) * (by - ay) + (bz - az) * (bz - az))
end

-- /script print(UnitDistance('player','target'))
-- function UnitDistance(unit, otherUnit)
--   local result = Cache.Get("UnitInfo", otherUnit, "Distance",function() return _UnitDistance(unit, otherUnit) end )
--   return result
-- end

function UnitDistance(unit, otherUnit)
  local result = _UnitDistance(unit, otherUnit)
  return result
end

-- /script print(UnitIsFacing('player', 'target'))
function UnitIsFacing(unit1, unit2, degress)
  -- if isClassic ~= 1 then
  --   return true
  -- end
  if not degress then
    degress = 0
  end
  if not unit1 or not unit2 then
    return false
  end
  if ExUnitIsVisible(unit1) and ExUnitIsVisible(unit2) then
    local X,
      Y = unpack(UnitLocation(unit1))
    local rotation = UnitFacing(unit1)
    local unitX,
      unitY = unpack(UnitLocation(unit2))
    return ((X - unitX) * math.cos(-rotation)) - ((Y - unitY) * math.sin(-rotation)) < degress or UnitDistance(unit1, unit2) < 1.5
  end
end

function MovingAwayFrom(unit, target)
    if (not IsMoving(unit)) then
      return false
    end
    local rotation = UnitFacing(unit)
    local hX, hY, hZ = math.cos(rotation), math.sin(rotation), 0
    local uX, uY, uZ = unpack(UnitLocation(unit));
    local tX, tY, tZ = unpack(UnitLocation(target));
    local dX, dY, dZ = tX - uX, tY - uY, tZ - uZ;
    local length = math.sqrt(dX * dX + dY * dY + dZ + dZ)
    dX, dY, dZ = dX / length, dY / length, 0
    return math.acos(hX * dX + hY * dY + hZ * dZ) > 0.75;
end

function IsMoving(unit)
  local speed = GetUnitSpeed(unit)
  if speed ~= 0 then
    return true
  else
    return false
  end
end

function CanCast(id, unit, ignoreLos, ignoreFacing, ignoreCasting,ignoreMounted)
  if IsSpellKnown(id) == false then
    return false
  end
  if not ExUnitExists(unit) then
    return false
  end
  if ExUnitIsDead(unit) then
    return false
  end
  local canUse,nomana = IsUsableSpell(id)
  local isCooldown = GetSpellCooldown(id) == 0
  local inRange = ExIsSpellInRange(GetSpellInfoEx(id),unit)
  local inLos = false
  local casting
  if isClassic == 1 then
    --print('Retail')
    casting = ExUnitCastingInfo('player') or ExUnitChannelInfo('player')
  else
    --print('Classic')
    casting = CastingInfo('player') or ChannelInfo('player')
  end
  local isCasting = true
  local mountCheck = false
  if ignoreMounted then
    mountCheck = false
  else
    mountCheck = IsMounted()
  end
  if ignoreLos then
    inLos = true
  else
    inLos = UnitLineOfSight('player', unit)
  end
  if unit ~= nil and (unit == 'player' or unit == UnitGUID('player')) then
    inLos = true
  end
  if inRange == nil or inRange > 0 then
    inRange = true
  else
    inRange = false
  end
  local isFacing = false
  if ignoreFacing then
    isFacing = true
  else
    isFacing = UnitIsFacing('player', unit)
  end
  if ignoreCasting then
    isCasting = false
  elseif casting == nil then
    isCasting = false
  end

  -- print('canUse: '..tostring(canUse))
  -- print('nomana: '..tostring(nomana))
  -- print('isCooldown: '..tostring(isCooldown))
  -- print('inRange: '..tostring(inRange))
  -- print('inLos: '..tostring(inLos))
  -- print('isFacing: '..tostring(isFacing))
  --print('spell: '..tostring(casting))
  --print('isCasting: '..tostring(isCasting))
  -- print('mountCheck: '..tostring(mountCheck))

  return canUse and not nomana and isCooldown and inRange and inLos and isFacing and not isCasting and not mountCheck
end

function Cast(spellId, target)
  if type(spellId) == 'number' then
    if target then
      if IsGuid(target) then
        CallSecureFunction('CastSpellByID', spellId, SetMouseOver(target))
      else
        CallSecureFunction('CastSpellByID', spellId, target)
      end
    else
      CallSecureFunction('CastSpellByID', spellId)
    end
  else
    if target then
      if IsGuid(target) then
        CallSecureFunction('CastSpellByName', spellId, SetMouseOver(target))
      else
        CallSecureFunction('CastSpellByName', spellId, target)
      end
    else
      CallSecureFunction('CastSpellByName', spellId)
    end
  end
end

-- /script print(TryCast('Arcane Intellect', 'player', true))
function TryCast(spell, unit, ignoreLos, ignoreFacing, ignoreCasting)
  local GCDstart, GCDduration, GCDenable = GetSpellCooldown(61304)
  local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats()
  local readyToCast = GCDstart <= latencyWorld * 2 * 0.001 or GCDduration <= latencyWorld * 2 * 0.001
  if not readyToCast then
      return false
  end
  if CanCast(spell, unit, ignoreLos, ignoreFacing, ignoreCasting) then
    Cast(spell, unit)
    return true
  end
  return false
end

function FaceLocation(X, Y)
  local PlayerX, PlayerY = unpack(UnitLocation('player'))
  if rad(atan2(Y - PlayerY, X - PlayerX)) < 0 then
    FaceDirection(rad(atan2(Y - PlayerY, X - PlayerX) + 360))
  else
    FaceDirection(rad(atan2(Y - PlayerY, X - PlayerX)))
  end
  UpdateMovement()
end

function CastGround(spell, unit)
  if GetSpellCooldown(spell) == 0 and UnitLineOfSight('player', unit) then
    Cast(spell)
    ClickPosition(unpack(UnitLocation(unit)))
  end
end

-- /script print(HasAzeriteTrait(367))
function HasAzeriteTrait(traitID)
  local isSelected
  for _, itemLocation in AzeriteUtil.EnumerateEquipedAzeriteEmpoweredItems() do
    isSelected = C_AzeriteEmpoweredItem.IsPowerSelected(itemLocation, traitID)
    if isSelected then
      return true
    end
  end
  return false
end

-- Try and interrupt a unit.
function TryInterruptUnit(unit, percentInterrupt, spellId)
  local percent = tonumber(percentInterrupt) or 100
  local spell = GetSpellInfoEx(spellId) or false
  local name,_,_,startTime,endTime,_,_,notInterruptible = ExUnitCastingInfo(unit)
  if not name then
    name,_,_,startTime,endTime,_,notInterruptible = ExUnitChannelInfo(unit)
    percent = 100 - percent
  end

  --print(name)
  if name and startTime and endTime and ((spellId and name == spell) or (not spellId and not notInterruptible)) then
    local castTimeRemaining = endTime / 1000 - GetTime()
    local castTimeTotal = (endTime - startTime) / 1000
    -- print(castTimeRemaining / castTimeTotal * 100)
    if castTimeTotal > 0 and castTimeRemaining / castTimeTotal * 100 <= percent then
      return true
    end
  end
  return false
end

function IsCreatedByUnit(unit, creation)
    if not unit or not creation or not IsGuid(unit) or not IsGuid(creation) then
        return false
    end
    return ObjectField(creation, 0x1538, 15) == unit
end

function IsSummonedByUnit(unit, creation)
    if not unit or not creation or not IsGuid(unit) or not IsGuid(creation) then
        return false
    end
    return ObjectField(creation, 0x1528, 15) == unit
end

function IsPlayerCasting()
  return CastingInfo() or ChannelInfo()
end

function IsCasting(unit, spell)
    local _,_,_,_,_,_,_,_,id = ExUnitCastingInfo(unit, spell)
    if id and id == spell then
        return true
    end
    local _,_,_,_,_,_,_,_,id = ExUnitChannelInfo(unit, spell)
    if id and id == spell then
        return true
    end
    return false
end
------------------
-- Force Facing --
------------------
function GetAnglesBetweenObjects(Object1, Object2)
  local ax,ay,az = unpack(UnitLocation(Object1)) -- 'Attacker'
  local bx,by,bz = unpack(UnitLocation(Object2)) -- 'Defender'
  if ax == nil or bx == nil then
    return nil, nil
  end

  return GetAnglesBetweenPositions(ax, ay, az, bx, by, bz)
end

function GetAnglesBetweenPositions(X1, Y1, Z1, X2, Y2, Z2)
  return math.atan2(Y2 - Y1, X2 - X1) % (math.pi * 2), math.atan((Z1 - Z2) / math.sqrt(math.pow(X1 - X2, 2) + math.pow(Y1 - Y2, 2))) % math.pi
end

function TestTargetUnit(Object)
  if IsGuid(Object) then
    CallSecureFunction('TargetUnit', SetMouseOver(Object))
  else
    CallSecureFunction('TargetUnit', Object)
  end
end

function AutoTarget(Object)
  if ExUnitIsDead('target') or not ExUnitExists('target') and ExUnitExists(Object) then
    --print('We need a new target')
    TestTargetUnit(Object)
  end
end

function UnitIsMoving(unit)
  if ExUnitIsVisible(unit) then
    return ExGetUnitSpeed(unit) > 0
  end
  return false
end

local timer = GetTime()
function FaceObject(Object1)
  if GetTime() - timer > 0.020 then
    timer = GetTime()
    local radians = GetAnglesBetweenObjects('player', Object1)
    FaceDirection(radians)
    UpdateMovement() -- or UpdatePlayerMovement() I forget
  end
end

function useItem(name, target)
  -- Keeping the target in here because of maybe some bandaid haxx?
  CallSecureFunction('UseItemByName', name, target)
end

-----------------------
-- Classic Functions --
-----------------------

function AuraRemains(target, SpellID, allPlayers)
  local duration, expirationTime
    if allPlayers then
      duration, expirationTime = LibClassicDurations:GetAuraDurationByUnit(target, SpellID)
    end
    duration, expirationTime = LibClassicDurations:GetAuraDurationByUnit(target, SpellID, UnitGUID('player'))

    return expirationTime and expirationTime - GetTime() or 0
end

function run_macro_text(macro_id_or_name)
    CallSecureFunction('RunMacro', macro_id_or_name)
end

function getBest(spelllist)
  for i=1, #spelllist do
    if IsSpellKnown(spelllist[i], false) then
      return spelllist[i]
    end
  end
end

function getChannelID()
  _, _, _, _, _, _,_, spellId = ChannelInfo("player")
  return spellId
end

function stopCasting()
  ExecuteMacro('/stopcasting')
end

function canWand()
  if not LocalPlayer.WandOrShooting then
    return true
  else
    return false
  end
end

function TryCastDot(spell, unit, ignoreLos, ignoreFacing, ignoreCasting)
  local _,_,_,_,_,_,_,_,id = CastingInfo('player')
  local GCDstart, GCDduration, GCDenable = GetSpellCooldown(spell)
  local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats()
  local readyToCast = GCDstart <= latencyWorld * 2 * 0.001 or GCDduration <= latencyWorld * 2 * 0.001
  if not readyToCast then
      return false
  end
  if id == spell and AuraRemains(unit, spell) > 1.5 then
    ExecuteMacro('/stopcasting')
  end
  if CanCast(spell, unit, ignoreLos, ignoreFacing, ignoreCasting) then
    if LocalPlayer.LastCastSucceeded ~= spell and AuraRemains(unit, spell) <= 1.5 then
      Cast(spell, unit)
    return true
  end
end
  return false
end
