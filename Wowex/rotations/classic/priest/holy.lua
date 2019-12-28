local id = 5
if not Rotations[id] then
    Rotations[id] = {}
end
local this = Rotations[id]



--------------------
-- Healing Values --
--------------------

--------------------
--------------------
--------------------

local mana = UnitPower('player') / UnitPowerMax('player') * 100

local function buff()
  -- Inner Fire
  if AuraRemains('player',588) <= 600 then TryCast(588,'player') end
  if AuraRemains('player',1244) <= 120 then TryCast(1244,'player') end

end

local function dps()
  -- Shadow Word: Pain
  if AuraRemains('target',589) <= 1.5 then TryCast(589,'target') end
  -- Mind Blast
  if mana >= 60 then TryCast(8092,'target') end
  -- Smite above 60% mana
  if mana >= 60 then TryCast(585,'target') end
  -- wand spam
  TryCast(5019,'target')

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
    --print('Resting')
end

-- OOC
function this.ExecutePrepare()
  print('Test')
  buff()
end

function this.ExecuteCombat()

end
