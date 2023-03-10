import 'package:flutter/material.dart';

import '../../constants.dart';
import 'agr_keyboard_visibile_builder.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.enable = true,
    this.initialValue = '',
  });

  final bool enable;
  final String initialValue;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController? _cnt;
  FocusNode? _textFieldFocusNode;

  @override
  void initState() {
    _cnt = TextEditingController();
    _cnt!.text = widget.initialValue;
    _textFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AgrKeyboardVisibileBuilder(builder: (context, isKeyboardVisible) {
      return TextFormField(
        controller: _cnt,
        focusNode: _textFieldFocusNode,
        enabled: widget.enable,
        onTap: () {},
        onChanged: (String inputText) {},
        decoration: InputDecoration(
          filled: !widget.enable,
          fillColor: Colors.grey.shade200,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kBackgroundColor)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: kBackgroundColor)),
        ),
      );
    });
  }
}
