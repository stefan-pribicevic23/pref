const REJECTED_KEYWORDS = /DROP|SELECT|UPDATE|SET|;/ig;

export class SafeString extends String {
  constructor(s) {
    if (s.match(REJECTED_KEYWORDS)) {
      throw new Error('SQL injection prevented!');
    }

    super(s);
  }
}

export default function sql(strings, ...keys) {
  let lastParam = 0;
  const query = strings
    .map((s, i) => {
      if (keys[i] instanceof SafeString) {
        const sqlString = keys[i].toString();
        keys.splice(i, 1);
        return `${s}${sqlString}`;
      }

      if (i + 1 === strings.length) {
        return s;
      }

      lastParam++;

      return `${s}\$${lastParam}`;
    })
    .join('');
  return [query, keys];
}