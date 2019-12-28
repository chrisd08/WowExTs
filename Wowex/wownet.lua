function executeOneArg(func,unit)
	if not IsGuid then
		return _G[func](unit)
	end
	if IsGuid(unit) then
		return _G[func](SetMouseOver(unit))
	else
		return _G[func](unit)
	end
end
function executeTwoArg(func,Object,otherObject)

	if not IsGuid then
		return _G[func](Object,otherObject)
	end
	local objectGuid = IsGuid(Object)
	local otherObjectGuid = IsGuid(otherObject)
	if objectGuid and otherObjectGuid then
		local ret = _G[func](SetMouseOver(Object),SetFocusTarget(otherObject))
		ExClearFocus()
		return ret
	elseif objectGuid and not otherObjectGuid then
		return  _G[func](SetMouseOver(Object),otherObject)
	elseif not objectGuid and otherObjectGuid then
		return  _G[func](Object,SetMouseOver(otherObject))
	else
		return _G[func](Object,otherObject)
	end
end

function reroute(...)
	local func = select(1,...)
	local arg1 = select(2,...)
	local arg2 = select(3,...)
	if not arg2 then
		return executeOneArg(func,arg1)
	else
		return executeTwoArg(func,arg1,arg2)
	end
end
local functionsToHook = {'UnitIsVisible','UnitIsDeadOrGhost','UnitThreatSituation','UnitGUID','UnitIsUnit','UnitHealthMax','UnitAffectingCombat',
'UnitReaction','UnitIsPlayer','UnitIsDead','UnitInParty','UnitInRaid','UnitHealth','UnitCastingInfo','UnitChannelInfo',
'UnitName','UnitCreatureType','UnitCanAttack','UnitClassification','UnitAura','IsSpellInRange','UnitIsVisible','UnitBuff',
'UnitDebuff','UnitExists','UnitClass','UnitPowerType','UnitPower','UnitPowerMax','UnitIsEnemy','UnitGroupRolesAssigned',
'UnitIsCharmed','UnitIsConnected','UnitIsUnit'}
function HookFunctions()
	for k,v in pairs(_G) do
		if type( v ) == "function" then
			for _,name in pairs(functionsToHook) do
				if k == name then
					print("|cff00FF7F[Hooked:|cffffff00", k..'|cff00FF7F]')
					if _G["orig"..k] == nil then  _G["orig"..k] = _G[k] end
					_G["Ex"..k] = function(...)
						return reroute('orig'..k,...)
					end
				end
			end
		end
	end
end

WowObjectType = {
    Object,
    Item,
    Container,
    AzeriteEmpoweredItem,
    AzeriteItem,
    Unit,
    Player,
    ActivePlayer,
    Game,
    Dynamic,
    Corpse,
    Areatrigger,
    Scene,
    Conversation,
    AiGroup,
    Scenario,
    Loot,
    Invalid
}
