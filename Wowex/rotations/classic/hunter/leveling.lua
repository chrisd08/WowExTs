-- This is a mage test file

local id = 3
if not Rotations[id] then
    Rotations[id] = {}
end
local this = Rotations[id]
--------------------
-- Temp Functions --
--------------------
-- local function enemiesInRange(unit,range)
--   local count = 0
--   for i = 1,#targets.HarmfulTargets do
--     local _unit = targets.HarmfulTargets[i].unit
--     if UnitDistance(unit,_unit) <= range then
--       count = count + 1
--     end
--   end
--   return count
-- end

---------------
-- Variables --
---------------
_arcaneShot = {3044}
_huntersMark = {1130}
_frostNova = {10230,6131,865,122}
_arcaneIntellect = {10157,10156,1461,1460,1459}
_arcaneExplosion = {10202,10201,8439,8438,8437,1449}

-------------
 -- Spells --
 ------------
local arcaneShot = getBest(_arcaneShot)
local huntersMark = getBest(_huntersMark)
local frostNova = getBest(_frostNova)
local arcaneIntellect = getBest(_arcaneIntellect)
local arcaneExplosion = getBest(_arcaneExplosion)

local function ranged()
  local mana = UnitPower('player') / UnitPowerMax('player') * 100
  if AuraRemains('target',huntersMark,true) <= 10 then TryCast(huntersMark,'target') end

  -- local isShooting = IsCurrentSpell(75)
  -- if not isShooting then TryCast(75,'target') end

  if AuraRemains('target',1978) <= 1.5 then TryCast(1978,'target') end
  if mana >= 35 then TryCast(3044,'target') end
end

local function melee()
  local attacking = IsCurrentSpell(6603)
  if attacking == false then MeleeStartAttack() end

  TryCast(2973,'target')
end

function this.RestNeeded()
    return false
end

function this.PrepareNeeded()
    if not ExUnitAffectingCombat("player") then return true end
end

function this.CombatNeeded()
    return ExUnitAffectingCombat("player")
end

function this.ExecuteRest()
    --print('Resting')
end

-- OOC
function this.ExecutePrepare()
  if ExUnitCanAttack('player','target') and AuraRemains('target',huntersMark,true) <= 10 then TryCast(huntersMark,'target') end
end

function this.ExecuteCombat()

  if UnitDistance('player','target') >= 8 then
    ranged()
  else
    melee()
  end
end
