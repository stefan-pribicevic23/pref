import express from 'express';
import http from 'http';
import cors from 'cors';
import bodyParser from 'body-parser';
import pkg from 'pg';
const { Client } = pkg;

const client = new Client({
  connectionString: 'postgres://postgres:admin@localhost:5434/postgres'
});

client.connect((err) => {
  if (err) {
    console.error('connection error', err.stack)
  } else {
    console.log('connected')
  }
})

const PORT = 4008;

const app = express();
app.use(cors(), bodyParser.json());

app.get('/users', async (req, res) => {
  const queryResult = await client.query('select * from users');
  res.json(queryResult.rows);
})

const server = http.createServer(app);

server.listen(PORT);
console.log(`Server listening on port ${PORT}`);