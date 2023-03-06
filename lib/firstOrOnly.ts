//eslint-disable-next-line @typescript-eslint/no-explicit-any
export const firstOrOnly = <T>(data: T[] | null | undefined, fallback: T) =>
  data ? (Array.isArray(data) ? data[0] : data) : fallback;
