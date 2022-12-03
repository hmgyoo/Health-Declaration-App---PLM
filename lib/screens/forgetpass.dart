import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ihdplm_new/screens/login.dart';
import 'package:ihdplm_new/screens/resetpass.dart';
import 'package:ihdplm_new/widgets/rep_textfiled.dart';
import 'package:line_icons/line_icons.dart';

import '../utils/constant.dart';

// Global key
// final _formKey = GlobalKey<FormState>();

// global variables & functions
TextEditingController _controllerPassword = TextEditingController();
TextEditingController _controllerEmail = TextEditingController();

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
          width: gWidth,
          height: gHeight,
          child: Column(
            children: [
              TopImage(),
              SizedBox(height: 5),
              ForgotText(),
              SizedBox(height: 20),
              MiddleText(),
              SizedBox(height: 30),
              EmailTextField(),
              SizedBox(height: 50),
              SubmitButton(),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

// Submit button
class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 200),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => ResetPasswordScreen(),
                transition: Transition.leftToRightWithFade);
          },
          child: Text("Submit"),
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

// Email text field
class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 600),
      child: RepTextFiled(
          icon: LineIcons.at,
          suficon: null,
          text: "Email ID / Mobile Number",
          controller: _controllerEmail),
    );
  }
}

// Middle text
class MiddleText extends StatelessWidget {
  const MiddleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 1000),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: gWidth,
        height: gHeight / 19,
        child: Text(
          "Don\'t worry, it happens. Please enter the email address or mobile number associated with your account.",
          style: TextStyle(
            color: textColor,
            height: 1.2,
            wordSpacing: 2,
          ),
        ),
      ),
    );
  }
}

// Forgot Text
class ForgotText extends StatelessWidget {
  const ForgotText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: 1400),
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 160),
        width: gWidth / 2,
        height: gHeight / 8,
        child: FittedBox(
          child: Text(
            "Forgot\nPassword?",
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
      delay: Duration(milliseconds: 1800),
      child: Container(
        width: gWidth,
        height: gHeight / 2.70,
        child: Image.asset("assets/images/Forgot password-amico.png"),
      ),
    );
  }
}
