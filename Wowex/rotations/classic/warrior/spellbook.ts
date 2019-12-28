const _battleShout = [25289, 11551, 11550, 11549, 6192, 5242, 6673];
const _heroicStrike = [25286, 11567, 11566, 11565, 11564, 1608, 285, 284, 78];
const _cleave = [20569, 11609, 11608, 7369, 845];
const _rend = [11574, 11573, 11572, 6548, 6547, 6546, 772];
const _sunderArmor = [11597, 11596, 8380, 7405, 7386];
const _demoShout = [11556, 11555, 11554, 6190, 1160];
const _overpower = [11585, 11584, 7887, 7384];
const _execute = [20662, 20661, 20660, 20658, 5308];
const _mortalStrike = [21553, 21552, 21551, 12294];
const _whirlwind = [1680];
const _hamstring = [7373, 7372, 1715];
const _sweepingStrikes = [12292];

const warriorSpells = {
  BattleShout: getBest(_battleShout),
  HeroicStrike: getBest(_heroicStrike),
  Cleave: getBest(_cleave),
  Rend: getBest(_rend),
  SunderArmor: getBest(_sunderArmor),
  DemoShout: getBest(_demoShout),
  Overpower: getBest(_overpower),
  Execute: getBest(_execute),
  MortalStrike: getBest(_mortalStrike),
  Whirlwind: getBest(_whirlwind),
  Hamstring: getBest(_hamstring),
  SweepingStrikes: getBest(_sweepingStrikes),
};

interface Spellbook {
  Warrior: { [K in keyof typeof warriorSpells]: number };
}
WowEx.Spellbook.Warrior = warriorSpells;