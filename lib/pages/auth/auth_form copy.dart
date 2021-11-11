import 'package:coder_shop/exceptions/auth_exception.dart';
import 'package:coder_shop/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with TickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.Login;

  AnimationController? _animationController;
  Animation<Size>? _heightAnimation;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _heightAnimation = Tween(
            begin: Size(double.infinity, 310), end: Size(double.infinity, 400))
        .animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.linear),
    );

    _heightAnimation?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  void _showDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um problema'),
        content: Text(msg),
      ),
    );
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
        _animationController?.forward();
      } else {
        _authMode = AuthMode.Login;
        _animationController?.reverse();
      }
    });
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.login(_authData['email']!, _authData['password']!);
      } else {
        await auth.signup(_authData['email']!, _authData['password']!);
      }
    } on AuthException catch (error) {
      _showDialog(error.toString());
    } catch (e) {
      _showDialog('Ocorreu um erro inesperado');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: AnimatedBuilder(
          animation: _heightAnimation!,
          builder: (ctx, childForm) => Container(
              padding: const EdgeInsets.all(16),
              // height: _isLogin() ? 310 : 400,
              height:
                  _heightAnimation?.value.height ?? (_isLogin() ? 310 : 400),
              width: deviceSize.width * 0.75,
              child: childForm),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Informe um e-mail válido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(labelText: 'Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.isEmpty || password.length < 5) {
                      return 'Informe uma senha válida';
                    }
                    return null;
                  },
                ),
                if (_isSignup())
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(labelText: 'Confirmar Senha'),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: _isLogin()
                        ? null
                        : (_password) {
                            final password = _password ?? '';
                            if (password != _passwordController.text) {
                              return 'Senhas informadas não conferem.';
                            }
                            return null;
                          },
                  ),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                      _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                    ),
                  ),
                Spacer(),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    _isLogin() ? 'DESEJA REGISTRAR?' : 'JÁ POSSUI CONTA?',
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
