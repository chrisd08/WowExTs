local LibCC = LibStub("LibClassicCasterino", true)

CastingInfo = function(unit)
  return LibCC:UnitCastingInfo(unit)
end
ChannelInfo = function(unit)
  return LibCC:UnitChannelInfo(unit)
end
