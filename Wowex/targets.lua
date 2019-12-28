--
--LuaEx Library
--
targets = {}

targets.IncludeNeturalTargets = false
targets.HarmfulTargets = {}
targets.FriendlyUnits = {}
targets.EnemyPlayers = {}

targets.lowestFriendlyPlayer = nil
targets.lowestEnemyPlayer = nil
targets.lowestHarmfulTarget = nil

targets.closestFriendlyPlayer = nil
targets.closestEnemyPlayer = nil
targets.closestHarmfulTarget = nil

function targetCleanup(unitGroup)
  if table.getn(unitGroup) == 0 then
    return
  end

  for i=1,#unitGroup do
    local unit = unitGroup[i].unit
    local unitIsDead = ExUnitIsDeadOrGhost(unit);
    local unitDistance = UnitDistance('player',unit)
    -- print('Dead: '..tostring(unitIsDead)..' Dist: '..unitDistance)
    if unitDistance > 60 or unitIsDead then
      --print('Removing '..tostring(unit)..' from '..tostring(unitGroup))
      table.remove(unitGroup,i)
      break
    end
  end
end

function addUnit(pointer,unitGroup)
  --print('Inside addUnit')
  if table.getn(unitGroup) == 0 then
    --print(tostring(unitGroup)..' is empty. Adding '.. tostring(pointer)..' to '..tostring(unitGroup))
    table.insert(unitGroup,{unit=pointer, hp=100, distToPlayer=0});
  end

  local validUnit = true
  for i=1,#unitGroup do
    --print('Scanning units')
    local unit = unitGroup[i].unit
    if unit == pointer then
      --print(tostring(unit)..' | '..tostring(pointer))
      validUnit = false
      break
    end
  end
  if validUnit == true then
    table.insert(unitGroup,{unit=pointer, hp=100, distToPlayer=0});
  end
end

function targets:updateTargets()
	targets.lowestFriendlyPlayer = nil;
	targets.lowestEnemyPlayer = nil;
	targets.lowestHarmfulTarget = nil;

	for i=1,GetObjectCount() do
		local pointer = GetObjectWithIndex(i);
		if IsGuid(pointer) then
			local distanceToPointer
			local pointerIsEnemy
			local pointerIsFriend
			local pointerIsDead
			local arena
			local reaction = ExUnitReaction('player',pointer)
			distanceToPointer = UnitDistance("player",pointer)
      local reactionThreshHold = 3
      if targets.IncludeNeturalTargets then
        reactionThreshHold = 4
      end
			pointerIsEnemy = ExUnitCanAttack("player", pointer) and reaction and reaction <= reactionThreshHold;
			pointerIsFriend = reaction and reaction >=5;
			pointerIsDead = ExUnitIsDeadOrGhost(pointer);
			--pointerIsPlayer = ExUnitIsPlayer(pointer)
			if select(2,IsInInstance()) == "arena" then
				arena = true;
			else
				arena = nil;
			end
			if arena then dist=60 else dist=60 end
			if distanceToPointer <= dist then
				--enemyplayers
				if pointerIsEnemy and pointerIsPlayer and not pointerIsDead then
					addUnit(pointer,targets.EnemyPlayers)
				end
				--enemies without cancerous critters
				if pointerIsEnemy and not pointerIsDead and ExUnitCreatureType(pointer) ~= "Critter" then
          --print('found a mob')
					addUnit(pointer,targets.HarmfulTargets)
				end
				--friends
				if pointerIsFriend and not pointerIsDead then
          --print('found a friend')
					addUnit(pointer,targets.FriendlyUnits)
        end
			end
    end
	end

  targetCleanup(targets.EnemyPlayers)
  targetCleanup(targets.HarmfulTargets)
  targetCleanup(targets.FriendlyUnits)

  -- Getting valid autotarget
  table.sort(targets.EnemyPlayers, function(x,y) return x.distToPlayer < y.distToPlayer end)
  table.sort(targets.HarmfulTargets, function(x,y) return x.distToPlayer < y.distToPlayer end)
  table.sort(targets.FriendlyUnits, function(x,y) return x.distToPlayer < y.distToPlayer end)

  -- set lowestFriendlyPlayer
  if table.getn(targets.FriendlyUnits) > 0 then
    targets.closestFriendlyPlayer = targets.FriendlyUnits[1].unit
  end

  -- set lowestEnemyPlayer
  if table.getn(targets.EnemyPlayers) > 0 then
    targets.closestEnemyPlayer = targets.EnemyPlayers[1].unit
  end

  -- set lowestHarmfulTarget
  if table.getn(targets.HarmfulTargets) > 0 then
    for i = 1,#targets.HarmfulTargets do
      local unit = targets.HarmfulTargets[i].unit
      if not ExUnitIsUnit('target', unit) and UnitIsFacing('player',unit) and ExUnitAffectingCombat(unit) then
        targets.closestHarmfulTarget = unit
        return
      end
    end
  end

  table.sort(targets.EnemyPlayers, function(x,y) return x.hp < y.hp end)
	table.sort(targets.HarmfulTargets, function(x,y) return x.hp < y.hp end)
	table.sort(targets.FriendlyUnits, function(x,y) return x.hp < y.hp end)

	-- set lowestFriendlyPlayer
	if table.getn(targets.FriendlyUnits) > 0 then
		targets.lowestFriendlyPlayer = targets.FriendlyUnits[1].unit
	end

	-- set lowestEnemyPlayer
	if table.getn(targets.EnemyPlayers) > 0 then
		targets.lowestEnemyPlayer = targets.EnemyPlayers[1].unit
	end

	-- set lowestHarmfulTarget
	if table.getn(targets.HarmfulTargets) > 0 then
		targets.lowestHarmfulTarget = targets.HarmfulTargets[1].unit
	end
end

-- /script print(UnitsAroundUnit('target',8,true))
function UnitsAroundUnit(object,distance,ignoreCombat)
    if ExUnitExists(object) then
        local units = {}
        local total = 0
        for i = 1,#targets.HarmfulTargets do
            local _unit = targets.HarmfulTargets[i].unit
            local type = ObjectType(_unit) or 0
            if (type == 5 or type == 6) then
               local reaction = ExUnitReaction('player',_unit)
               --print(ExUnitReaction('player',_unit) )
                if ExUnitCanAttack('player',_unit) and reaction and reaction <= 4 and
                    (ignoreCombat or ExUnitAffectingCombat(_unit)) and ExUnitHealth(_unit) > 0 and
                    UnitDistance(_unit,object) <= distance
                then
                    table.insert(units, _unit)
                    total = total + 1
                end
            end
        end
        return total, units
    else
        return 0
    end
end
