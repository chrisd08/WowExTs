/** @noSelfInFile */

// interfaces
declare interface WowEx {
  Rotations: {
    [id: number]: Rotation;
  };
  Spellbook: Spellbook;
  GarroteGouge: () => void;
  Sap: () => void;
  Kick: () => void;
  Poisons: () => void;
  TargetNearestEnemy: () => void;
}

declare interface Rotation {
  GetName(): string;
  RestNeeded(): boolean;
  PrepareNeeded(): boolean;
  CombatNeeded(): boolean;
  ExecuteRest(): void;
  ExecutePrepare(): void;
  ExecuteCombat(): void;
  OnTick?: () => void;
}

// types
declare type WowUnit = WowGuid | WowUnitId;

// globals
declare const WowEx: WowEx;
declare const LocalPlayer: {
  LastCastSucceeded: number;
};

// targets
declare interface Targets {
  IncludeNeutralTargets: boolean;
  closestHarmfulTarget: WowUnit;
  updateTargets(): void;
}
declare const targets: Targets;

// healing
declare function UpdateHealing(): void;

// sdk
declare function WowExLoaded(): boolean;

declare function getBest(spellList: number[]): number;

declare function TryCast(
  spellId: number,
  unit: WowUnit,
  ignoreLos?: boolean,
  ignoreFacing?: boolean,
  ignoreCasting?: boolean,
  ignoreMounted?: boolean
): boolean;

declare function Cast(spellId: number, target: WowUnit): void;

declare function AutoTarget(unit: WowUnit): void;

declare function MeleeStartAttack(): void;

declare function Buff(target: WowUnit, spell: number): boolean;

declare function UnitHealthPercent(unit: WowUnit): number;

declare function AuraRemains(
  target: WowUnit,
  spell: number,
  allPlayers?: boolean
): number;

/** @tupleReturn */
declare function UnitsAroundUnit(
  unit: WowUnit,
  distance: number,
  ignoreCombat?: boolean
): [number, WowUnit[]];

declare function UnitIsFacing(
  unit1: WowUnit,
  unit2: WowUnit,
  degrees?: number
): boolean;

declare function MovingAwayFrom(unit1: WowUnit, unit2: WowUnit): boolean;

declare function DebuffAny(unit: WowUnit, spellId: number): boolean;

declare function IsMoving(unit: WowUnit): boolean;

declare function IsAttacking(): boolean;

declare function IsPlayerCasting(): boolean;

declare function SpellCooldown(spellId: number): number;

declare function useItem(name: string, target: WowUnitId): void;

declare function GetSpellInfoEx(spellId: number): string | undefined;

declare function ExecuteMacro(macroText: string): void;

declare function CallSecureFunction(name: string, ...args: string[]): void;

declare function ttd(unit: WowUnit): number;
