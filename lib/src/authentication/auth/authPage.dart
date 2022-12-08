import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ihdplm_new/src/authentication/screens/login.dart';
import 'package:ihdplm_new/src/authentication/screens/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen(onClickedLogin: toggle)
      : SignUpScreen(onClickedContinue: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
