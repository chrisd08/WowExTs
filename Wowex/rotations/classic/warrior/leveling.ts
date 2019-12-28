const SB = WowEx.Spellbook.Warrior;

print(
  "- https://www.icy-veins.com/wow-classic/classic-warrior-leveling-guide -"
);
print("- Use the link above for talent guide.");

class WarriorLevelingRotation implements Rotation {
  private name: string = "Warrior Leveling";

  private battleStance(): void {
    const rage = UnitPower("player");

    if (SB.Hamstring && AuraRemains("player", SB.Hamstring) <= 3) {
      TryCast(SB.Hamstring, "target");
    }

    if (SB.SweepingStrikes && UnitsAroundUnit("player", 8)) {
      TryCast(SB.SweepingStrikes, "target");
    }

    if (SB.Overpower) {
      TryCast(SB.Overpower, "target");
    }

    if (SB.Execute && UnitHealthPercent("target") <= 20) {
      TryCast(SB.Execute, "target");
    }

    if (SB.MortalStrike) {
      TryCast(SB.MortalStrike, "target");
    }

    if (SB.Rend && AuraRemains("target", SB.Rend) <= 3) {
      TryCast(SB.Rend, "target");
    }

    if (SB.SunderArmor) {
      TryCast(SB.SunderArmor, "target");
    }

    if (SB.HeroicStrike && UnitsAroundUnit("player", 8)[0] > 1 && rage >= 60) {
      TryCast(SB.HeroicStrike, "target");
    } else if (SB.Cleave && rage >= 60) {
      TryCast(SB.Cleave, "target");
    }
  }

  private defensiveStance(): void {
    print("We're leveling. Use battlestance for DPS");
    TryCast(2457, "player");
  }

  private berserkerStance(): void {
    print("We're leveling. Use battlestance for DPS");
    TryCast(2457, "player");
  }

  public GetName(): string {
    return this.name;
  }

  public RestNeeded(): boolean {
    return false;
  }

  public PrepareNeeded(): boolean {
    return !UnitAffectingCombat("player");
  }

  public CombatNeeded(): boolean {
    return UnitAffectingCombat("player");
  }

  public ExecuteRest(): void {}

  public ExecutePrepare(): void {
    targets.IncludeNeutralTargets = true;
    targets.updateTargets();
    UpdateHealing();
    const stance = GetShapeshiftForm();
    if (stance !== 1) {
      TryCast(2457, "player");
    }
  }

  public ExecuteCombat(): void {
    targets.IncludeNeutralTargets = true;
    targets.updateTargets();
    UpdateHealing();
    AutoTarget(targets.closestHarmfulTarget);

    const attacking = IsCurrentSpell(6603);
    const rage = UnitPower("player");
    const stance = GetShapeshiftForm();

    if (!attacking) MeleeStartAttack();

    if (SB.BattleShout && !Buff("player", SB.BattleShout)) {
      TryCast(SB.BattleShout, "player");
    }

    if (UnitHealthPercent("player") && rage <= 80) {
      TryCast(2687, "player");
    }

    print(stance);

    if (stance === 1) this.battleStance();
    if (stance === 2) this.defensiveStance();
  }
}

const rotation = new WarriorLevelingRotation();
const specId = 1;

if (!WowEx.Rotations[specId]) {
  WowEx.Rotations[specId] = rotation;
}
