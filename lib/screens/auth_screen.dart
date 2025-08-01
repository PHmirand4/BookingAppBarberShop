import 'package:barbearia_rei_du_corte/services/auth_service.dart';
import 'package:barbearia_rei_du_corte/utils/colors.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String _name = '';
  String _email = '';
  String _password = '';
  bool _isLogin = true;
  bool _isLoading = false;

  void _trySubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState?.save();
      setState(() => _isLoading = true);

      String? userId;
      if (_isLogin) {
        userId = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());
      } else {
        userId = await _authService.createUserWithEmailAndPassword(_name.trim(), _email.trim(), _password.trim());
      }

      if (userId == null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocorreu um erro. Verifique as suas credenciais.'),
            backgroundColor: Colors.red,
          ),
        );
      }

      if(mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/rdc.PNG', height: 120),
              const SizedBox(height: 20),
              Text(
                _isLogin ? 'Bem-vindo de volta!' : 'Crie a sua Conta',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (!_isLogin)
                          TextFormField(
                            key: const ValueKey('name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira o seu nome.';
                              }
                              return null;
                            },
                            onSaved: (value) => _name = value ?? '',
                            decoration: const InputDecoration(labelText: 'Nome Completo'),
                          ),
                        if (!_isLogin) const SizedBox(height: 12),
                        TextFormField(
                          key: const ValueKey('email'),
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'Por favor, insira um e-mail válido.';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value ?? '',
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'E-mail'),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          key: const ValueKey('password'),
                          validator: (value) {
                            if (value == null || value.length < 7) {
                              return 'A senha deve ter pelo menos 7 caracteres.';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value ?? '',
                          obscureText: true,
                          decoration: const InputDecoration(labelText: 'Senha'),
                        ),
                        const SizedBox(height: 30),
                        if (_isLoading)
                          const CircularProgressIndicator(color: AppColors.primary)
                        else
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: _trySubmit,
                            child: Text(_isLogin ? 'ENTRAR' : 'CADASTRAR'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (!_isLoading)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin ? 'Não tem uma conta? Cadastre-se' : 'Já tenho uma conta. Entrar',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
