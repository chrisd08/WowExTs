local specError = false;
local initialized = false
local loaded = false
local Cache = HeroCache
WowExFrame = _G['WowExFrame']
WowEx = {}
WowEx.Rotations = {}
WowEx.Spellbook = {}
WowEx.Constants = {}
WowEx.Collections = {}
WowEx.Collections.Interrupts = {}
WowEx.Collections.InterruptsCC = {}
if WowExFrame == nil then
	WowExFrame = CreateFrame('frame', 'WowExFrame', UIParent)
end

WowEx.Constants.isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)

WowExFrame:SetScript('OnUpdate', function(self, elapsed)
    local throttle = 0.1
    self.st = elapsed + (self.st or 0)
    if initialized == false then
        print("|cffFF0000[|cffffff00WowEx Loaded|cffFF0000]")
        CoreEnabled = false
        initialized = true
    end
    if self.st > throttle then
        if WowExLoaded() then

            if loaded == false then
                HookFunctions()
                loaded = true
			end

			local currentSpec
			local id, currentSpecName
			if isClassic == 1 then
				currentSpec = GetSpecialization()
				id = GetSpecializationInfo(currentSpec)
			else
				id = select(3, UnitClass('player'))
			end
            if WowEx.Rotations[id] and CoreEnabled then
                local rotation = WowEx.Rotations[id]
				Cache.HasBeenReset = false
				Cache.Reset()
                if rotation:CombatNeeded()  then
                    rotation:ExecuteCombat();
                elseif rotation:RestNeeded()  then
                    rotation:ExecuteRest();
                elseif rotation:PrepareNeeded()  then
                    rotation:ExecutePrepare();
                elseif CoreEnabled == false and WowEx.Rotations[id] then
                    return
                end
            else
                if specError == false and CoreEnabled then
                    specError = true
                    print("|cffFF0000[|cffffff00No Profile found for spec "..id.."|cffFF0000]")
                end
            end
        end
        self.st = 0
    end
end)

function WowExLoaded()
    return GetObjectWithIndex ~= nil
end

function WowEx.CoreToggle()
	if CoreEnabled == nil then
		CoreEnabled = true
		print('[WowEx] Core enabled.')
	elseif CoreEnabled ~= nil and CoreEnabled == true then
		CoreEnabled = false
		print('[WowEx] Core was disabled.')
	elseif CoreEnabled ~= nil and CoreEnabled == false then
		CoreEnabled = true
		print('[WowEx] Core was enabled')
	end
end

function WowEx.InterruptsToggle()
	if InterruptsEnabled == nil then
		InterruptsEnabled = true
		print('[WowEx] Interrupts enabled.')
	elseif InterruptsEnabled ~= nil and InterruptsEnabled == true then
		InterruptsEnabled = false
		print('[WowEx] Interrupts disabled.')
	elseif InterruptsEnabled ~= nil and InterruptsEnabled == false then
		InterruptsEnabled = true
		print('[WowEx] Interrupts enabled')
	end
end

function WowEx.CooldownsToggle()
	if CooldownsEnabled == nil then
		CooldownsEnabled = true
		print('[WowEx] Cooldowns enabled.')
	elseif CooldownsEnabled ~= nil and CooldownsEnabled == true then
		CooldownsEnabled = false
		print('[WowEx] Cooldowns disabled.')
	elseif CooldownsEnabled ~= nil and CooldownsEnabled == false then
		CooldownsEnabled = true
		print('[WowEx] Cooldowns enabled.')
	end
end


function WowEx.AoEToggle()
	if AoEEnabled == nil then
		AoEEnabled = true
		print('[WowEx] AoE enabled.')
	elseif AoEEnabled ~= nil and AoEEnabled == true then
		AoEEnabled = false
		print('[WowEx] AoE disabled.')
	elseif AoEEnabled ~= nil and AoEEnabled == false then
		AoEEnabled = true
		print('[WowEx] AoE enabled.')
	end
end
