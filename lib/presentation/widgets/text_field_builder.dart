import 'package:flutter/material.dart';
import '../../constants/color.dart';

class TextFieldBuilder extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hint;
  IconData? iconData;
  TextFieldBuilder(
      {Key? key,
      required this.hint,
      required this.label,
      required this.controller,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: ColorConst.base),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(width: 1, color: ColorConst.base)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(width: 1, color: ColorConst.base)),
          label: Text(label),
          labelStyle: TextStyle(color: ColorConst.base, fontFamily: 'F'),
          hintText: hint,
          hintStyle: TextStyle(color: ColorConst.base, fontFamily: 'F')),
      style: const TextStyle(fontFamily: 'F', color: Colors.white),
      cursorColor: Colors.white,
    );
  }
}

class ObscureTextFieldBuilder extends StatefulWidget {
  bool obscureText;
  TextEditingController controller;
  Widget icon;
  String label;
  String hint;
  IconData? iconData;
  ObscureTextFieldBuilder(
      {Key? key,
      required this.controller,
      required this.obscureText,
      required this.icon,
      required this.label,
      required this.hint,
      required this.iconData})
      : super(key: key);

  @override
  State<ObscureTextFieldBuilder> createState() =>
      _ObscureTextFieldBuilderState();
}

class _ObscureTextFieldBuilderState extends State<ObscureTextFieldBuilder> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: Icon(widget.iconData, color: ColorConst.base),
          suffixIcon: IconButton(
            color: ColorConst.base,
            onPressed: () {
              setState(() {});
              widget.obscureText = !widget.obscureText;
              if (widget.obscureText == true) {
                widget.icon = const Icon(Icons.visibility_off_outlined);
              } else {
                widget.icon = const Icon(Icons.visibility_outlined);
              }
            },
            icon: widget.icon,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(width: 1, color: ColorConst.base)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(width: 1, color: ColorConst.base)),
          label: Text(widget.label),
          labelStyle: TextStyle(color: ColorConst.base),
          hintText: widget.hint,
          hintStyle: TextStyle(color: ColorConst.base)),
      style: const TextStyle(fontFamily: 'F', color: Colors.white),
    );
  }
}
