/** @noSelfInFile */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-empty-interface */

/** @luaIterator */
interface GmatchIterable extends Array<string> {}

interface String {
  gmatch(pattern: string): GmatchIterable;
}

/** @vararg */
interface Vararg<T> extends Array<T> {}

/** For access to file scope variables, e.g. const [addon] = [...vargs]; */
declare const vargs: Vararg<string>;

declare function tonumber(value: any, base?: number): number | undefined;
declare function type(
  value: any
):
  | "nil"
  | "number"
  | "string"
  | "boolean"
  | "table"
  | "function"
  | "thread"
  | "userdata";
declare function setmetatable<T extends object>(table: T, metatable: any): T;
declare function rawget<T, K extends keyof T>(table: T, key: K): T[K];
declare function rawset<T, K extends keyof T>(
  table: T,
  key: K,
  val: T[K]
): void;
/** @tupleReturn */
declare function next<K, V>(table: Record<any, V>, index?: K): [K, V];
declare function pcall(func: () => any): any;
declare function unpack<T>(list: T[], i?: number, j?: number): T[];
