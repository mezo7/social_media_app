import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/color.dart';


Widget myDivaider(context) => Container(
  width: double.infinity,
  height: 5.0,
  color: Theme.of(context).secondaryHeaderColor,
);

Widget defualtTextFormField({
  required controller,
  required TextInputType type,
  required FormFieldValidator validate,
  required String label,
  required IconData prefixIcon,
  IconButton? suffixIcon,
  bool isPassword = false,
  Function? suffixPressed,
  Function()? onTap,
  ValueChanged<String>? onChange,
  ValueChanged<String>? onSubmit,
  bool isClicked = true,
  required BuildContext context,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        hoverColor: Theme.of(context).primaryColor,
        labelText: label,
        labelStyle: TextStyle(
            color:Theme.of(context).primaryColor,
          fontSize: 14.0,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).highlightColor,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).highlightColor,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).secondaryHeaderColor,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).highlightColor,
        ),
        suffixIcon: suffixIcon,
      ),
      style: TextStyle(
        fontSize: 17.0,
      ),
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      enabled: isClicked,
      onFieldSubmitted: onSubmit,
    );

Widget defualtButton({
  double width = double.infinity,
  Color background = defualtColor,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: background,
      ),
      child: MaterialButton(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white,
          fontSize: 13),
        ),
        onPressed: function,

      ),
    );

Widget defualtTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
        onPressed:(){
          showShortToast(text: 'text', state: ToastStates.WARNING);
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: defualtColor,
          ),
        ));



void navigateTo(context, wedgit) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => wedgit,
    ));

void navigateAndFinish(context, wedgit) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => wedgit,
      ),
      (Route<dynamic> route) => false,
    );

void showLongToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

void showShortToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color ToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = defualtColor;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
