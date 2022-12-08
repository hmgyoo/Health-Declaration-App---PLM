import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ihdplm_new/src/authentication/auth/validator.dart';
import 'package:ihdplm_new/src/authentication/screens/forgetpass.dart';
import 'package:ihdplm_new/src/authentication/screens/signup.dart';
import 'package:ihdplm_new/src/utils/constant.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ihdplm_new/src/authentication/widgets/rep_textfiled.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ihdplm_new/src/authentication/auth/auth.dart';
import 'package:ihdplm_new/main.dart';
import 'package:ihdplm_new/src/dashboard/screens/reminders.dart';

// Global key
// final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const LoginScreen({
    Key? key,
    required this.onClickedLogin,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  // // controllers
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();

  // Sign in
  Future<void> signInWithEmailAndPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      // await Auth().signInWithEmailAndPassword(
      //     email: _controllerEmail.text, password: _controllerPassword.text);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }

    // Navigator of context not working
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // Register (to import to sing up page later on)
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
          name: _controllerName.text,
          mobile: _controllerMobile.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Email field
  Widget _emailField(TextEditingController controller, IconData icon,
      Widget? suficon, String text) {
    return FadeInDown(
      delay: Duration(milliseconds: 2900),
      child: Container(
        width: double.infinity,
        height: gHeight / 15,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 50,
                width: gWidth / 1.3,
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.next,
                  readOnly: false,
                  cursorColor: Colors.black,
                  showCursor: true,
                  decoration: InputDecoration(
                    suffixIcon: suficon,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    hintText: text,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Password field
  Widget _passwordField(TextEditingController controller, IconData icon,
      Widget? suficon, String text) {
    return FadeInDown(
      delay: Duration(milliseconds: 2300),
      child: Container(
        width: double.infinity,
        height: gHeight / 15,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 50,
                width: gWidth / 1.3,
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  readOnly: false,
                  cursorColor: Colors.black,
                  showCursor: true,
                  decoration: InputDecoration(
                    suffixIcon: suficon,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    hintText: text,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // error message
  Widget _errorMessage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Text(errorMessage == '' ? '' : 'Hmm ? $errorMessage',
          style: TextStyle(
              color: Colors.red, fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }

  // Login Button
  Widget _loginButton() {
    return FadeInDown(
      delay: Duration(milliseconds: 1400),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {
            signInWithEmailAndPassword();
          },
          child: Text("Login"),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
              Color(0xff1C6758),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerNow() {
    return FadeInDown(
      child: Container(
        margin: EdgeInsets.only(
          top: 22,
        ),
        width: gWidth / 2,
        height: gHeight / 32,
        child: FittedBox(
          child: RichText(
            text: TextSpan(
              text: "Are you new here?",
              style: TextStyle(
                color: textColor,
              ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedLogin,
                  text: "   Register",
                  style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            width: gWidth,
            // height: gHeight,
            child: Form(
              child: Column(
                children: [
                  TopImage(),
                  LoginText(),
                  SizedBox(height: 20),
                  _emailField(_controllerEmail, LineIcons.at, null, 'Email ID'),
                  SizedBox(height: 20),
                  _passwordField(_controllerPassword, LineIcons.alternateUnlock,
                      Icon(LineIcons.eyeSlash), 'Password'),
                  SizedBox(height: 10),
                  _errorMessage(),
                  ForgotText(),
                  SizedBox(height: 15),
                  _loginButton(),
                  SizedBox(height: 15),
                  OrText(),
                  SizedBox(height: 15),
                  GoogleLoginButton(),
                  // RegisterText(),
                  _registerNow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         body: FutureBuilder(
//           future: _initializeFirebase(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Container(
//                 margin: EdgeInsets.all(15),
//                 width: gWidth,
//                 height: gHeight,
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TopImage(),
//                       LoginText(),
//                       SizedBox(height: 20),
//                       // EmailTextField(),
//                       TextFormField(
//                         controller: _emailTextController,
//                         focusNode: _focusEmail,
//                         validator: (value) =>
//                             Validator.validateEmail(email: value),
//                       ),
//                       SizedBox(height: 20),
//                       PasswordTextField(),
//                       ForgotText(),
//                       SizedBox(height: 15),
//                       LoginButton(),
//                       SizedBox(height: 15),
//                       OrText(),
//                       SizedBox(height: 15),
//                       GoogleLoginButton(),
//                       RegisterText(),
//                     ],
//                   ),
//                 ),
//               );
//             }
//             return Center(child: CircularProgressIndicator());
//           },
//         ),
//         resizeToAvoidBottomInset: false,
//       ),
//     );
//   }
// }

// // Register text
// class RegisterText extends StatelessWidget {
//   const RegisterText({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // var widget;
//     return FadeInDown(
//       child: Container(
//         margin: EdgeInsets.only(
//           top: 22,
//         ),
//         width: gWidth / 2,
//         height: gHeight / 32,
//         child: FittedBox(
//           child: RichText(
//             text: TextSpan(
//               text: "Are you new here?",
//               style: TextStyle(
//                 color: textColor,
//               ),
//               children: [
//                 TextSpan(
//                   recognizer: TapGestureRecognizer()..onTap = () =>  onClickedLogin,
//                   text: "   Register",
//                   style: TextStyle(
//                     color: buttonColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Google Login Button
class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 600),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 30,
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: Image.network(
                    "https://cdn.dribbble.com/users/1822162/screenshots/9854717/media/66970c682f9cb3f62d382b9ee511416c.gif"),
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                "Login with Google",
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 90, 90),
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              buttonColor.withOpacity(0.2),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }
}

// Or text
class OrText extends StatelessWidget {
  const OrText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 1000),
      child: Container(
        width: gWidth,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 130,
                height: 0.5,
                color: iconColor,
              ),
              Text(
                "     OR    ",
                style: TextStyle(color: iconColor, fontSize: 20),
              ),
              Container(
                width: 130,
                height: 0.5,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// // Login button
// class LoginButton extends StatelessWidget {
//   const LoginButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FadeInDown(
//       delay: Duration(milliseconds: 1400),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 5),
//         width: gWidth,
//         height: gHeight / 15,
//         child: ElevatedButton(
//           onPressed: () {},
//           child: Text("Login"),
//           style: ButtonStyle(
//             backgroundColor: MaterialStatePropertyAll<Color>(
//               Color(0xff1C6758),
//             ),
//             shape: MaterialStateProperty.all(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Forgot text
class ForgotText extends StatelessWidget {
  const ForgotText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 1800),
      child: GestureDetector(
        onTap: () {
          Get.offAll(() => ForgetPasswordScreen(),
              transition: Transition.leftToRightWithFade);
        },
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 240),
          width: gWidth / 3.7,
          height: gHeight / 32,
          child: FittedBox(
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                color: buttonColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// // Password text field
// class PasswordTextField extends StatelessWidget {
//   PasswordTextField({
//     Key? key,
//   }) : super(key: key);

//   // create login screen
//   LoginScreen loginScreen = LoginScreen();

//   @override
//   Widget build(BuildContext context) {
//     // controller
//     // TextEditingController _controllerPassword = TextEditingController();

//     return FadeInDown(
//       delay: Duration(milliseconds: 2300),
//       child: RepTextFiled(
//         icon: LineIcons.alternateUnlock,
//         suficon: Icon(LineIcons.eyeSlash),
//         text: "Password",
//         controller: loginScreen._controllerPassword,
//       ),
//     );
//   }
// }

// // Email text field
// class EmailTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final FormFieldValidator<String> validator;

//   EmailTextField({
//     Key? key,
//     required this.controller,
//     required this.validator,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // controller
//     // TextEditingController _controllerEmail = TextEditingController();

//     return FadeInDown(
//         delay: Duration(milliseconds: 2900),
//         // key: _formKey,
//         child: RepTextFiled(
//           icon: LineIcons.at,
//           suficon: null,
//           text: "Email ID",
//           controller: controller,
//           validator: (str) {},
//         ));
//   }
// }

// Login Text
class LoginText extends StatelessWidget {
  const LoginText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: 3200),
      child: Container(
        margin: EdgeInsets.only(top: 7, right: 270),
        width: gWidth / 4,
        height: gHeight / 18,
        child: FittedBox(
          child: Text(
            "Login",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// Top Image
class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 3800),
      child: Container(
        width: gWidth,
        height: gHeight / 3.20,
        child: Image.asset("assets/images/Computer login-bro.png"),
      ),
    );
  }
}
