/** @noSelfInFile */

declare namespace C_Timer {
  interface Ticker {
    Cancel(): void;
  }

  /**
   * Creates a new timer.
   * @param duration Seconds before the timer completes.
   * @param callback What you want to execute when the timer's duration has elapsed.
   * @see https://wow.gamepedia.com/API_C_Timer.After
   */
  function After(duration: number, callback: () => void): void;

  function NewTicker(duration: number, callback: () => void): Ticker;
}

declare const WorldFrame: WowFrame;

/**
 * Returns the unit's current shapeshift form.
 * @param flag Whether return value is to be compared to a macro's conditional statement.
 * @see https://wow.gamepedia.com/API_GetShapeshiftForm
 */
declare function GetShapeshiftForm(flag?: boolean): number;

/**
 * Returns whether a spell is currently is being casted by the player or is
 * placed in the queue to be casted next. If spell is current then action bar
 * indicates its slot with highlighted frame.
 * @param spellId Spell ID to query.
 * @return true if currently being casted or queued, false otherwise.
 * @see https://wow.gamepedia.com/API_IsCurrentSpell
 */
declare function IsCurrentSpell(spellId: number): boolean;

/**
 * Returns the current power of the specified unit.
 * @param unitId Unit whose power should be returned.
 * @param powerType Type of resource (mana/rage/energy/etc) to query.
 * @see https://wow.gamepedia.com/API_UnitPower
 */
declare function UnitPower(unitId: WowUnitId, powerType?: number): number;

/**
 * Determine whether a unit is in combat or has aggro.
 * @param unitId The UnitId of the unit to check.
 * @see https://wow.gamepedia.com/API_UnitAffectingCombat
 */
declare function UnitAffectingCombat(unitId: WowUnitId): boolean;

/**
 * Returns a value indicating whether the specified unit is dead.
 * @param unitId The UnitId of the unit to check.
 * @see https://wow.gamepedia.com/API_UnitIsDead
 */
declare function UnitIsDead(unitId: WowUnitId): boolean;
declare function ExUnitIsDead(unit: WowUnit): boolean;

/**
 * Returns the unit's melee attack power and modifiers.
 * @param unitId The unit to get information from. (Does not work for "target" - Possibly only "player" and "pet").
 * @see https://wow.gamepedia.com/API_UnitAttackPower
 */
declare function UnitAttackPower(unitId: WowUnitId): number;

/**
 * Returns the name and realm of the specified unit.
 * @param unitId The UnitId to query (e.g. "player", "party2", "pet", "target" etc.)
 * @see https://wow.gamepedia.com/API_UnitName
 */
declare function UnitName(unitId: WowUnitId): string;
declare function ExUnitName(unit: WowUnit): string;

/**
 * Returns 1 if the first unit can attack the second, nil otherwise.
 * @param unitId The unit that would initiate the attack (e.g., "player" or "target").
 * @param targetId The unit that would be attacked (e.g., "player" or "target").
 * @see https://wow.gamepedia.com/API_UnitCanAttack
 */
declare function UnitCanAttack(unitId: WowUnitId, targetId: WowUnitId): number;
declare function ExUnitCanAttack(unit: WowUnit, target: WowUnit): number;

/**
 * Returns true if the two specified units are the same, false otherwise.
 * @param unit1 The first unit to query (e.g. "party1", "pet", "player").
 * @param unit2 The second unit to compare it to (e.g. "target").
 * @see https://wow.gamepedia.com/API_UnitCanAttack
 */
declare function UnitIsUnit(unit1: WowUnitId, unit2: WowUnitId): number;
declare function ExUnitIsUnit(unit: WowUnit, unit2: WowUnit): number;

/**
 * Returns the current value of a console variable.
 * @param name name of the CVar to query the value of.
 * @see https://wow.gamepedia.com/API_GetCVar
 */
declare function GetCVar(name: string): string | null;

/**
 *
 * @param itemId Numeric ID of the item, name of the item, or itemLink of the item to query.
 * @param includeBank Should count include bank items.
 * @param includeCharges Should count be number of charges if item has charges.
 * @returns The number of items in your possesion, or charges if includeCharges is true and the item has charges.
 * @see https://wow.gamepedia.com/API_GetItemCount
 */
declare function GetItemCount(
  itemId: number | string,
  includeBank?: boolean,
  includeCharges?: boolean
): number;

/**
 * Sets a console variable.
 * @param name name of the CVar.
 * @param value the new value of the CVar. If omitted, defaults to "0".
 * @returns whether the CVar was successfully set.
 * @see https://wow.gamepedia.com/API_SetCVar
 */
declare function SetCVar(name: string, value: string): boolean;

/**
 * Returns whether left shift modifier key is current pressed down.
 */
declare function IsLeftShiftKeyDown(): boolean;

/**
 * Returns whether a particular mouse button is currently being held down.
 * @param buttonName Identifier of the button to check, e.g "LeftButton", "RightButton", "MiddleButton", "BUTTON4".
 * @see https://wow.gamepedia.com/API_IsMouseButtonDown
 */
declare function IsMouseButtonDown(buttonName?: string): boolean;

/**
 * Returns the system uptime of your computer in seconds, with millisecond precision.
 * @see https://wow.gamepedia.com/API_GetTime
 */
declare function GetTime(): number;

/**
 * "Picks up" an item from the player's worn inventory. This appears to be a kind of catch-all "pick up/activate" function.
 * @param slotId The slot ID of the worn inventory slot.
 * @see https://wow.gamepedia.com/API_PickupInventoryItem
 */
declare function PickupInventoryItem(slotId: number): void;

/**
 * Returns whether a spell is about to be cast, waiting for the player to select a target.
 * @see https://wow.gamepedia.com/API_SpellIsTargeting
 */
declare function SpellIsTargeting(): boolean;

/** Returns power regen per second */
declare function GetPowerRegen(): number;

/**
 * Returns the current COMBAT_LOG_EVENT payload.
 * @tupleReturn
 */
declare function CombatLogGetCurrentEventInfo(): [
  number,
  CombatLogEvent,
  ...(string | number | WowGuid)[]
];

/**
 * Returns information about the spell currently being cast by the specified unit.
 * @param unitId The unit to query (e.g. "player", "party2", "pet", "target" etc.)
 * @see https://wow.gamepedia.com/API_UnitCastingInfo
 * @tupleReturn
 */
declare function CastingInfo(
  unitId: WowUnitId
): [string, string, string, number, number, boolean, string, boolean, number];

/**
 * Returns information about the spell currently being channeled by the specified unit.
 * @param unitId The unit to query (e.g. "player", "party2", "pet", "target" etc.)
 * @see https://wow.gamepedia.com/API_UnitChannelInfo
 * @tupleReturn
 */
declare function ChannelInfo(
  unitId: WowUnitId
): [string, string, string, number, number, boolean, boolean, number];

/** Cancels current queued spell */
declare function SpellCancelQueuedSpell(): void;

declare function StopAttack(): void;
