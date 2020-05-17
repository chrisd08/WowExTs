/** @noSelfInFile */

declare namespace C_Timer {
  interface Ticker {
    Cancel(): void;
    IsCancelled(): boolean;
  }

  /**
   * Creates a new timer.
   * @param duration Seconds before the timer completes.
   * @param callback What you want to execute when the timer's duration has elapsed.
   * @see https://wow.gamepedia.com/API_C_Timer.After
   */
  function After(duration: number, callback: () => void): void;

  function NewTimer(duration: number, callback: () => void): Ticker;

  function NewTicker(
    duration: number,
    callback: () => void,
    iterations?: number
  ): Ticker;
}

declare namespace C_LossOfControl {
  /**
   * Returns the number of loss-of-control effects your character is currently affected by.
   * @see https://wow.gamepedia.com/API_C_LossOfControl.GetNumEvents
   */
  function GetNumEvents(): number;

  /**
   * Returns information about a loss-of-control event.
   * @param eventIndex index of the loss-of-control effect currently affecting your character to return information about, ascending from 1.
   * @see https://wow.gamepedia.com/API_C_LossOfControl.GetEventInfo
   * @tupleReturn
   */
  function GetEventInfo(
    eventIndex: number
  ): [string, number, LossOfControlType, string, number, number, number];
}

/** @compileMembersOnly */
declare enum LossOfControlType {
  LOSS_OF_CONTROL_DISPLAY_STUN,
  LOSS_OF_CONTROL_DISPLAY_STUN_MECHANIC,
  LOSS_OF_CONTROL_DISPLAY_DISARM,
  LOSS_OF_CONTROL_DISPLAY_PACIFY,
  LOSS_OF_CONTROL_DISPLAY_FEAR,
  LOSS_OF_CONTROL_DISPLAY_CHARM,
  LOSS_OF_CONTROL_DISPLAY_POSSESS,
  LOSS_OF_CONTROL_DISPLAY_ROOT,
  LOSS_OF_CONTROL_DISPLAY_POLYMORPH,
  LOSS_OF_CONTROL_DISPLAY_INCAPACITATE,
}

/** @compileMembersOnly */
declare enum ItemType {
  LE_ITEM_CLASS_MISCELLANEOUS,
}

/** @compileMembersOnly */
declare enum ItemSubType {
  LE_ITEM_WEAPON_DAGGER,
  LE_ITEM_MISCELLANEOUS_JUNK,
}

/** @compileMembersOnly */
declare enum SpellFailedType {
  SPELL_FAILED_TARGET_NO_POCKETS,
  SPELL_FAILED_LINE_OF_SIGHT,
}

declare const WorldFrame: WowFrame;
declare const TargetFrame: WowFrame;

declare const WorldMapFrame: WowFrame & {
  GetMapID: () => number;
  ScrollContainer: WowFrame & {
    /** @tupleReturn */
    GetNormalizedCursorPosition: () => [number, number];
  };
};

declare interface Vector2DMixin {
  /** @tupleReturn */
  GetXY(): [number, number];
}

declare namespace C_Map {
  /** @tupleReturn */
  function GetWorldPosFromMapPos(
    mapId: number,
    position: Vector2DMixin
  ): [number, Vector2DMixin];

  function GetBestMapForUnit(unit: WowUnitId): number;
}

declare function CreateVector2D(x: number, y: number): Vector2DMixin;

declare type WowClass =
  | "Warrior"
  | "Paladin"
  | "Priest"
  | "Shaman"
  | "Druid"
  | "Rogue"
  | "Mage"
  | "Warlock"
  | "Hunter";

declare interface WowFontInstance extends WowUiObject {
  /**
   * Sets the spacing between lines of text in the object.
   *
   * @param spacing the new spacing
   */
  SetSpacing(spacing: number): void;
}

declare interface GameTooltip {
  HookScript(
    event: "OnTooltipSetUnit",
    handler: (frame: GameTooltip) => void
  ): void;
}

declare interface WowTooltip extends WowFrame {
  /**
   * Shows the tooltip for the specified spell by global spell ID.
   * @param frame Owner frame, which defines the element where the tooltip is centered on.
   * @param anchor String that describes the anchor point as it would be set via the :SetPoint() function.
   */
  SetOwner(frame: WowFrame, anchor: string): void;

  /**
   * Shows the tooltip for the specified spell by global spell ID.
   * @param spellId
   */
  SetSpellByID(spellId: number): void;

  /**
   * Sets the GameTooltip to contain text information about the specified item.
   * @param spellId
   * @see https://wow.gamepedia.com/API_GameTooltip_SetBagItem
   */
  SetBagItem(bag: number, slot: number): void;
}

/** Creates a new GameTooltip frame. */
declare function CreateFrame(
  frameType: "GameTooltip",
  frameName?: string,
  parentFrame?: WowUiObject,
  inheritsFrame?: string,
  id?: number
): WowTooltip;

/** Creates a font object. */
declare function CreateFont(name: string): WowFontInstance;

declare interface WowFrame
  extends WowRegion,
    WowObjectHookScript<WowFrame>,
    WowObjectSetScript<WowFrame> {
  /**
   * Sets whether keyboard input is consumed by this frame or propagates to further frames.
   * @param propagate true to propagate keyboard input further, false to consume keyboard input immediately.
   * @see https://wow.gamepedia.com/API_Frame_SetPropagateKeyboardInput
   */
  SetPropagateKeyboardInput(propagate: boolean): void;
}

declare interface WowObjectSetScript<T extends WowUiObject> {
  SetScript(
    event: "OnKeyDown" | "OnKeyUp",
    handler: (frame: T, key: string) => void
  ): void;
}

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
declare function ExUnitPower(unit: WowUnit, powerType?: number): number;

/**
 * Returns the maximum power of the specified unit.
 * @param unitId Unit whose maximum power should be returned.
 * @param powerType Type of resource (mana/rage/energy/etc) to query.
 * @see https://wow.gamepedia.com/API_UnitPowerMax
 */
declare function UnitPowerMax(unitId: WowUnitId, powerType?: number): number;

/**
 * Determine whether a unit is in combat or has aggro.
 * @param unitId The UnitId of the unit to check.
 * @see https://wow.gamepedia.com/API_UnitAffectingCombat
 */
declare function UnitAffectingCombat(unitId: WowUnitId): boolean;
declare function ExUnitAffectingCombat(unit: WowUnit): boolean;

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
 * Returns the unit's melee attack speed for each hand.
 * @param unitId The unit to get information from. (Verified for "player" and "target").
 * @see https://wow.gamepedia.com/API_UnitAttackSpeed
 * @tupleReturn
 */
declare function UnitAttackSpeed(unitId: WowUnitId): [number, number | null];

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
declare function UnitCanAttack(
  unitId: WowUnitId,
  targetId: WowUnitId
): WowFlag | null;
declare function ExUnitCanAttack(
  unit: WowUnit,
  target: WowUnit
): WowFlag | null;

/**
 * Returns true if the two specified units are the same, false otherwise.
 * @param unit1 The first unit to query (e.g. "party1", "pet", "player").
 * @param unit2 The second unit to compare it to (e.g. "target").
 * @see https://wow.gamepedia.com/API_UnitCanAttack
 */
declare function UnitIsUnit(unit1: WowUnitId, unit2: WowUnitId): 1 | null;
declare function ExUnitIsUnit(unit1: WowUnit, unit2: WowUnit): 1 | null;

/**
 * Determines if the unit exists
 * @param unitId The unit to query (e.g. "player", "party2", "pet", "target" etc.)
 * @see https://wow.gamepedia.com/API_UnitExists
 */
declare function ExUnitExists(unit: WowUnit): 1 | null;

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
 * Returns whether left shift modifier key is currently pressed down.
 */
declare function IsLeftShiftKeyDown(): boolean;

/**
 * Returns whether left alt modifier key is currently pressed down.
 */
declare function IsLeftAltKeyDown(): boolean;

/**
 * Returns whether left controler modifier key is currently pressed down.
 */
declare function IsLeftControlKeyDown(): boolean;

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
 * Returns a value representing the moving speed of a unit.
 * @param unitId Unit to query the speed of. This has not been tested with all units but does work for "player" units.
 * @see https://wow.gamepedia.com/API_GetUnitSpeed
 */
declare function GetUnitSpeed(unitId: WowUnitId): number;
declare function ExGetUnitSpeed(unit: WowUnit): number;

/**
 * Returns the current COMBAT_LOG_EVENT payload.
 * @tupleReturn
 */
declare function CombatLogGetCurrentEventInfo(): CombatLogEventArgs;

type WowInstanceType = "none" | "pvp" | "arena" | "party" | "raid" | "scenario";

/**
 * Checks whether the player is in an instance and the type of instance.
 * @see https://wow.gamepedia.com/API_IsInInstance
 * @tupleReturn
 */
declare function IsInInstance(): [WowFlag, WowInstanceType];

/**
 * Returns whether the player is in a group.
 * @see https://wow.gamepedia.com/API_IsInGroup
 */
declare function IsInGroup(): boolean;

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

/**
 * Returns various network statistics.
 * @see https://wow.gamepedia.com/API_GetNetStats
 * @tupleReturn
 */
declare function GetNetStats(): [number, number, number, number];

/** Cancels current queued spell */
declare function SpellCancelQueuedSpell(): void;

declare function StopAttack(): void;

/**
 * Returns the GUID of the specified unit
 * @param unitId unit to look up the GUID of
 * @see https://wow.gamepedia.com/API_UnitGUID
 * @since 2.4.0
 */
declare function ExUnitGUID(unit: WowUnit): WowGuid;

/**
 * Returns the class of the specified unit
 * @param unitId unit to query, e.g. "player"
 * @see https://wow.gamepedia.com/API_UnitClass
 * @tupleReturn
 */
declare function ExUnitClass(unit: WowUnit): [WowClass, string, number];

/**
 * Returns the unit's level
 * @param unitId The unitId to get information from. (e.g. "player", "target")
 * @return The unit level. Returns -1 for bosses, or players more than 10 levels above the player
 * @see https://wow.gamepedia.com/API_UnitEffectiveLevel
 */
declare function ExUnitLevel(unit: WowUnit): number;

/**
 * Returns the current health of the specified unit
 * @param unitId identifies the unit to query health for
 * @see https://wow.gamepedia.com/API_UnitHealth
 */
declare function ExUnitHealth(unit: WowUnit): number;

/**
 * Returns the maximum health of the specified unit
 * @param unitId the unit whose max health to query
 * @see https://wow.gamepedia.com/API_UnitHealthMax
 */
declare function ExUnitHealthMax(unit: WowUnit): number;

/**
 * Returns whether the unit can be tapped
 * @param unitId the unit to query
 */
declare function ExUnitIsTapDenied(unit: WowUnit): boolean;

/**
 * Returns a value indicating whether the specified unit is dead or in ghost form.
 * @param unitId the unit to query
 * @see https://wow.gamepedia.com/API_UnitIsDeadOrGhost
 */
declare function UnitIsDeadOrGhost(unitId: WowUnitId): boolean;
declare function ExUnitIsDeadOrGhost(unit: WowUnit): boolean;

/**
 * Determine the reaction of the specified unit to the other specified unit.
 * @param unit1 The UnitId of the unit whose reaction is to be determined.
 * @param unit2 The UnitId of the unit towards whom the reaction is to be measured.
 */
declare function UnitReaction(
  unit1: WowUnitId,
  unit2: WowUnitId
): number | null;
declare function ExUnitReaction(unit1: WowUnit, unit2: WowUnit): number | null;

/**
 * Returns the creature type of the specified unit.
 * @param unitId the unit to query creature type of.
 * @see https://wow.gamepedia.com/API_UnitCreatureType
 */
declare function UnitCreatureType(unitId: WowUnitId): string;
declare function ExUnitCreatureType(unit: WowUnit): string;

/**
 * Returns if you are in range of the specified unit to use the specified item
 * @param itemIdentifier Number/String/String - Numeric ID of the item, name of the item, or itemLink of the item to query
 * @param unit which unit the range should be checked to
 * @returns
 * - If the item is not in range, false; if the item is in range, true; if the query is invalid, nil
 * - If the item is not in range, 0; if the item is in range, 1; if the query is invalid, nil
 * @see https://wow.gamepedia.com/API_IsItemInRange
 */
declare function ExIsItemInRange(
  itemIdentifier: string | number | WowItemLink,
  unit?: WowUnit
): boolean | null;

/**
 * Returns whether a given spell is in range.
 * @param spellName spell name to check the range of. The player must know the spell.
 * @param unit unit to use as a target for the spell.
 * @see https://wow.gamepedia.com/API_IsSpellInRange
 */
declare function ExIsSpellInRange(
  spellName: string,
  unit: WowUnit
): WowFlag | null;

/**
 * Checks if a specified unit is a player
 * @param unitId UnitId of the unit to check.
 * @see https://wow.gamepedia.com/API_UnitIsPlayer
 */
declare function ExUnitIsPlayer(unit: WowUnit): boolean;

/**
 * Retrieve info about a certain buff on a certain unit
 * @param unitId unit whose buffs to query
 * @param index index (from 1 to 40)
 * @param filter list of filters, separated by spaces or pipes ("|"). "HELPFUL" by default
 * @see https://wow.gamepedia.com/API_UnitBuff
 * @tupleReturn
 */
// tslint:disable-next-line max-line-length
declare function ExUnitBuff(
  unitId: WowUnit,
  index: number,
  filter?: WowBuffFilterType & string
): [
  string,
  WowTexturePath,
  number,
  WowDebuffType,
  number,
  number,
  WowUnitId,
  boolean,
  boolean,
  number,
  boolean,
  boolean,
  boolean,
  number,
  number,
  number,
  number
];

/**
 * Retrieve info about a specified debuff on a certain unit
 * @param unitId unit whose buffs to query
 * @param index index (from 1 to 40)
 * @param filter list of filters, separated by spaces or pipes ("|"). "HELPFUL" by default
 * @see https://wow.gamepedia.com/API_UnitBuff
 * @tupleReturn
 */
// tslint:disable-next-line max-line-length
declare function ExUnitDebuff(
  unitId: WowUnit,
  index: number,
  filter?: WowBuffFilterType & string
): [
  string,
  WowTexturePath,
  number,
  WowDebuffType,
  number,
  number,
  WowUnitId,
  boolean,
  boolean,
  number,
  boolean,
  boolean,
  boolean,
  number,
  number,
  number,
  number
];

/**
 * Checks whether you are in range to perform a specific interaction with a specified unit.
 * @param unit Unit to compare distance to.
 * @param distIndex A value from 1 to 5.
 * @see https://wow.gamepedia.com/API_CheckInteractDistance
 */
declare function ExCheckInteractDistance(
  unit: WowUnit,
  distIndex: number
): WowFlag;

/**
 * Determines whether a spell can be used by the player character.
 * @param spellId SpellID of a spell to check.
 * @see https://wow.gamepedia.com/API_IsUsableSpell
 * @tupleReturn
 */
declare function IsUsableSpell(spellId: number): [boolean, boolean];

/**
 * Returns information about a talent.
 * @param tier Talent tier, ascending from 1.
 * @param column Talent column, ascending from 1.
 * @see https://wow.gamepedia.com/API_GetTalentInfo
 * @tupleReturn
 */
declare function GetTalentInfo(
  tier: number,
  column: number
): [string, string, number, number, number, number, boolean];

/**
 * Returns the classification of the specified unit (e.g., "elite" or "worldboss").
 * @param unitId the unit to query, e.g. "target".
 * @see https://wow.gamepedia.com/API_UnitClassification
 */
declare function UnitClassification(unitId: WowUnitId): string;
declare function ExUnitClassification(unitId: WowUnit): string;

/**
 * Returns the item id of the item in the specified inventory slot.
 * @param unitId the UnitId of the unit whose inventory is to be queried.
 * @param slot index of the inventory slot to query.
 * @see https://wow.gamepedia.com/API_GetInventoryItemID
 * @tupleReturn
 */
declare function GetInventoryItemID(
  unitId: WowUnitId,
  slot: WOW_INVENTORY_SLOT_ID
): [number | null, number];

/**
 * Returns the name and other information which is associated with the specific skill or skill header in the game.
 * @param skillIndex The row of the skill display to request information from.
 * @see https://wow.gamepedia.com/API_GetSkillLineInfo
 * @tupleReturn
 */
declare function GetSkillLineInfo(
  skillIndex: number
): [string, WowFlag, WowFlag, number];

/**
 * Returns 1 if the unit is a player in your party, nil otherwise.
 * @param unitId the unit to query, e.g. "target".
 * @see https://wow.gamepedia.com/API_UnitInParty
 */
declare function UnitInParty(unitId: WowUnitId): WowFlag;
declare function ExUnitInParty(unit: WowUnit): WowFlag;

/**
 * Returns a number if the unit is in your raid group, nil otherwise.
 * @param unitId the unit to query, e.g. "target".
 * @see https://wow.gamepedia.com/API_UnitInRaid
 */
declare function UnitInRaid(unitId: WowUnitId): number | null;
declare function ExUnitInRaid(unit: WowUnit): number | null;

/**
 * Returns the raid target index assigned to a unit.
 * @param unitId the unit to query, e.g. "target".
 * @see https://wow.gamepedia.com/API_GetRaidTargetIndex
 */
declare function GetRaidTargetIndex(unitId: WowUnitId): number | null;
declare function ExGetRaidTargetIndex(unit: WowUnit): number | null;

declare function IsHarmfulSpell(spellName: string): boolean;

declare function FlashClientIcon(): void;

/**
 * Returns the subzone name.
 * @see https://wow.gamepedia.com/API_GetSubZoneText
 */
declare function GetSubZoneText(): string;

/**
 * Returns the total number of players in a group.
 * @see https://wow.gamepedia.com/API_GetNumGroupMembers
 */
declare function GetNumGroupMembers(): number;

/**
 * Returns 1 if unit is on a taxi, nil otherwise.
 * @see https://wow.gamepedia.com/API_UnitOnTaxi
 */
declare function UnitOnTaxi(unit: WowUnitId): boolean;

/**
 * Play one of a set of built-in sounds. Other players will not hear the sound.
 * @param soundKitID All sounds used by Blizzard's UI are defined in the SOUNDKIT table.
 * @param channel  The sound volume slider setting the sound should use, one of: Master, SFX, Music, Ambience, Dialog.
 * @see https://wow.gamepedia.com/API_PlaySound
 */
declare function PlaySound(soundKitID: number, channel?: string): void;

/**
 * Play one of a set of built-in sounds. Other players will not hear the sound.
 * @param soundFile The path and name of the sound file you'd like to play, relative to the WoW directory.
 * @param channel  The sound volume slider setting the sound should use, one of: Master, SFX, Music, Ambience, Dialog.
 * @see https://wow.gamepedia.com/API_PlaySoundFile
 */
declare function PlaySoundFile(soundFile: string, channel?: string): void;

declare function UnitIsOtherPlayersPet(unit: WowUnitId): boolean;
declare function ExUnitIsOtherPlayersPet(unit: WowUnit): boolean;
