import WebSocket from 'ws';

export default class WebSocketService {
  static ws = null;

  broadcastMessage(message) {
    WebSocketService.ws.getWss('/').clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message);
      }
    })
  }

  sendMessage(message, userId) {
    WebSocketService.ws.getWss('/').clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN && client.id === userId) {
        client.send(message);
      }
    })
  }
}