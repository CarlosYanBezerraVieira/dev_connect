import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import 'package:dev_connect/core/routes/app_routes.dart';
import 'package:dev_connect/core/ui/components/dc_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      context.go(AppRoutes.feed);
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
                  DCTextFormField(
                    controller: _emailCtrl,
                    label: 'Email',
                    hint: 'seu@exemplo.com',
                    keyboardType: TextInputType.emailAddress,
                    validator:
                        Validatorless.multiple(<FormFieldValidator<String>>[
                      Validatorless.required('Email é obrigatório'),
                      Validatorless.email('Email inválido'),
                    ]),
                  ),
                  const SizedBox(height: 12),
                  DCTextFormField(
                    controller: _passwordCtrl,
                    label: 'Senha',
                    obscureText: true,
                    validator:
                        Validatorless.multiple(<FormFieldValidator<String>>[
                      Validatorless.required('Senha é obrigatória'),
                      Validatorless.min(
                          6, 'Senha deve ter ao menos 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _submit,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10.0),
                          child: Text('Entrar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
