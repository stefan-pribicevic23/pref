import getGame from '../repo/game/getGame.mjs';
import addPlayer1 from '../repo/game/addPlayer1.mjs';
import addPlayer2 from '../repo/game/addPlayer2.mjs';
import WebSocketService from './ws.mjs';

export default class GameService {
  async addUser(gameId, userId) {
    const game = await getGame(gameId);

    if (game.admin === userId) {
      throw new Error('Admin cannot join game.');
    }

    if (!game.player1) {
      await addPlayer1(gameId, userId);
      return;
    }
    if (!game.player2) {
      if (game.player1 === userId) {
        throw new Error('User already joined the game.');
      }
      await addPlayer2(gameId, userId);
      const wsService = new WebSocketService();
      wsService.broadcastMessage('Game has started');
      wsService.broadcastMessage('Lititation has started');
      wsService.sendMessage('Licitiraj', game.admin);
      return;
    }

    throw new Error('Table is already full, no new players allowed.')
  }
}