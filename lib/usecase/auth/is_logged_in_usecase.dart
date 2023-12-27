import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IsLoggedInUseCase {
  final storage = FlutterSecureStorage();

  Future<bool> get isLoggedIn async {
    final jwt = await storage.read(key: 'jwt');
    return jwt != null && jwt.isNotEmpty;
  }
}
