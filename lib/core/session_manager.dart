import 'package:assignment2_mobileapp_prototype/service/model/user.dart';

class SessionManager {
  SessionManager._();

  static final SessionManager _instance = SessionManager._();

  static SessionManager get instance => _instance;

  User? _user;

  Future<void> saveUserSession(User userData) async {
    _user = userData;
  }

  User? getUserSession() => _user;

  Future<void> clearSession() async {
    _user = null;
  }
}
