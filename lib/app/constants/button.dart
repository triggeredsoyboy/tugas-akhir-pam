import 'package:flutter/material.dart';
import 'colors.dart';
import 'size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, this.text, this.press}) : super(key: key);

  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: screenHeight(56),
      child: TextButton(
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: screenWidth(18),
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: kPrimaryColor,
        ),
      ),
    );
  }
}
