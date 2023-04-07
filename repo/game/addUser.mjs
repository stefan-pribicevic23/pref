import { query } from '../../db/connPool.mjs';
import sql from '../../db/queryHelpers.mjs';

export default async function addUser(gameId, userId) {
  const q = sql`
    insert into games(created_at,status,admin)
    values(${new Date()}, 'created', ${userId})
    returning id;
  `;

  const result = await query(...q);

  return result;
}