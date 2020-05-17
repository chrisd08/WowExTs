declare interface LibCC {
  /** @tupleReturn */
  UnitCastingInfo(unitId: WowUnit): ReturnType<typeof CastingInfo>;
  /** @tupleReturn */
  UnitChannelInfo(unitId: WowUnit): ReturnType<typeof ChannelInfo>;
}

/** @noSelf */
declare interface LibDraw {
  clearCanvas(): void;
  Sync(callback: Function): void;
  Remove(callback: Function): void;
  SetWidth(width: number): void;
  Enable(interval: number): void;
  SetColor(r: number, g: number, b: number, a: number);
  Text(text: string, font: string, x: number, y: number, z: number): void;
  Line(sx: number, sy: number, sz: number, dx: number, dy: number, dz: number);
  Cross(
    x: number,
    y: number,
    z: number,
    width: number,
    rotation: number,
    reach: number
  );
  Box(
    x: number,
    y: number,
    z: number,
    width: number,
    height: number,
    rotation: number,
    offsetX?: number,
    offsetY?: number
  );
}

/** @noSelf */
declare interface InstantHealth {
  UnitHealth(unitId: WowUnit): number;
  UnitHealthMax(unitId: WowUnit): number;
}

declare interface LibDuration {
  /** @tupleReturn */
  UnitAuraDirect: (
    this: void,
    unitId: WowUnit,
    index: number,
    filter?: WowBuffFilterType & string,
    friendly: boolean
  ) => ReturnType<typeof UnitBuff>;

  RegisterCallback: (
    this: void,
    addon: string,
    event: string,
    callback: () => void
  ) => void;

  /** @tupleReturn */
  GetAuraDurationByUnit(
    unit: WowGuid,
    spellId: number,
    caster?: WowUnitId,
    spellName?: string
  ): [number, number];
}

declare interface LibBossIDs {
  BossIDs: Record<number, boolean>;
}

declare interface LibThreatClassic2 {
  /**
   * @returns
   * - **isTanking**: returns 1 if the unit is primary threat target of the mob (is tanking), or nil otherwise.
   * - **threatStatus**: returns the threat status for the unit on the mob, or nil if unit is not on mob's threat table. (3 = securely tanking, 2 = insecurely tanking, 1 = not tanking but higher threat than tank, 0 = not tanking and lower threat than tank)
   * - **threatPercent**: returns the unit's threat on the mob as a percentage of the amount required to pull aggro, scaled according to the unit's range from the mob. At 100 the unit will pull aggro. Returns 100 if the unit is tanking and nil if the unit is not on the mob's threat list.
   * - **threatRawPercent**: returns the unit's threat as a percentage of the tank's current threat. Returns nil if the unit is not on the mob's threat list.
   * - **threatRaw**: returns the unit's total threat on the mob.
   * @tupleReturn
   */
  UnitDetailedThreatSituation(
    unit: WowUnitId,
    target: WowUnitId
  ): [WowFlag, number, number, number, number];
  UnitThreatSituation(unit: WowUnitId, target: WowUnitId): number | null;
  UnitThreatPercentageOfLead(unit: WowUnitId, target: WowUnitId): number;
}

declare namespace TomTom {
  function GetClosestWaypoint(): [number, number, number];
}

declare namespace ZGV {
  const Pointer: {
    current_waypoint: {
      map: number;
      x: number;
      y: number;
    };
  };
}
