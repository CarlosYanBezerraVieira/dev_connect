import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dev_connect/features/auth/store/login_store.dart';

class LoginController {
  final LoginStore store;
  LoginController({
    required this.store,
  });

  Future<bool> login() async {
    store.setLoading(true);
    store.clearError();

    await Future.delayed(const Duration(seconds: 1));

    final String defaultEmail = dotenv.env['DEFAULT_EMAIL'] ?? '';
    final String defaultPassword = dotenv.env['DEFAULT_PASSWORD'] ?? '';

    if (store.email == defaultEmail && store.password == defaultPassword) {
      store.setLoading(false);
      return true;
    } else {
      store.setErrorMessage('Credenciais inválidas.');
      store.setLoading(false);
      return false;
    }
  }
}
