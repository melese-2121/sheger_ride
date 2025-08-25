import '../models/user_model.dart';

class AuthController {
  Future<bool> login(UserModel user) async {
    // Example fake login logic
    if (user.email == "test@test.com" && user.password == "123456") {
      return true;
    }
    return false;
  }

  Future<bool> signup(UserModel user) async {
    // Example fake signup logic
    return true;
  }
}
