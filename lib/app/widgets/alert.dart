import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

alertDialog(context, AlertType type, String title, String text) {
  Alert(
    context: context,
    type: AlertType.none,
    title: title,
    desc: text,
    style: const AlertStyle(
      backgroundColor: Color(0xFFF1E6FF),
      titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      descStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    buttons: [
      DialogButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        width: 120,
        color: const Color(0xFF6F35A5),
        child: const Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
      )
    ],
  ).show();
}
