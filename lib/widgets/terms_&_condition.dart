import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsCondtion extends StatefulWidget {
  const TermsCondtion({
    super.key,
  });

  @override
  State<TermsCondtion> createState() => _TermsCondtionState();
}

class _TermsCondtionState extends State<TermsCondtion> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Checkbox(
          value: isCheck,
          onChanged: (value) {
            if (value == true) {
              isCheck = false;
              setState(() {});
            } else {
              isCheck = true;
              setState(() {});
            }
            print("is check value $value");
          },
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "I agree with the ",
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: "terms & conditions",
                  style: TextStyle(
                      color: Color(0xffe1aba9),
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => print("Terms & Conditions tapped")),
            ],
          ),
        ),
      ],
    );
  }
}
