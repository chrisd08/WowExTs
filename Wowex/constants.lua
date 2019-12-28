-- Maybe use Persistent from HeroCache?
--[[
WoWEx.Constants = {}
WoWEx.Constants.Player = {}

local PlayerUpdateEvents = {
    ["ACTIVE_TALENT_GROUP_CHANGED"] = true,
    ["PLAYER_LOGIN"] = true,
    ["PLAYER_ENTERING_WORLD"] = true,
    ["PLAYER_PVP_TALENT_UPDATE"] = true,
    ["PLAYER_TALENT_UPDATE"] = true,
}

do
    for _,eventName in pairs(PlayerUpdateEvents) do
        Events:Register(eventName, function(unitID, lineID, spellID)
            WoWEx.Constants.Player.Spec = GetSpecializationInfo('player') or 0
            WoWEx.Constants.Player.Icon = select(4, GetSpecializationInfoByID(WoWEx.Constants.Player.Spec)) or 'None'
            WoWEx.Constants.Player.Role = select(5, GetSpecializationInfoByID(WoWEx.Constants.Player.Spec)) or 'None'
            WoWEx.Constants.Player.Class = select(6, GetSpecializationInfoByID(WoWEx.Constants.Player.Spec)) or 'None'
        end)
    end
end--]]