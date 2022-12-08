import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ihdplm_new/main.dart';
import 'package:ihdplm_new/src/authentication/screens/login.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ihdplm_new/src/authentication/auth/auth.dart';

import '../../utils/constant.dart';
import '../widgets/rep_textfiled.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickedContinue;

  const SignUpScreen({
    Key? key,
    required this.onClickedContinue,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? errorMessage = '';
  bool isLogin = true;
  final formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerStudentNo = TextEditingController();

  // Register (to import to sing up page later on)
  Future<void> createUserWithEmailAndPassword() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      // await Auth().createUserWithEmailAndPassword(
      //     email: _controllerEmail.text,
      //     password: _controllerPassword.text,
      //     name: _controllerName.text,
      //     mobile: _controllerMobile.text);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim());

      // add user details
      addUserDetails(_controllerEmail.text.trim(), _controllerName.text.trim(),
          _controllerStudentNo.text.trim(), _controllerMobile.text.trim());
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }

    // Navigator of context not working
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> addUserDetails(
      String email, String fullName, String studentNo, String mobile) async {
    await FirebaseFirestore.instance.collection('user').add({
      'Email ID': email,
      'Full Name': fullName,
      'Student No': studentNo,
      'Mobile': mobile,
    });
  }

  // Email field
  Widget _emailField(TextEditingController controller, IconData icon,
      Widget? suficon, String text) {
    return FadeInDown(
      delay: Duration(milliseconds: 2200),
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
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  // obscureText: true,
                  controller: controller,
                  readOnly: false,
                  cursorColor: Colors.black,
                  showCursor: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
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
      delay: Duration(milliseconds: 800),
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
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  controller: controller,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Enter min. of 6 characters.'
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Name field
  Widget _nameField(TextEditingController controller, IconData icon,
      Widget? suficon, String text) {
    return FadeInDown(
      delay: Duration(milliseconds: 1600),
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
                  textInputAction: TextInputAction.next,
                  // obscureText: true,
                  controller: controller,
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

  // Mobile field
  Widget _mobileField(TextEditingController controller, IconData icon,
      Widget? suficon, String text) {
    return FadeInDown(
      delay: Duration(milliseconds: 1200),
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
                  textInputAction: TextInputAction.next,
                  // obscureText: true,
                  controller: controller,
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

  // Student No field
  Widget _studentNoField(TextEditingController controller, IconData icon,
      Widget? suficon, String text) {
    return FadeInDown(
      delay: Duration(milliseconds: 1200),
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
                  textInputAction: TextInputAction.next,
                  // obscureText: true,
                  controller: controller,
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
    return Text(errorMessage == '' ? '' : 'Hmm ? $errorMessage');
  }

  // Login Button
  Widget _continueButton() {
    return FadeInDown(
      delay: Duration(milliseconds: 600),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {
            createUserWithEmailAndPassword();
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

  Widget _loginNow() {
    return FadeInDown(
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(
            top: 22,
          ),
          width: gWidth / 2,
          height: gHeight / 32,
          child: FittedBox(
            child: RichText(
              text: TextSpan(
                text: "Joined us before?",
                style: TextStyle(
                  color: textColor,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedContinue,
                    text: "   Login",
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
              key: formKey,
              child: Column(
                children: [
                  TopImage(),
                  SignUpText(),
                  SizedBox(height: 10),
                  _emailField(_controllerEmail, LineIcons.at, null, 'Email ID'),
                  SizedBox(height: 15),
                  _nameField(
                      _controllerName, LineIcons.user, null, 'Full Name'),
                  SizedBox(height: 15),
                  _studentNoField(_controllerStudentNo,
                      LineIcons.personEnteringBooth, null, 'Student ID No.'),
                  SizedBox(height: 15),
                  _mobileField(
                      _controllerMobile, LineIcons.phone, null, 'Mobile'),
                  SizedBox(height: 15),
                  _passwordField(_controllerPassword, LineIcons.alternateUnlock,
                      Icon(LineIcons.eyeSlash), 'Password'),
                  SizedBox(height: 15),
                  _errorMessage(),
                  SizedBox(height: 20),
                  BottomText(),
                  SizedBox(height: 15),
                  _continueButton(),
                  SizedBox(height: 25),
                  // LoginText(),
                  _loginNow(),
                ],
              ),
            ),
          ),
        ),
        // resizeToAvoidBottomInset: false,
      ),
    );
  }
}

// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         body: Container(
//           margin: EdgeInsets.all(15),
//           width: gWidth,
//           height: gHeight,
//           child: Column(
//             children: [
//               TopImage(),
//               SignUpText(),
//               SizedBox(height: 10),
//               EmailTextField(),
//               SizedBox(height: 15),
//               FullNameTextField(),
//               SizedBox(height: 15),
//               MobileTextField(),
//               SizedBox(height: 15),
//               PasswordTextField(),
//               SizedBox(height: 25),
//               BottomText(),
//               SizedBox(height: 20),
//               ContinueButton(),
//               SizedBox(height: 20),
//               LoginText(),
//             ],
//           ),
//         ),
//         resizeToAvoidBottomInset: false,
//       ),
//     );
//   }
// }

// Login text
// class LoginText extends StatelessWidget {
//   const LoginText({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // var widget;
//     return FadeInDown(
//       child: GestureDetector(
//         // onTap: () {
//         //   Get.offAll(() => LoginScreen(),
//         //       transition: Transition.leftToRightWithFade);
//         // },
//         child: Container(
//           margin: EdgeInsets.only(
//             top: 22,
//           ),
//           width: gWidth / 2,
//           height: gHeight / 32,
//           child: FittedBox(
//             child: RichText(
//               text: TextSpan(
//                 text: "Joined us before?",
//                 style: TextStyle(
//                   color: textColor,
//                 ),
//                 children: [
//                   TextSpan(
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = widget.onClickedContinue,
//                     text: "   Login",
//                     style: TextStyle(
//                       color: buttonColor,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Continue button
class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 400),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {
            // Get.offAll(SignUpScreen());
          },
          child: Text("Continue"),
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
}

// Bottom text
class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 800),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: gWidth,
        height: gHeight / 21,
        child: RichText(
          text: TextSpan(
            text: "By signing up, you are agreeing to our",
            style: TextStyle(
              color: Color.fromARGB(255, 90, 90, 90),
            ),
            children: [
              TextSpan(
                text: " Terms & Conditions",
                style: TextStyle(
                  color: Color.fromARGB(255, 118, 186, 153),
                ),
              ),
              TextSpan(
                text: " and ",
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 90, 90),
                ),
              ),
              TextSpan(
                text: "Privacy Policy",
                style: TextStyle(
                  color: Color.fromARGB(255, 118, 186, 153),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// // Password text field
// class PasswordTextField extends StatelessWidget {
//   const PasswordTextField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FadeInDown(
//       delay: Duration(milliseconds: 800),
//       child: RepTextFiled(
//           icon: LineIcons.alternateUnlock,
//           suficon: Icon(LineIcons.eyeSlash),
//           text: "Password",
//           controller: _controllerPassword),
//     );
//   }
// }

// // Mobile Text field
// class MobileTextField extends StatelessWidget {
//   const MobileTextField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FadeInDown(
//         delay: Duration(milliseconds: 1200),
//         child: RepTextFiled(
//           icon: LineIcons.phone,
//           suficon: null,
//           text: "Mobile",
//           controller: _controllerMobile,
//         ));
//   }
// }

// // Full name text field
// class FullNameTextField extends StatelessWidget {
//   const FullNameTextField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FadeInDown(
//         delay: Duration(milliseconds: 1400),
//         child: RepTextFiled(
//           icon: LineIcons.user,
//           suficon: null,
//           text: "Full Name",
//           controller: _controllerName,
//         ));
//   }
// }

// // Email text field
// class EmailTextField extends StatelessWidget {
//   const EmailTextField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FadeInDown(
//       delay: Duration(milliseconds: 1600),
//       child: RepTextFiled(
//           icon: LineIcons.at,
//           suficon: null,
//           text: "Email ID",
//           controller: _controllerEmail),
//     );
//   }
// }

// Sign Button
class SignUpText extends StatelessWidget {
  const SignUpText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: 2100),
      child: Container(
        margin: EdgeInsets.only(top: 7, right: 250),
        width: gWidth / 3.5,
        height: gHeight / 17,
        child: FittedBox(
          child: Text(
            "Sign Up",
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
      delay: Duration(milliseconds: 2500),
      child: Container(
        width: gWidth,
        height: gHeight / 3.25,
        child: Image.asset("assets/images/Forms-pana.png"),
      ),
    );
  }
}
