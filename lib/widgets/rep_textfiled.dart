import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ihdplm_new/auth/validator.dart';
import 'package:ihdplm_new/utils/constant.dart';
import 'package:ihdplm_new/auth/auth.dart';

class RepTextFiled extends StatelessWidget {
  final IconData icon;
  final Widget? suficon;
  final String text;
  final myController = TextEditingController();
  final myValidator = Validator();
  TextEditingController controller;
  // String input;
  // Validator validator;

  RepTextFiled({
    required this.icon,
    required this.suficon,
    required this.text,
    required this.controller,
    // required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  labelText: text,
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
    );
  }
}
