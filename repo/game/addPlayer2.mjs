import { query } from '../../db/connPool.mjs';
import sql from '../../db/queryHelpers.mjs';

export default async function addPlayer2(gameId, userId) {
  const q = sql`
    update games
    set player2=${userId}
    where id=${gameId}
  `;

  const result = await query(...q);

  return result;
}