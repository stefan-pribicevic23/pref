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
    req.userData = jwt.decode(token);
    next();
  } catch {
    return res.send({
      message: 'Something wrong with the token'
    });
  }
}