import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

// ignore: library_private_types_in_public_api
class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool loading = false;

  @observable
  String? errorMessage;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setErrorMessage(String? message) => errorMessage = message;

  @action
  void clearError() => errorMessage = null;
}
