import { query } from '../../db/connPool.mjs';
import sql from '../../db/queryHelpers.mjs';

export default async function getGame(gameId) {
  const q = sql`
    select * from games
    where id=${gameId}
  `;

  const { rows } = await query(...q);

  return rows[0];
}