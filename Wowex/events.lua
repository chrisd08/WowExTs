EventFrame = CreateFrame('Frame')
Events = {
    callbacks = { }
}

function Events:Register(event, callback)
    if not self.callbacks[event] then
        self.callbacks[event] = { }
        EventFrame:RegisterEvent(event)
    end
    self.callbacks[event][tostring(callback)] = callback
end

function Events:Unregister(event, callback)
    if not self.callbacks[event] or not self.callbacks[event][tostring(callback)] then return end
    self.callbacks[event][tostring(callback)] = nil
end

function Events:Handle(e, ...)
    if self.callbacks[e] then
        for _, callback in pairs(self.callbacks[e]) do
            callback(...)
        end
    end
end

EventFrame:SetScript("OnEvent", function(self, e, ...)
    Events:Handle(e, ...)
end)

Events:Register('UNIT_SPELLCAST_SUCCEEDED', function(unitID, lineID, spellID)
    if (unitID == 'player' or unitID == 'pet') and spellID and spellID ~= 1966 then
        LocalPlayer.LastCastSucceeded = spellID or 0
    end
end)

Events:Register('START_AUTOREPEAT_SPELL', function()
        LocalPlayer.WandOrShooting = true
        print('Started shooting')
end)

Events:Register('STOP_AUTOREPEAT_SPELL', function()
    LocalPlayer.WandOrShooting = false
    print('Stopped shooting')
end)
