import express from 'express';
import http from 'http';
import cors from 'cors';
import bodyParser from 'body-parser';

import createGame from './repo/game/createGame.mjs';
import { authMiddelware } from './middleware/auth.mjs';
import UserService from './services/users.mjs';
import GameService from './services/game.mjs';
import expressWs from 'express-ws';
import WebSocket from 'ws';
import WebSocketService from './services/ws.mjs';

const PORT = 4008;

const app = express();
const server = http.createServer(app);
const aWss = expressWs(app, server);

WebSocketService.ws = aWss;

app.use(cors(), bodyParser.json());

app.use(authMiddelware);

app.post('/game', async (req, res) => {
  const { rows } = await createGame(req.userData.id);
  res.send(rows[0]);
})

app.put('/game/:id/user/', async (req, res) => {
  try {
    const gameService = new GameService();
    await gameService.addUser(req.params.id, req.userData.id);
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

app.ws('/', (ws, req) => {
  ws.on('message', (msg) => {
    // console.log(msg);
    // aWss.getWss('/').clients.forEach((client) => {
    //   console.log(client.id);
    //   console.log(ws.id);
    //   if (client !== ws && client.readyState === WebSocket.OPEN) {
    //     client.send(`${req.userData.username} says: ${msg}`);
    //     console.log(req.userData);
    //   }
    // })
  })

  ws.id = req.userData.id;

  aWss.getWss('/').clients.forEach(function each(client) {
    console.log('Client.ID: ' + client.id);
  });

  ws.on('close', () => {
    console.log('socket closed');
  })
});

server.listen(PORT);
console.log(`Server listening on port ${PORT}`);