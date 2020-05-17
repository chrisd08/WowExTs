/** @noSelfInFile */
/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-empty-interface */

/** @luaIterator */
interface GmatchIterable extends Array<string> {}

interface String {
  gmatch(pattern: string): GmatchIterable;
  find(pattern: string): number | null;
}

/** @vararg */
interface Vararg<T> extends Array<T> {}

/** For access to file scope variables, e.g. const [addon] = [...vargs]; */
declare const vargs: Vararg<string>;

declare namespace math {
  function atan2(y: number, x: number): number;
  const huge: number;
  const pi: number;
}

declare function pairs<T>(t: T): LuaTupleIterable<[keyof T, T[keyof T]]>;

declare function tostring(value: any): string | undefined;
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
declare function memoize<T extends unknown[], U>(
  this: void,
  input: (this: void, ...args: T) => U
): (this: void, ...args: T) => U;
declare function require(this: void, module: string): void;
/**
 * @tupleReturn
 */
declare function select<T>(index: number, ...args: T[]): T[];

declare function debugprofilestop(): number;
declare function gcinfo(): number;
