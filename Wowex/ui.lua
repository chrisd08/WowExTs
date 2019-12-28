local StdUi = LibStub('StdUi')

local stringVersion = WowEx.Constants.isClassic and 'Classic' or 'BfA'
local window = StdUi:Window(UIParent, 'WowNet' .. stringVersion, 400, 200);
window:SetPoint('LEFT',200, 0);

local t = {
   {
      name = 'generalTab',
      title = 'General',
   },
   {
      name = 'questTab',
      title = 'Quests',
   },
   {
      name = 'gatherTab',
      title = 'Gathering'
   },
   {
    name = 'debugTab',
    title = 'Debug'
    }
}

local tabFrame = StdUi:TabPanel(window, nil, nil, t);
StdUi:GlueAcross(tabFrame, window, 10, -50, -10, 20);

tabFrame:EnumerateTabs(function(tab)
     if tab.name == 'generalTab' then
        local core = StdUi:Checkbox(tab.frame, 'Core Enabled');
        StdUi:GlueTop(core, tab.frame, 10, -20, 'LEFT');
        function core:OnValueChanged(value, arg2)
            CoreEnabled = value
            if CoreEnabled then
                print('Core was enabled.')
            else
                print('Core was disabled.')
            end
        end
     end

     if tab.name == 'questTab' then
        questCheck = StdUi:Checkbox(tab.frame, 'Questing Enabled');
        StdUi:GlueTop(questCheck, tab.frame, 10, -20, 'LEFT');
        function questCheck:OnValueChanged(value, arg2)
            Settings.QuestingEnabled = value
            if Settings.GatheringEnabled then
                Settings.QuestingEnabled = false
                gatherCheck:SetChecked(false)
                print('Questing was enabled.')
            else
                print('Questing was disabled.')
            end
        end
     end

     if tab.name == 'gatherTab' then

     end
     if tab.name == 'debugTab' then

     end
end);
