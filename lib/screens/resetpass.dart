import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ihdplm_new/controllers/submit_controller.dart';
import 'package:ihdplm_new/screens/forgetpass.dart';
import 'package:ihdplm_new/utils/constant.dart';
import 'package:ihdplm_new/widgets/rep_textfiled.dart';
import 'package:line_icons/line_icons.dart';

// Global key
// final _formKey = GlobalKey<FormState>();

// global variables & functions
TextEditingController _controllerPassword = TextEditingController();
// TextEditingController _controllerEmail = TextEditingController();

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                Get.to(() => ForgetPasswordScreen(),
                    transition: Transition.fade);
                Get.find<SubmitController>().isSubmit.value = false;
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
              ResetPasswordText(),
              SizedBox(height: 20),
              NewPasswordTextField(),
              SizedBox(height: 20),
              ConfirmPasswordTextField(),
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
  //
  var _submitController = Get.find<SubmitController>();

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 200),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: gWidth,
        height: gHeight / 15,
        child: GetBuilder<SubmitController>(builder: (_submitController) {
          return ElevatedButton(
            onPressed: () {
              _submitController.submiting();
            },
            child: _submitController.isSubmit == false
                ? Text("Submit")
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CupertinoActivityIndicator(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Submitting..."),
                    ],
                  ),
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
          );
        }),
      ),
    );
  }
}

// New Password text field
class NewPasswordTextField extends StatelessWidget {
  const NewPasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 800),
      child: RepTextFiled(
          icon: LineIcons.alternateUnlock,
          suficon: Icon(LineIcons.eyeSlash),
          text: "New Password",
          controller: _controllerPassword),
    );
  }
}

// Confirm Password text field
class ConfirmPasswordTextField extends StatelessWidget {
  const ConfirmPasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 1000),
      child: RepTextFiled(
          icon: LineIcons.alternateUnlock,
          suficon: Icon(LineIcons.eyeSlash),
          text: "Confirm New Password",
          controller: _controllerPassword),
    );
  }
}

// Reset Password Text
class ResetPasswordText extends StatelessWidget {
  const ResetPasswordText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: 1600),
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 160),
        width: gWidth / 2,
        height: gHeight / 8,
        child: FittedBox(
          child: Text(
            "Reset\nPassword",
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
      delay: Duration(milliseconds: 2000),
      child: Container(
        width: gWidth,
        height: gHeight / 2.70,
        child: Image.asset("assets/images/Key-rafiki.png"),
      ),
    );
  }
}
