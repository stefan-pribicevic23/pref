import jwt from 'jsonwebtoken';
import findByUsername from '../repo/user/findByUsername.mjs'

export default class UserService {
  login = async (username, password) => {
    const user = await findByUsername(username);
    if (!user) {
      throw new Error('No such user');
    }

    if (user.password !== password) {
      throw new Error('Incorrect password');
    }

    return jwt.sign({ username, id: user.id }, 'my_top_secret_key', { expiresIn: '30d' });
  }
}