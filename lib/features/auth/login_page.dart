import 'package:dev_connect/core/di/service_locator.dart';
import 'package:dev_connect/features/auth/controller/login_controller.dart';
import 'package:dev_connect/features/auth/store/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import 'package:dev_connect/core/routes/app_routes.dart';
import 'package:dev_connect/core/ui/components/dc_loading_button.dart';
import 'package:dev_connect/core/ui/components/dc_text_form_field.dart';
import 'package:dev_connect/core/ui/helpers/snackbar_helper.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController(text: "");
  final TextEditingController _passwordCtrl = TextEditingController(text: "");
  final LoginController _controller = locator<LoginController>();
  LoginStore get _store => _controller.store;
  ReactionDisposer? _errorDisposer;

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() => _store.setEmail(_emailCtrl.text));
    _passwordCtrl.addListener(() => _store.setPassword(_passwordCtrl.text));

    _errorDisposer = reaction<String?>(
      (_) => _store.errorMessage,
      (String? msg) {
        if (msg != null && msg.isNotEmpty) {
          SnackBarHelper.showError(context, msg);
          _store.clearError();
        }
      },
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _errorDisposer?.call();
    super.dispose();
  }

  Future<void> _submit() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      final bool success = await _controller.login();
      if (success && mounted) {
        context.go(AppRoutes.feed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Observer(builder: (_) {
                    return DCTextFormField(
                      controller: _emailCtrl,
                      label: 'Email',
                      hint: 'seu@exemplo.com',
                      keyboardType: TextInputType.emailAddress,
                      validator:
                          Validatorless.multiple(<FormFieldValidator<String>>[
                        Validatorless.required('Email é obrigatório'),
                        Validatorless.email('Email inválido'),
                      ]),
                    );
                  }),
                  const SizedBox(height: 12),
                  Observer(builder: (_) {
                    return DCTextFormField(
                      maxLines: 1,
                      controller: _passwordCtrl,
                      label: 'Senha',
                      obscureText: true,
                      validator:
                          Validatorless.multiple(<FormFieldValidator<String>>[
                        Validatorless.required('Senha é obrigatória'),
                        Validatorless.min(
                            6, 'Senha deve ter ao menos 6 caracteres'),
                      ]),
                    );
                  }),
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    return DCLoadingButton(
                      onPressed: _submit,
                      label: 'Entrar',
                      loading: _store.loading,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
