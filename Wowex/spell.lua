SpellEx = {};
SpellEx.__index = SpellEx;
function SpellEx:Create(spellNameOrId)
   local self = {};
   setmetatable(self, Spell);
   self.info = GetSpellInfo(spellNameOrId);
   local sname, srank, sicon, scastingTime, sminRange, smaxRange, sspellID = self.info
   self.name = sname
   self.rank = srank;
   self.icon = sicon;
   self.castingTime = scastingTime;
   self.minRange = sminRange;
   self.maxRange = smaxRange;
   self.spellID = sspellID;
   return self;
end

function SpellEx:Name()
   return self.name
end

function SpellEx:Icon()
   return self.icon
end

function SpellEx:CastTime()
   return self.castingTime
end

function SpellEx:MinimumRange()
   return self.minRange
end

function SpellEx:MaximumRange()
   return self.maxRangeYes
end

function SpellEx:ID()
   return self.spellID
end

local fb = SpellEx:Create(116)
-- print(fb:Name())

local spellcache = setmetatable({}, {__index=function(t,v) local a = {GetSpellInfo(v)} if GetSpellInfo(v) then t[v] = a end return a end})

function GetSpellInfoEx(spell)
   return unpack(spellcache[spell])
end
