import jwt from 'jsonwebtoken';

export function authMiddelware(req, res, next) {
  if (req.path == '/login') return next();

  const token = req.headers.authorization;

  if (!token) {
    return res.send({
      message: 'Token is missing'
    });
  }

  try {
    const userData = jwt.verify(token, 'my_top_secret_key');
    if (userData.exp < Math.round(Date.now() / 1000)) {
      return res.send({
        message: 'Token has expired'
      });
    }
    req.userData = userData;
    next();
  } catch (e) {
    return res.send({
      message: 'Something wrong with the token'
    });
  }
}