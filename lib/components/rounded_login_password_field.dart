import 'package:flutter/material.dart';
import 'package:news_app/components/text_field_container.dart';
import 'package:news_app/constants.dart';

class RoundedLoginPasswordField extends StatefulWidget {


  final ValueChanged<String> onChanged;
  const RoundedLoginPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RoundedLoginPasswordFieldState createState() => _RoundedLoginPasswordFieldState();
}

class _RoundedLoginPasswordFieldState extends State<RoundedLoginPasswordField> {
  TextEditingController controllerLoginPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        controller:controllerLoginPassword ,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
