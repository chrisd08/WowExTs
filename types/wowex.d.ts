/** @noSelfInFile */

// interfaces
declare interface WowEx {
  Rotations: {
    [id: number]: Rotation;
  };
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

// sdk
declare function WowExLoaded(): boolean;
declare function WowNetLoaded(): boolean;

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

declare function MeleeStartAttack(): void;

declare function UnitHealthPercent(unit: WowUnit): number;

declare function MovingTowards(unit1: WowUnit, unit2: WowUnit): boolean;

declare function MovingAwayFrom(unit1: WowUnit, unit2: WowUnit): boolean;

declare function IsMoving(unit: WowUnit): boolean;

declare function IsAttacking(): boolean;

declare function IsPlayerCasting(): boolean;

declare function SpellCooldown(spellId: number): number;

declare function GetSpellInfoEx(spellId: number): string | undefined;

declare function ExecuteMacro(macroText: string): void;

declare function CallSecureFunction(name: string, ...args: unknown[]): void;

declare function CallSecureUnitFunction(name: string, ...args: unknown[]): void;

declare function ObjectType(unit: WowUnit): number;

declare function ObjectName(unit: WowUnit): string;

declare function GetObjectCount(): number;

declare function ObjectId(guid: WowGuid): number;

declare function UpdateObjects(): void;

declare function GetObjectWithIndex(index: number): WowGuid;

declare function UnitDistance(unit1: WowUnit, unit2: WowUnit): number;

/** @tupleReturn */
declare function ObjectPosition(unit: WowUnit): [number, number, number];

declare function ObjectFacing(unit: WowUnit): number;

declare function ObjectRawFacing(unit: WowUnit): number;

declare function ClickPosition(x: number, y: number, z: number): void;

declare function IsGuid(arg: WowGuid | string): boolean;

declare function SetMouseOver(guid: WowGuid): WowUnitId;

declare function GetContinentId(): number;

declare function GetAreaId(): number;

/** @tupleReturn */
declare function GetActiveNodeByIndex(index: number): [number, number, number];

declare function GetActiveNodeCount(): number;

declare function FindPath(
  mapId: number,
  sx: number,
  sy: number,
  sz: number,
  ex: number,
  ey: number,
  ez: number,
  useSmoothPath: boolean
): number;

declare function MoveTo(x: number, y: number, z: number): void;

declare function GetKeyState(key: string | number): boolean;

/** @tupleReturn */
declare function WorldToScreen(
  x: number,
  y: number,
  z: number
): [number, number];

/** @tupleReturn */
declare function DistanceBetweenPoints(
  ax: number,
  ay: number,
  az: number,
  bx: number,
  by: number,
  bz: number
): [number, number];

declare function Raycast(
  x1: number,
  y1: number,
  z1: number,
  x2: number,
  y2: number,
  z2: number,
  type: number
): number;

declare function GetExeDirectory(): string;

declare function GetWoWDirectory(): string;

declare function ReadFile(path: string): string | null;

declare function WriteFile(
  path: string,
  content: string,
  append: boolean
): void;

declare function UnitCombatReach(unit: WowUnit): number;

declare function UnitTarget(unit: WowUnit): WowGuid;

/** @tupleReturn */
declare function UnitCastingInfo(
  unit: WowUnit
): [number, WowGuid, number, boolean];

declare function UnitIsLooting(unit: WowUnit): boolean;

declare function UnitIsSitting(unit: WowUnit): boolean;

declare function UnitIsSkinnable(unit: WowUnit): boolean;

declare function UnitIsLootable(unit: WowUnit): boolean;

declare function UnitIsMounted(unit: WowUnit): boolean;

declare function UnitCastTarget(unit: WowUnit): WowGuid;

declare function UnitLootTarget(unit: WowUnit): WowGuid;

declare function UnitItemLevel(unit: WowUnit): number;

declare function ResetHardwareAction(): void;

declare function FaceLocation(x: number, y: number);
