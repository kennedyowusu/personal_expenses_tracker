import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    super.key,
    this.isTextObscured,
    this.toggleVisibility,
    this.validator,
    required this.onChanged,
    required this.labelText,
    this.isTextObscuredInitially = true,
  });

  final String labelText;
  final bool? isTextObscured;
  final void Function()? toggleVisibility;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final bool isTextObscuredInitially;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool isTextObscured = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isTextObscured = widget.isTextObscuredInitially;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isTextObscured ?? isTextObscured,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: GestureDetector(
          onTap: widget.toggleVisibility ??
              () {
                setState(() {
                  isTextObscured = !isTextObscured;
                });
              },
          child: Icon(
            (widget.isTextObscured ?? isTextObscured)
                ? Icons.visibility_off
                : Icons.visibility,
          ),
        ),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
