import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef String? fieldValidator(String? data);

class MyDropDown extends StatelessWidget {
  Color? fillColor;
  Function(dynamic? value)? onChange;
  String? value;
  Color? borderColor;
  final Color? labelColor;
  final String? prefixIcon;
  final String? suffixIcon;
  List<String> items = [];
  final String? labelText;
  final String? hintText;
  final Color? hintColor;
  final double? leftPadding;
  final double? rightPadding;
  final fieldValidator? validator;

  MyDropDown(
      {this.fillColor,
        required this.onChange,
        required this.value,
        required this.items,
        this.borderColor,
        this.labelColor,
        this.prefixIcon,
        this.suffixIcon,
        this.labelText,
        this.hintText,
        this.hintColor,
        this.leftPadding,
        this.rightPadding,
        this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding ?? 0,
        right: rightPadding ?? 0,
      ),
      child: DropdownButtonFormField(
        dropdownColor: Colors.blue,
        icon: Icon(Icons.arrow_drop_down),
        isExpanded: true,
        validator: validator,
        onTap: () {
          print("on tap");
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black),
            prefixIcon: (prefixIcon != null)
                ? Padding(
              padding: EdgeInsets.all(20),
              child: SvgViewer(svgPath: prefixIcon!),
            )
                : null,
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: borderColor == null ? Colors.black : borderColor!),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.green),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.green),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.green),
            ),
            filled: true,
            fillColor: fillColor == null ? Colors.transparent : fillColor),
        onChanged: onChange,
        value: value,
        isDense: true,
        hint: Text(
          hintText ?? "",
          style: TextStyle(color: Colors.black),
        ),
        items: items.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SvgViewer extends StatelessWidget {
  final String svgPath;
  final double? height;
  final double? width;
  final Color? color;

  SvgViewer({required this.svgPath, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return SvgPicture.asset(
        svgPath,
        color: color ?? null,
        height: height,
      );
    } else if (width != null) {
      return SvgPicture.asset(
        svgPath,
        width: width,
      );
    } else {
      return SvgPicture.asset(svgPath);
    }
  }
}
