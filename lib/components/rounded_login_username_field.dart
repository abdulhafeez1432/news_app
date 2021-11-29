import 'package:flutter/material.dart';
import 'package:news_app/components/text_field_container.dart';
import 'package:news_app/constants.dart';

class RoundedLoginUsernameField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final String TextEditingController;
  final ValueChanged<String> onChanged;
  const RoundedLoginUsernameField({
    Key? key,
    required this.hintText,
    required this.TextEditingController,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RoundedLoginUsernameFieldState createState() => _RoundedLoginUsernameFieldState();
}

class _RoundedLoginUsernameFieldState extends State<RoundedLoginUsernameField> {
  TextEditingController controllerUsername = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        controller: controllerUsername,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
