declare function LibStub(this: void, lib: "AceAddon-3.0"): AceAddonFactory;
declare function LibStub(this: void, lib: "AceDB-3.0"): AceDBFactory;
declare function LibStub<T>(
  this: void,
  lib: string
): T & { Register: (addon: string) => void };
