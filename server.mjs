import express from 'express';
import http from 'http';
import cors from 'cors';
import bodyParser from 'body-parser';

import createGame from './repo/game/createGame.mjs';
import addUser from './repo/game/addUser.mjs';
import { authMiddelware } from './middleware/auth.mjs';
import UserService from './services/users.mjs';

const PORT = 4008;

const app = express();
app.use(cors(), bodyParser.json());

app.use(authMiddelware);

app.post('/game', async (req, res) => {
  console.log(req.userData);
  const { rows } = await createGame(req.userData.id);
  res.send(rows[0]);
})

app.post('/game/:id/user', async (req, res) => {
  try {
    await addUser(req.params.id, req.body.userId);
    res.send({
      message: 'User successfully added to game'
    });
  } catch (e) {
    res.send({
      message: e.message,
    });
  }
})

app.post('/login', async (req, res) => {
  const username = req.body.username;
  const password = req.body.password;
  const userService = new UserService();
  try {
    const token = await userService.login(username, password);
    res.send({ token });
  } catch (e) {
    res.send({
      message: e.message,
    });
  }
})

const server = http.createServer(app);

server.listen(PORT);
console.log(`Server listening on port ${PORT}`);