import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final bool disabled;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    this.title,
    required this.controller,
    this.disabled = false,
    this.textInputAction,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: !disabled,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: title,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
