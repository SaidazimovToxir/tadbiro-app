import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final String? Function(String?) validator;
  final TextEditingController textEditingController;
  final bool? isMaxLines;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.isObscure,
    required this.validator,
    required this.textEditingController,
    this.isMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: isMaxLines == null ? 1 : null,
      // maxLines: null,
      obscureText: isObscure,
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 3,
            ),
          ),
          hintStyle: const TextStyle(color: Colors.black, fontSize: 17)),
    );
  }
}
