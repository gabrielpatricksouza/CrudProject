import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustomized extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final String prefix;
  final String suffix;
  final Color fillColor;
  final Color enableColor;
  final Color shadowColor;
  final TextInputType keyboardType;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  final bool obscure;
  final bool autofocus;
  final bool readOnly;
  final IconData? icon;
  final GestureDetector? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const InputCustomized({Key? key,
    this.controller,
    this.fillColor = Colors.transparent,
    this.shadowColor = const Color(0x00ffffff),
    this.enableColor = const Color(0xff1a1919),
    this.hintText = "",
    this.obscure = false,
    this.autofocus = false,
    this.inputFormatters,
    this.hintStyle,
    this.suffixStyle,
    this.labelStyle,
    this.onChanged,
    this.prefix = "",
    this.suffix = "",
    this.labelText,
    this.icon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      obscureText: obscure,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              icon,
              color: const Color(0xFF6F35A5),
            )),
        suffixIcon: suffixIcon,
        contentPadding: suffixIcon == null
            ? const EdgeInsets.fromLTRB(18, 18, 12, 18)
            : const EdgeInsets.fromLTRB(0, 18, 0, 18),
        labelStyle: labelStyle,
        labelText: labelText,
        hintStyle: hintStyle,
        hintText: hintText,
        prefixText: prefix,
        suffixText: suffix,
        suffixStyle: suffixStyle,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(
            width: 1.18,
            color: Color(0xFF6F35A5),
          ),
        ),

        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide:
          BorderSide(width: 1.2, color: Color(0xFF6F35A5)), //Color(0xff1a1919)
        ),
      ),
      cursorColor: Theme.of(context).primaryColor,
    );
  }
}