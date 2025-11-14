import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppInputPassword extends StatefulWidget {
  const AppInputPassword({
    super.key, this.label,
    this.controller,
    this.validator,
  });

  final String? label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  State<AppInputPassword> createState() => _AppInputPasswordState();
}

class _AppInputPasswordState extends State<AppInputPassword> {

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            _passwordVisible ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      controller: widget.controller,
      obscureText: !_passwordVisible,
      validator: widget.validator,
    );
  }
}
