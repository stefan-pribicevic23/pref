import sql from '../../db/queryHelpers.mjs';
import { query } from '../../db/connPool.mjs';

export default async function findByUsername(username) {
  const q = sql`
      SELECT username, password
      FROM users
      WHERE username=${username}
    `;

  const { rows } = await query(...q);
  return rows[0];
}