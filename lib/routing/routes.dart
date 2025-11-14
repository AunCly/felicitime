class Routes {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const noConnection = '/no-connection';
  static const update = '/update';
  static const profile = '/profile';
  static const accountConfirmation = '/api/email/confirm';
  static const passwordReset = '/reset-password';
  static const passwordResetSend = '/send-reset-password';
  static const loading = '/loading';
  static const games = '/games';
  static const newGame = '/games/create';
  static const gameDetails = '/games/:uuid';
  static const gameQuestions = '/games/:uuid/questions';
  static const gameParties = '/games/:uuid/parties';
  static const gamePartyCreate = '/games/:uuid/parties/create';
  static const parties = '/parties';
  static const party = '/parties/:id';
  static const myGames = '/me/games';
}