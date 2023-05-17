
import 'package:flutter/material.dart';
import '../utils/style_management.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  int inputType;
  TextFieldWidget({Key? key, required this.controller, required this.hintText, required this.inputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(color: const Color(0xFFB2BAFF)),
      ),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        controller: controller,
        keyboardType: inputType == 1 ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: StyleManagement.testStyleGrey14,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'You can\'t pass empty data';
          }
          return null;
        },
        autofocus: false,
      ),
    );
  }
}
