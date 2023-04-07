import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
  connectionString: 'postgres://postgres:admin@localhost:5434/postgres'
});

export async function query(rawQuery, values) {
  const client = await pool.connect();

  try {
    return client.query(rawQuery, values);
  } catch (e) {
    console.error(e);
  } finally {
    client.release();
  }
}