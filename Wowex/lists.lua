-- This is only a collection of lists we will need atm. They are not in the correct format
-- local PvEPurgeList = {
--     [255579] = { Zone = "Atal'Dazar" },
--     [254974] = { Zone = "Atal'Dazar" },
--     [256849] = { Zone = "Atal'Dazar" },
--     [282098] = { Zone = "Atal'Dazar" },
--
--     [257397] = { Zone = "Freehold" },
--
--     [269935] = { Zone = "King's Rest" },
--     [270920] = { Zone = "King's Rest" },
--     [270901] = { Zone = "King's Rest" },
--
--     [267977] = { Zone = "Shrine of Storms" },
--     [276266] = { Zone = "Shrine of Storms" },
--     [268030] = { Zone = "Shrine of Storms" },
--     [274210] = { Zone = "Shrine of Storms" },
--     [276767] = { Zone = "Shrine of Storms" },
--
--     [256957] = { Zone = "Siege of Boralus" },
--     [275826] = { Zone = "Siege of Boralus" },
--
--     [272659] = { Zone = "Temple of Sethraliss" },
--     [269896] = { Zone = "Temple of Sethraliss" },
--     [265912] = { Zone = "Temple of Sethraliss" },
--
--     [268709] = { Zone = "The Motherlode" },
--     [263215] = { Zone = "The Motherlode" },
--     [262947] = { Zone = "The Motherlode" },
--     [262540] = { Zone = "The Motherlode" },
--
--     [258153] = { Zone = "Tol Dagor" },
--     [258133] = { Zone = "Tol Dagor" },
--     [257827] = { Zone = "Tol Dagor" },
--     [258938] = { Zone = "Tol Dagor" },
--
--     [265091] = { Zone = "Underot" },
--     [266201] = { Zone = "Underot" },
--
--     [278551] = { Zone = "Waycrest Manor" },
--     [265368] = { Zone = "Waycrest Manor" },
--     [264834] = { Zone = "Waycrest Manor" },
-- }

WowEx.Collections.enrageList = {
    228318, -- Enrage
    262092,
    255824,
    254476,
    257739,
    269976,
    137517,
    259975,
    265081,
    266209,
    257260,
}

WowEx.Collections.testing = {
  [269279] = { Time = 5},
}

-- ignore healing
-- 274148
WowEx.Collections.healableNPC = {
  [133392] = true, -- Avatar of Sethraliss

  -- Proving Grounds
  [72218] = true, -- Oto the Protector
  [72221] = true, -- Kavan the Arcanist
  [72220] = true, -- Sooli the Survivalist
  [72219] = true, -- Ki the Assassin
  [72293] = true, -- Speedy!
}

-- At Blackwater Behemoth when we have 292127 we can not heal unless people have 292133
-- At Radiance of Azshara we need to dispel 296746 when they are 10 yards away
-- At The Queens Court 297586 makes people immune against healing
-- At The Queens Court 304409 makes u silenced if u cast the same ability twice in a row
-- At Abyssal Commander Sivara we should not try to heal people with 294715

WowEx.Collections.ignoreHealingBuff = {
  [274148] = true, -- Tainted (Avatar of Sethraliss)

  -- The Eternal Palace
  [297586] = true -- Suffering
}

WowEx.Collections.PvEDispels = {
  -- The Eternal Palace
  [296737] = { Type ="Magic", Time = 15, Count = 0, Radius = 12}, -- Arcane Bomb
  -- Proving Grounds
  [145206] = { Type ="Magic", Time = 5, Count = 0, Radius = 8}, -- Aqua Bomb

  -- Atal'Dazar
  [252781] = { Type ="Curse", Time = 4, Count = 0, Radius = nil}, -- Unstable Hex (Polymorph, spreads on expiry)
  [250096] = { Type ="Curse", Time = 5, Count = 0, Radius = nil}, -- Wracking Pain (Moderate DoT)
  [250371] = { Type ="Disease", Time = 11, Count = 0, Radius = nil}, -- Lingering Nausea (Moderate DoT, Stacks)
  [253562] = { Type ="Magic", Time = 7, Count = 0, Radius = nil}, -- Wildfire (Light DoT)
  [255582] = { Type ="Magic", Time = 29, Count = 0, Radius = nil}, -- Molten Gold (Moderate DoT)
  [255041] = { Type ="Magic", Time = 5, Count = 0, Radius = nil}, -- Terrifying Screech (Fear)
  [255371] = { Type ="Magic", Time = 5, Count = 0, Radius = nil}, -- Terrifying Visage (Fear)
  [252687] = { Type ="Poison", Time = 7, Count = 0, Radius = nil}, -- Venomfang Strike (Doubles nature damage taken)
  -- Kings Rest
  [270492] = { Type ="Curse", Time = 9, Count = 0, Radius = nil}, -- Hex (Polymorph)
  [267763] = { Type ="Disease", Time = 11, Count = 0, Radius = nil}, -- Wretched Discharge (Moderate DoT)
  [276031] = { Type ="Magic", Time = 5, Count = 0, Radius = nil}, -- Pit of Despair (Fear)
  [265773] = { Type ="Magic", Time = 8, Count = 0, Radius = nil}, -- Spit Gold (Heavy DoT, Spawns pool of gold on expiry)
  [270920] = { Type ="Magic", Time = 29, Count = 0, Radius = nil}, -- Seduction (Mind Control)
  [270865] = { Type ="Poison", Time = 7, Count = 0, Radius = nil}, -- Hidden Blade (Spawns poison pool underneath afflicted player every 2s)
  [271564] = { Type ="Poison", Time = 19, Count = 0, Radius = nil}, -- Embalming Fluid (Light DoT, -10% Movement speed, Stacks)
  [270507] = { Type ="Poison", Time = 19, Count = 0, Radius = nil}, -- Poison Barrage (Moderate DoT)
  [267273] = { Type ="Poison", Time = 19, Count = 0, Radius = nil}, -- Poison Nova (Moderate DoT)
  [270499] = { Type ="Magic", Time = 14, Count = 0, Radius = nil}, -- Frost Shock (-50% movement speed)
  -- Motherlode
  [263074] = { Type ="Disease", Time = 9, Count = 0, Radius = nil}, -- Festering Bite (Moderate DoT)
  [280605] = { Type ="Magic", Time = 5, Count = 0, Radius = nil}, -- Brain Freeze (Stun)
  [257337] = { Type ="Magic", Time = 2, Count = 0, Radius = nil}, -- Shocking Claw (Stun)
  [270882] = { Type ="Magic", Time = 14, Count = 0, Radius = nil}, -- Blazing Azerite (=+50% damage taken)
  [268797] = { Type ="Magic", Time = 9, Count = 0, Radius = nil}, -- Transmute: Enemy to Goo (Polymorph)
  [259856] = { Type ="Magic", Time = 9, Count = 0, Radius = nil}, -- Chemical Burn (Moderate DoT)
  [269302] = { Type ="Poison", Time = 5, Count = 0, Radius = nil}, -- Toxic Blades (Minor DoT)
  [262270] = { Type ="Poison", Time = 5, Count = 0, Radius = nil}, -- Caustic Compound (Minor DoT)
  -- Temple of Sethraliss
  [269686] = { Type ="Disease", Time = 9, Count = 0, Radius = nil}, -- Plague (-Minor DoT, -50% Healing done, Stacks)
  [268013] = { Type ="Magic", Time = 14, Count = 0, Radius = nil}, -- Flame Shock (Minor DoT)
  [268008] = { Type ="Magic", Time = 14, Count = 0, Radius = nil}, -- Snake Charm (Polymorph)
  [273563] = { Type ="Poison", Time = 7, Count = 0, Radius = nil}, -- Neurotoxin (Player sleeps for 5s if they move)
  [272657] = { Type ="Poison", Time = 8, Count = 0, Radius = nil}, -- Noxious Breath (Minor DoT)
  [267027] = { Type ="Poison", Time = 5, Count = 0, Radius = nil}, -- Cytotoxin (Moderate DoT)
  [272699] = { Type ="Poison", Time = 8, Count = 0, Radius = nil}, -- Venomous Spit (Moderate DoT)
  -- Underrot
  [265468] = { Type ="Curse", Time = 11, Count = 0, Radius = nil}, -- Withering Curse (-10% damage done, +10% damage taken, Stacks, Channeled)
  [278961] = { Type ="Disease", Time = 29, Count = 0, Radius = nil}, -- Decaying Mind (Stun, Absorbs healing, Removed when absorb removed)
  [259714] = { Type ="Disease", Time = 5, Count = 0, Radius = nil}, -- Decaying Spores (Moderate DoT, Stacks)
  [272180] = { Type ="Magic", Time = 5, Count = 2, Radius = nil}, -- Death Bolt (Moderate DoT, Stacks)
  [272609] = { Type ="Magic", Time = 4, Count = 0, Radius = nil}, -- Maddening Gaze (Fear)
  [269301] = { Type ="Magic", Time = 11, Count = 3, Radius = nil}, -- Putrid Blood (Minor DoT, Stacks quickly)
  -- Freehold
  [258323] = { Type ="Disease", Time = 11, Count = 0, Radius = nil}, -- Infected Wound (-20% healing received)
  [257775] = { Type ="Disease", Time = 17, Count = 0, Radius = nil}, -- Plague Step (Moderate DoT, -25% healing received)
  [257908] = { Type ="Magic", Time = 7, Count = 0, Radius = nil}, -- Oiled Blade (-75% healing received)
  [257436] = { Type ="Poison", Time = 11, Count = 0, Radius = nil}, -- Poisoning Strike (Minor DoT, Stacks)
  -- Shrine of the Storm
  [264560] = { Type ="Magic", Time = 19, Count = 0, Radius = nil}, -- Choking Brine (Minor DoT, turns into swirls when dispelled)
  [268233] = { Type ="Magic", Time = 19, Count = 0, Radius = nil}, -- Electrifying Shock (Heavy DoT)
  [268322] = { Type ="Magic", Time = 11, Count = 0, Radius = nil}, -- Touch of the Drowned (Moderate DoT)
  [268896] = { Type ="Magic", Time = 9, Count = 0, Radius = nil}, -- Mind Rend (Minor DoT, -50% Movement Speed)
  [269104] = { Type ="Magic", Time = 3, Count = 0, Radius = nil}, -- Explosive Void (Stun)
  [267034] = { Type ="Magic", Time = nil, Count = 0, Radius = nil}, -- Whispers of Power (=+20% dmg / healing, can't be healed above X%, Stacks)
  [268315] = { Type ="Magic", Time = 3, Count = 0, Radius = nil}, -- Lash (=+2% Shadow damage taken, Stacks)
  -- Siege of Boralus
  [257168] = { Type ="Curse", Time = 9, Count = 0, Radius = nil}, -- Cursed Slash (=+15% Damage taken)
  [272588] = { Type ="Disease", Time = 14, Count = 0, Radius = nil}, -- Rotting Wounds (-25% Healing received)
  [275014] = { Type ="Magic", Time = 5, Count = 0, Radius = 8}, -- Choking Waters (Moderate DoT, Silence)
  [274991] = { Type ="Magic", Time = 29, Count = 0, Radius = 10}, -- Putrid Waters (Minor DoT, knocks back nearby allies if dispelled)
  [275835] = { Type ="Poison", Time = 9, Count = 0, Radius = nil}, -- Stinging Venom Coating (Moderate DoT, Stacks)
  -- Tol Dagor
  [258128] = { Type ="Magic", Time = 7, Count = 0, Radius = nil}, -- Debilitating Shout (-50% damage dealt)
  [265889] = { Type ="Magic", Time = 15, Count = 0, Radius = nil}, -- Torch Strike (Minor DoT, Stacks)
  [257791] = { Type ="Magic", Time = 5, Count = 0, Radius = nil}, -- Howling Fear (Fear)
  [258864] = { Type ="Magic", Time = 11, Count = 0, Radius = nil}, -- Suppression Fire (Minor DoT)
  [257028] = { Type ="Magic", Time = 4, Count = 0, Radius = nil}, -- Fuselighter (Minor DoT, explodes any barrels held)
  [258917] = { Type ="Magic", Time = 7, Count = 0, Radius = nil}, -- Righteous Flames (Minor DoT, Disorient)
  [257777] = { Type ="Poison", Time = 11, Count = 0, Radius = nil}, -- Crippling Shiv (Minor DoT, -50% movement speed)
  --Waycrest Manor
  [260703] = { Type ="Curse", Time = 5, Count = 0, Radius = nil}, -- Unstable Runic Mark (Minor DoT, 6yd AoE on expiry)
  [263905] = { Type ="Curse", Time = 5, Count = 0, Radius = nil}, -- Marking Cleave (Moderate DoT)
  [265880] = { Type ="Curse", Time = 5, Count = 0, Radius = nil}, -- Dread Mark (Minor DoT, 6rd AoE on expiry)
  [265882] = { Type ="Curse", Time = 4, Count = 0, Radius = nil}, -- Lingering Dread (Minor DoT, follows Dread Mark)
  [264105] = { Type ="Curse", Time = 5, Count = 0, Radius = nil}, -- Runic Mark (Minor DoT, 6yrd AoE on expiry)
  [264050] = { Type ="Disease", Time = 7, Count = 0, Radius = nil}, -- Infected Thorn (Moderate DoT)
  [261440] = { Type ="Disease", Time = 4, Count = 0, Radius = nil}, -- Virulent Pathogen (Moderate DoT, -50% Movement spd, spreads to nearby players on expiry)
  [263891] = { Type ="Magic", Time = 3, Count = 0, Radius = nil}, -- Grasping Thorns (Stun)
  [264378] = { Type ="Magic", Time = 23, Count = 0, Radius = nil}, -- Fragment Soul (Minor DoT, but amplifies Consume Fragments cast so dispel quickly)
}

-- end)

-- Automata.List.BlacklistRaid = {
--     [145053] = true, --Crucible, Eldritch Abomination
-- }
--
-- Automata.List.Class = {
--     [1] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [2] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [3] = { Type = "Ranged", Slow = "Physical", ImmuneSlow = "False" },
--     [4] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [5] = { Type = "Caster", Slow = "Magic", ImmuneSlow = "False" },
--     [6] = { Type = "Melee", Slow = "Magic", ImmuneSlow = "False" },
--     [7] = { Type = "Caster", Slow = "Magic", ImmuneSlow = "False" },
--     [8] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--     [9] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--     [10] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [11] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--     [12] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
-- }
--
-- Automata.List.Spec = {
--     [71] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [72] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [73] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--
--     [65] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [66] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [70] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--
--     [253] = { Type = "Ranged", Slow = "Physical", ImmuneSlow = "False" },
--     [254] = { Type = "Ranged", Slow = "Physical", ImmuneSlow = "False" },
--     [255] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--
--     [259] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [260] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [261] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--
--     [256] = { Type = "Caster", Slow = "Magic", ImmuneSlow = "False" },
--     [257] = { Type = "Caster", Slow = "Magic", ImmuneSlow = "False" },
--     [258] = { Type = "Caster", Slow = "Magic", ImmuneSlow = "False" },
--
--     [250] = { Type = "Melee", Slow = "Magic", ImmuneSlow = "False" },
--     [251] = { Type = "Melee", Slow = "Magic", ImmuneSlow = "False" },
--     [252] = { Type = "Melee", Slow = "Magic", ImmuneSlow = "False" },
--
--     [262] = { Type = "Caster", Slow = "Magic", ImmuneSlow = "False" },
--     [263] = { Type = "Melee", Slow = "Magic", ImmuneSlow = "False" },
--     [264] = { Type = "Caster", Slow = "Magic", ImmuneSlow = "False" },
--
--     [62] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--     [63] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--     [64] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--
--     [265] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--     [266] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--     [267] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--
--     [268] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [269] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [270] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--
--     [102] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--     [103] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [104] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [105] = { Type = "Caster", Slow = "Physical", ImmuneSlow = "False" },
--
--     [577] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
--     [581] = { Type = "Melee", Slow = "Physical", ImmuneSlow = "False" },
-- }
--
-- Automata.List.DispelType = {
--     [62] = {
--         ["Curse"] = true
--     },
--     [63] = {
--         ["Curse"] = true
--     },
--     [64] = {
--         ["Curse"] = true
--     },
--     [65] = {
--         ["Disease"] = true,
--         ["Magic"] = true,
--         ["Poison"] = true,
--     },
--     [66] = {
--         ["Disease"] = true,
--         ["Poison"] = true,
--     },
--     [70] = {
--         ["Disease"] = true,
--         ["Poison"] = true,
--     },
--     [102] = {
--         ["Curse"] = true,
--         ["Poison"] = true,
--     },
--     [103] = {
--         ["Curse"] = true,
--         ["Poison"] = true,
--     },
--     [105] = {
--         ["Curse"] = true,
--         ["Magic"] = true,
--         ["Poison"] = true,
--     },
--     [256] = {
--         ["Disease"] = true,
--         ["Magic"] = true,
--     },
--     [257] = {
--         ["Disease"] = true,
--         ["Magic"] = true,
--     },
--     [258] = {
--         ["Disease"] = true,
--     },
--     [262] = {
--         ["Curse"] = true,
--     },
--     [263] = {
--         ["Curse"] = true,
--     },
--     [264] = {
--         ["Curse"] = true,
--         ["Magic"] = true,
--     },
--     [269] = {
--         ["Disease"] = true,
--         ["Poison"] = true,
--     },
--     [270] = {
--         ["Disease"] = true,
--         ["Magic"] = true,
--         ["Poison"] = true,
--     },
-- }
--
-- Automata.Listener:Add('Automata_Events', 'PLAYER_ENTERING_WORLD', function(...)
--
--     Automata.List.SpellSchool = {
--         Physical = 1,
--         Holy = 2,
--         Fire = 4,
--         Nature = 8,
--         Frost = 16,
--         Shadow = 32,
--     }
--     Automata.List.DefensiveType = {
--         DamageType = {
--             All = {
--                 --DK
--                 Spell(48792), --Icebound Fortitude
--                 Spell(207319), --Corpse Shield
--
--                 --DRUID
--                 Spell(61336), -- Survival Instics
--                 Spell(22817), -- Barksin
--                 Spell(102342), -- Ironbark
--
--                 --HUNTER
--                 Spell(19263), --Deterrence
--                 Spell(53480), --Roar of Sacrifice
--
--                 --MAGE
--                 Spell(45438), --Iceblock
--
--                 --MONK
--                 Spell(120954), --Fortifying Brew
--                 Spell(122278), --Dampem Harm
--                 Spell(116849), --Life Coccon
--                 Spell(122470), --Touch of Karma
--
--                 --MAGIC
--                 Spell(122783), --Diffuse Magic
--
--                 --PALADIN
--                 Spell(1044), --Blessing of Freedom
--                 Spell(642), --Divine Shield
--                 Spell(6940), -- Blessing of Sacrifice
--                 Spell(31850), --Ardent Defender
--                 Spell(184662), --Shield of Vengance
--
--                 --PRIEST
--                 Spell(33206), -- Pain Suppression
--                 Spell(47585), -- Dispersion
--                 Spell(47788), -- Guardian Spirit
--
--
--                 --Rogue
--                 --Physical
--                 Spell(5277), -- Evasion
--
--                 --MAGIC
--                 Spell(31224), -- Cloak of Shadows
--
--
--                 --SHAMAN
--                 Spell(108271), -- Astral Shift
--
--                 --LOCK
--                 Spell(104773), --Unending Resolve
--
--                 --WARRIOR
--                 Spell(871), -- Shield Wall
--
--                 Spell(104773), --Unending Resolve
--                 Spell(871), --Shield Wall
--                 Spell(642), --Divine shield
--                 Spell(4543), --Ice Block
--                 Spell(47788), --Guardian Spirit
--                 Spell(184662), --Shield of Vengance
--             },
--
--             Physical = {
--                 --Paladin
--                 Spell(1022), --Blessing of Protection
--
--                 --Rogue
--                 Spell(5277), -- Evasion
--
--                 --Warrior
--                 Spell(118038), -- Die by the Sword
--             },
--
--             Magic = {
--                 --DK
--                 Spell(48707), -- Anti-Magic Shell
--
--                 --Monk
--                 Spell(122783), --Diffuse Magic
--             },
--         }
--     }
--
-- -- Dispels
-- Automata.List.Dispels = {
--     Spell(145206), --Aqua Bomb
--     Spell(853), --Hammer of Justice
--     Spell(28272), --Pig Poly
--     Spell(118), --Sheep Poly
--     Spell(61305), --Cat Poly
--     Spell(61721), --Rabbit Poly
--     Spell(61780), --Turkey Poly
--     Spell(28271), --Turtle Poly
--     Spell(161355), --Penguin Poly
--     Spell(161354), --Monkey Poly
--     Spell(161353), --Bear Cub Poly
--     Spell(126819), --Pig Poly
--     Spell(161372), --Peacock Poly
--     Spell(82691), --Ring of Frost--Shaman
--     Spell(51514), --Hex
--     Spell(3355), --Freezing Trap
--     Spell(203337), --Freezing Trap
--     Spell(209790), --Freezing Arrow
--     Spell(19386), --Wyvern Sting
--     Spell(145067), --Turn Evil (Evil is a Point of View)--Priest
--     Spell(8122), --Psychic Scream--Warlock
--     Spell(5782), --Fear
--     Spell(118699), --Fear
--     Spell(130616), --Fear (Glyph of Fear)
--     Spell(5484), --Howl of Terror
--     Spell(115268), --Mesmerize (Shivarra)
--     Spell(6358), --Seduction (Succubus)--Warrior
--     Spell(20066), --Repentance
--     Spell(115750), --Priest
--     Spell(605), --Dominate Mind
--     Spell(179057), --chaos nova
--     Spell(122), --Frost Nova
--     Spell(33395), --Freeze (Water Elemental)
--     Spell(64695), --Earthgrab (Earthgrab Totem)
--     Spell(339), -- Entangling Roots,
--     Spell(217832), --imprision
--     Spell(118905), --static charge
--     Spell(20066), --  Repentance
--     Spell(82012), --  Repentance
--     Spell(339), --Roots
-- }
--
-- --- ImmuneMagic
-- -- @table Automata.List.ImmuneMagic
-- Automata.List.MagicImmunity = {
--     Spell(48707), -- AMS
--     Spell(122783), -- Diffuse Magic
--     Spell(31224), -- Cloak of Shadows
-- }
--
-- --- ImmunePhys
-- -- @table Automata.List.ImmunePhys
-- Automata.List.PhysImmunity = {
--     Spell(212800), -- Blur
--     Spell(1022), -- Blessing of Protection
--     Spell(5277), -- Evasion
--     Spell(199754), -- Riposte
--     Spell(210918), -- Ethereal Form
--     Spell(118038), -- Die by Sword
--     --Spell(236696), -- Thorns
-- }
--
-- --- Purge List
-- -- @table Automata.List.purgeList
-- Automata.List.purgeList = {
--     Spell(1022), --BOP
--     Spell(213610), --Holy Ward
--     Spell(204018), --Blessing of spellwarding
--     Spell(29166), --innervate
--     Spell(205025), --POM
--     Spell(1044), --Freedom
--     Spell(198111), ---Temporal Shield
--     Spell(210294), --Divine Favor
--     Spell(212295), --Nteher
-- }
--
-- --- Immunity List
-- Automata.List.PvEImmunity = {
--     Spell(275129), -- Corpulent Mass
--     Spell(263217), -- BloodShield
--     Spell(271965), -- Powered Down
--     Spell(260189), -- Config Drill
-- }

-- Interupts
WowEx.Collections.PvEInterrupt = {
    [123456] = { useKick = true, useStun = false, useCC = true, Percent = nil }, -- Example
    [260162] = { useKick = true, useStun = false, useCC = true, Percent = nil }, -- Example

    --------------------
    -- Brawlers Guild --
    --------------------
    [140983] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [281949] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [142621] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [33975]  = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [132666] = { useKick = false, useStun = false, useCC = true, Percent = nil },
    [282081] = { useKick = true, useStun = false, useCC = true, Percent = nil },
    ----------------
    -- Dazar'alor --
    ----------------
    [287419] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [283628] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [284578] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [282243] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [286379] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [287887] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [289861] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    -----------
    -- Uldir --
    -----------
    [268198] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [267180] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [273350] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [267427] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [263307] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    ----------------
    -- Atal'Dazar --
    ----------------
    [256849] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [253517] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [253548] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [253583] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [255041] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [256849] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [252781] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [250368] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [250096] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    ------------------
    -- The Underrot --
    ------------------
    [265089] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [265091] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [278755] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [260879] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [266106] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [278961] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [266201] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [272183] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [272180] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [265433] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [265523] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    --------------------
    -- Waycrest Manor --
    --------------------
    [267824] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [265371] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [263891] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [266035] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [266036] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [260805] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [278551] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [278474] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [263943] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [264520] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [278444] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [265407] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [265876] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [264105] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [278551] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [264384] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [263959] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268278] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [266225] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    -----------------
    -- Kings' Rest --
    -----------------
    [269972] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [270923] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [270901] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [267763] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [270492] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [267273] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    --------------
    -- Freehold --
    --------------
    [257397] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [258777] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [257732] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [257736] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [256060] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [257397] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [258777] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [257732] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [257736] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    --------------
    -- TolDagor --
    --------------
    [258128] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [258153] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [257791] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [258313] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [258869] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [258634] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [258935] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    ----------------------
    -- Siege of Boralus --
    ----------------------
    [256957] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [274569] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    --------------------------
    -- Temple of Selthralis --
    --------------------------
    [265968] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [261635] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [261624] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [265912] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [272820] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268061] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    ----------------
    -- Motherlode --
    ----------------
    [267433] = { useKick = false, useStun = false, useCC = true, Percent = nil },
    [280604] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268185] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268129] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [269302] = { useKick = true, useStun = false, useCC = true, Percent = nil },
    [267354] = { useKick = false, useStun = false, useCC = true, Percent = nil },
    [268709] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268702] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [263215] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [263066] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [263103] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268797] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [269090] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [262554] = { useKick = false, useStun = false, useCC = true, Percent = nil },
    -------------------------
    -- Shrine of the Storm --
    -------------------------
    [267977] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [267969] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268030] = { useKick = true, useStun = false, useCC = true, Percent = nil },
    [274438] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268309] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268322] = { useKick = true, useStun = false, useCC = true, Percent = nil },
    [268317] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [268375] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [267809] = { useKick = true, useStun = false, useCC = false, Percent = nil },
    [267818] = { useKick = true, useStun = false, useCC = false, Percent = nil },
}

WowEx.Collections.LineOfSightExceptions = {
    [44566] = true,
    [46753] = true,
    [56754] = true,
    [61463] = true,
    [72156] = true,
    [76267] = true,
    [76379] = true,
    [76585] = true,
    [76973] = true,
    [76974] = true,
    [77182] = true,
    [91331] = true,
    [91005] = true,
    [91808] = true,
    [96028] = true,
    [97259] = true,
    [97260] = true,
    [96759] = true,
    [98363] = true,
    [98696] = true,
    [99801] = true,
    [100354] = true,
    [100360] = true,
    [120436] = true,
    [118460] = true,
    [116939] = true,
    [119072] = true,
    [119397] = true,
    [119072] = true,
    [118460] = true,
    [118462] = true,
    [120368] = true,
    [122450] = true,
    [124167] = true,
    [123371] = true,
    [128154] = true,
    [128429] = true,
    [125050] = true,
    [122578] = true,
    [127231] = true,
    [127230] = true,
    [127235] = true,
    [122773] = true,
    [122778] = true,
    [128429] = true,
    [114537] = true,
    [105906] = true,
    [100362] = true,
    [98363] = true,
    [96759] = true,
    [91808] = true,
    [91005] = true,
    [131863] = true, -- BIG BOY MANOR
    [137625] = true,
    [137405] = true,
    [137626] = true,
    [137614] = true,
    [137627] = true,
    [137119] = true,
    [138959] = true,
    [138530] = true,
    [140447] = true, -- HENTA
    [143648] = true,
    [140393] = true, -- Tendril's Gore
    [146256] = true, -- Laminaria
    [147376] = true, -- Barrier
    [148890] = true, -- Wall of Ice
    [149907] = true, -- Wall of Ice
    [133392] = true,
    [131199] = true, -- Pridze
}

-- Azerite Traits
WowEx.Collections.azeriteTraits = {
  ["AzeriteEmpowered"] = 13,
  ["Longstrider"] = 14,
  ["ResoundingProtection"] = 15,
  ["BloodSiphon"] = 18,
  ["Woundbinder"] = 19,
  ["Lifespeed"] = 20,
  ["ElementalWhirl"] = 21,
  ["HeedMyCall"] = 22,
  ["OverwhelmingPower"] = 30,
  ["Gutripper"] = 31,
  ["InTheRhythm"] = 36,
  ["OnMyWay"] = 38,
  ["Savior"] = 42,
  ["WindsofWar"] = 43,
  ["VampiricSpeed"] = 44,
  ["SecretInfusion"] = 76,
  ["ChampionofAzeroth"] = 82,
  ["ImpassiveVisage"] = 83,
  ["BulwarkoftheMasses"] = 84,
  ["Gemhide"] = 85,
  ["AzeriteFortification"] = 86,
  ["SelfReliance"] = 87,
  ["ArcanePummeling"] = 88,
  ["AzeriteVeins"] = 89,
  ["CrystallineCarapace"] = 98,
  ["AblativeShielding"] = 99,
  ["StrengthinNumbers"] = 100,
  ["ShimmeringHaven"] = 101,
  ["SynergisticGrowth"] = 102,
  ["ConcentratedMending"] = 103,
  ["BracingChill"] = 104,
  ["EphemeralRecovery"] = 105,
  ["DeepCuts"] = 106,
  ["SerratedJaws"] = 107,
  ["IcyCitadel"] = 108,
  ["MagusoftheDead"] = 109,
  ["WildfireCluster"] = 110,
  ["BloodMist"] = 111,
  ["LayeredMane"] = 112,
  ["MomentofRepose"] = 113,
  ["PermeatingGlow"] = 114,
  ["SearingDialogue"] = 115,
  ["BoilingBrew"] = 116,
  ["FuryofXuen"] = 117,
  ["DeafeningCrash"] = 118,
  ["UnbridledFerocity"] = 119,
  ["EarlyHarvest"] = 120,
  ["StrikingtheAnvil"] = 121,
  ["StreakingStars"] = 122,
  ["WrackingBrilliance"] = 123,
  ["ReplicatingShadows"] = 124,
  ["AvengersMight"] = 125,
  ["RevolvingBlades"] = 126,
  ["Equipoise"] = 127,
  ["FlamesofAlacrity"] = 128,
  ["Deadshot"] = 129,
  ["ShadowsBite"] = 130,
  ["ChaosShards"] = 131,
  ["PackedIce"] = 132,
  ["BulwarkofLight"] = 133,
  ["RevelinPain"] = 134,
  ["DoubleDose"] = 136,
  ["PrimalPrimer"] = 137,
  ["SoothingWaters"] = 138,
  ["GlimmerofLight"] = 139,
  ["BoneSpikeGraveyard"] = 140,
  ["LatentChill"] = 141,
  ["Helchains"] = 142,
  ["InspiringBeacon"] = 143,
  ["RejuvenatingGrace"] = 144,
  ["FortifyingAuras"] = 145,
  ["RighteousFlames"] = 148,
  ["HealingHammer"] = 149,
  ["SoaringShield"] = 150,
  ["RelentlessInquisitor"] = 154,
  ["RuinousBolt"] = 156,
  ["RezansFury"] = 157,
  ["FuriousGaze"] = 159,
  ["InfernalArmor"] = 160,
  ["HazeofRage"] = 161,
  ["SurgingShots"] = 162,
  ["LatentPoison"] = 163,
  ["WealandWoe"] = 164,
  ["BlessedSanctuary"] = 165,
  ["ThoughtHarvester"] = 166,
  ["BrainStorm"] = 167,
  ["Wildfire"] = 168,
  ["UntamedFerocity"] = 169,
  ["FlashFreeze"] = 170,
  ["MasterfulInstincts"] = 171,
  ["GroveTending"] = 172,
  ["PoweroftheMoon"] = 173,
  ["GatheringStorm"] = 174,
  ["NightsVengeance"] = 175,
  ["ColdSteel,HotBlood"] = 176,
  ["Bloodsport"] = 177,
  ["LavaShock"] = 178,
  ["StrengthofEarth"] = 179,
  ["KeepYourWitsAboutYou"] = 180,
  ["TwisttheKnife"] = 181,
  ["InevitableDemise"] = 183,
  ["SunriseTechnique"] = 184,
  ["OverflowingMists"] = 185,
  ["StaggeringStrikes"] = 186,
  ["Expurgation"] = 187,
  ["MomentofCompassion"] = 188,
  ["RighteousConviction"] = 189,
  ["UmbralBlaze"] = 190,
  ["TurnoftheTide"] = 191,
  ["MeticulousScheming"] = 192,
  ["BlightborneInfusion"] = 193,
  ["FilthyTransfusion"] = 194,
  ["SecretsoftheDeep"] = 195,
  ["SwirlingSands"] = 196,
  ["Marrowblood"] = 197,
  ["FrostwhelpsIndignation"] = 198,
  ["Festermight"] = 199,
  ["ArcanicPulsar"] = 200,
  ["RunicBarrier"] = 201,
  ["Soulmonger"] = 202,
  ["Shellshock"] = 203,
  ["Sanctum"] = 204,
  ["EldritchWarding"] = 205,
  ["StalwartProtector"] = 206,
  ["SereneSpirit"] = 207,
  ["Lifeblood"] = 208,
  ["JungleFury"] = 209,
  ["AutumnLeaves"] = 210,
  ["DanceofDeath"] = 211,
  ["UnerringVision"] = 212,
  ["VenomousFangs"] = 213,
  ["ArcanePressure"] = 214,
  ["BlasterMaster"] = 215,
  ["Footpad"] = 217,
  ["StrengthofSpirit"] = 218,
  ["Reawakening"] = 219,
  ["ChaoticTransformation"] = 220,
  ["RigidCarapace"] = 221,
  ["EchooftheElementals"] = 222,
  ["LightningConduit"] = 223,
  ["SwellingStream"] = 224,
  ["GlacialAssault"] = 225,
  ["TestofMight"] = 226,
  ["DepthoftheShadows"] = 227,
  ["PrayerfulLitany"] = 228,
  ["PulverizingBlows"] = 229,
  ["CascadingCalamity"] = 230,
  ["ExplosivePotential"] = 231,
  ["Flashpoint"] = 232,
  ["DivineRevelations"] = 233,
  ["InnerLight"] = 234,
  ["IndomitableJustice"] = 235,
  ["WhispersoftheDamned"] = 236,
  ["BastionofMight"] = 237,
  ["FittoBurst"] = 238,
  ["SnakeEyes"] = 239,
  ["BladeInTheShadows"] = 240,
  ["TwistedClaws"] = 241,
  ["EchoingHowl"] = 242,
  ["BloodyRuneblade"] = 243,
  ["HarrowingDecay"] = 244,
  ["SeethingPower"] = 245,
  ["HourofReaping"] = 246,
  ["IronJaws"] = 247,
  ["MistyPeaks"] = 248,
  ["NothingPersonal"] = 249,
  ["DawningSun"] = 250,
  ["BurstofSavagery"] = 251,
  ["KillerFrost"] = 346,
  ["FrozenTempest"] = 347,
  ["EternalRuneWeapon"] = 348,
  ["BonesoftheDamned"] = 349,
  ["CankerousWounds"] = 350,
  ["LastSurprise"] = 351,
  ["ThirstingBlades"] = 352,
  ["EyesofRage"] = 353,
  ["CycleofBinding"] = 354,
  ["EssenceSever"] = 355,
  ["HighNoon"] = 356,
  ["LunarShrapnel"] = 357,
  ["GushingLacerations"] = 358,
  ["WildFleshrending"] = 359,
  ["GoryRegeneration"] = 360,
  ["GuardiansWrath"] = 361,
  ["RampantGrowth"] = 362,
  ["WakingDream"] = 363,
  ["LivelySpirit"] = 364,
  ["DireConsequences"] = 365,
  ["PrimalInstincts"] = 366,
  ["FeedingFrenzy"] = 367,
  ["SteadyAim"] = 368,
  ["RapidReload"] = 369,
  ["FocusedFire"] = 370,
  ["BlurofTalons"] = 371,
  ["WildernessSurvival"] = 372,
  ["PrimevalIntuition"] = 373,
  ["GalvanizingSpark"] = 374,
  ["ExplosiveEcho"] = 375,
  ["TrailingEmbers"] = 376,
  ["DuplicativeIncineration"] = 377,
  ["Firemind"] = 378,
  ["TunnelofIce"] = 379,
  ["Whiteout"] = 380,
  ["FrigidGrasp"] = 381,
  ["StraightNoChaser"] = 382,
  ["TrainingofNiuzao"] = 383,
  ["ElusiveFootwork"] = 384,
  ["BurstofLife"] = 385,
  ["FontofLife"] = 386,
  ["UpliftedSpirits"] = 387,
  ["GloryoftheDawn"] = 388,
  ["OpenPalmStrikes"] = 389,
  ["PressurePoint"] = 390,
  ["DanceofChi-Ji"] = 391,
  ["GraceoftheJusticar"] = 393,
  ["BreakingDawn"] = 394,
  ["InspiringVanguard"] = 395,
  ["LightsDecree"] = 396,
  ["SuddenRevelation"] = 397,
  ["ContemptuousHomily"] = 398,
  ["EnduringLuminescence"] = 399,
  ["EverlastingLight"] = 400,
  ["WordofMending"] = 401,
  ["PromiseofDeliverance"] = 402,
  ["SpitefulApparitions"] = 403,
  ["DeathThroes"] = 404,
  ["ChorusofInsanity"] = 405,
  ["ScentofBlood"] = 406,
  ["EchoingBlades"] = 407,
  ["ShroudedSuffocation"] = 408,
  ["ParadiseLost"] = 410,
  ["AceUpYourSleeve"] = 411,
  ["TheFirstDance"] = 413,
  ["Inevitability"] = 414,
  ["NaturalHarmony"] = 416,
  ["TectonicThunder"] = 417,
  ["RoilingStorm"] = 420,
  ["SurgingTides"] = 422,
  ["SpoutingSpirits"] = 423,
  ["SuddenOnset"] = 425,
  ["DreadfulCalling"] = 426,
  ["DemonicMeteor"] = 428,
  ["BalefulInvocation"] = 429,
  ["RollingHavoc"] = 431,
  ["ChaoticInferno"] = 432,
  ["SeismicWave"] = 433,
  ["CrushingAssault"] = 434,
  ["LordofWar"] = 435,
  ["SimmeringRage"] = 437,
  ["RecklessFlurry"] = 438,
  ["CallousReprisal"] = 440,
  ["IronFortress"] = 441,
  ["PandemicInvocation"] = 442,
  ["CrashingChaos"] = 444,
  ["Perforate"] = 445,
  ["BrigandsBlitz"] = 446,
  ["AncestralResonance"] = 447,
  ["SynapseShock"] = 448,
  ["OverflowingShores"] = 449,
  ["BraceforImpact"] = 450,
  ["InfiniteFury"] = 451,
  ["RadiantIncandescence"] = 452,
  ["EmpyreanPower"] = 453,
  ["JudiciousDefense"] = 454,
  ["IgneousPotential"] = 457,
  ["SupremeCommander"] = 458,
  ["UnstableFlames"] = 459,
  ["BurstingFlare"] = 460,
  ["Earthlink"] = 461,
  ["AzeriteGlobules"] = 462,
  ["BlessedPortents"] = 463,
  ["MarchoftheDamned"] = 465,
  ["BurningSoul"] = 466,
  ["UrsocsEndurance"] = 467,
  ["CauterizingBlink"] = 468,
  ["DuckandCover"] = 469,
  ["SweeptheLeg"] = 470,
  ["GallantSteed"] = 471,
  ["TwistMagic"] = 472,
  ["ShroudedMantle"] = 473,
  ["PackSpirit"] = 474,
  ["DesperatePower"] = 475,
  ["MomentofGlory"] = 476,
  ["BurytheHatchet"] = 477,
  ["TidalSurge"] = 478,
  ["DaggerintheBack"] = 479,
  ["BloodRite"] = 480,
  ["IncitethePack"] = 481,
  ["ThunderousBlast"] = 482,
  ["ArchiveoftheTitans"] = 483,
  ["LaserMatrix"] = 485,
  ["GloryinBattle"] = 486,
  ["RetaliatoryFury"] = 487,
  ["BattlefieldFocus"] = 488,
  ["SylvanasResolve"] = 489,
  ["CombinedMight"] = 490,
  ["CollectiveWill"] = 491,
  ["LiberatorsMight"] = 492,
  ["LastGift"] = 493,
  ["BattlefieldPrecision"] = 494,
  ["AnduinsDedication"] = 495,
  ["StrongerTogether"] = 496,
  ["StandAsOne"] = 497,
  ["BarrageOfManyBombs"] = 498,
  ["RicochetingInflatablePyrosaw"] = 499,
  ["SynapticSparkCapacitor"] = 500,
  ["RelationalNormalizationGizmo"] = 501,
  ["AutoSelfCauterizer"] = 503,
  ["UnstableCatalyst"] = 504,
  ["Tradewinds"] = 505,
  ["ReplicatingShadows"] = 506,
  ["EmpyreanPower"] = 507,
  ["LightsDecree"] = 508,
  ["NothingPersonal"] = 509,
  ["Helchains"] = 511,
  ["TectonicThunder"] = 512,
  ["Straight,NoChaser"] = 513,
  ["Equipoise"] = 514,
  ["BalefulInvocation"] = 515,
  ["DanceofChiJi"] = 516,
  ["FuryofXuen"] = 517,
  ["DireConsequences"] = 518,
  ["FrostwhelpsIndignation"] = 519,
  ["BastionofMight"] = 520,
  ["ShadowofElune"] = 521,
  ["AncientsBulwark"] = 522,
  ["ApothecarysConcoctions"] = 523,
  ["EchoingBlades"] = 524,
  ["ChaosShards"] = 525,
  ["EndlessHunger"] = 526,
  ["RighteousConviction"] = 527,
  ["SurgingShots"] = 528,
  ["ArcanicPulsar"] = 529,
  ["ThunderaansFury"] = 530,
  ["TerroroftheMind"] = 531,
  ["EarlyHarvest"] = 532,
  ["GlimmerofLight"] = 533,
  ["PromiseofDeliverance"] = 534,
  ["SuddenRevelation"] = 535,
  ["SecretInfusion"] = 536,
  ["DeathDenied"] = 537,
  ["EmpyrealWard"] = 538,
  ["AncientAnkhTalisman"] = 539,
  ["SwitchHitter"] = 540,
  ["FightorFlight"] = 541,
  ["NaturesSalve"] = 543,
  ["UnbridledFerocity"] = 544,
  ["ColdSteelHotBlood"] = 545,
  ["QuickThinking"] = 546,
  ["FlashFreeze"] = 547,
  ["LyingInWait"] = 548,
  ["ColdHearted"] = 549,
  ["StrikingtheAnvil"] = 550,
  ["PrimevalIntuition"] = 551,
  ["MagusoftheDead"] = 552,
  ["IntimidatingPresence"] = 554,
  ["ChaoticTransformation"] = 555,
  ["Wildfire"] = 556,
  ["BloodyRuneblade"] = 557,
  ["HourofReaping"] = 558,
  ["BondedSouls"] = 560,
  ["SeductivePower"] = 561,
  ["TreacherousCovenant"] = 562,
  ["ThriveinChaos"] = 564,
  ["ExitStrategy"] = 566,
}

WowEx.Collections.Offsets = {
    ['BoundingRadius'] = 0x15DC,
    ['CombatReach'] = 0x15E0, --BoundingRadius + 4
    ['CastingTarget'] = 0x4f8,
    ['SpecID'] = 0x1AE4,
    ['SummonedBy'] = 0x1510,
    ['CreatedBy'] = 0x1520, --SummonedBy + 10
    ['Target'] = 0x1550,
    ['Rotation'] = 0x160,
}

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
