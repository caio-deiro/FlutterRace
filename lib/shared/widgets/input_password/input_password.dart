import 'package:flutter/material.dart';
import 'package:meu_app/shared/theme/app_theme.dart';

class InputPassword extends StatefulWidget {
  final String hintText;

  final String? Function(String?) validator;
  final Function(String)? onChanged;

  const InputPassword({
    Key? key,
    required this.hintText,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: isVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: isVisible
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off)),
        labelText: 'Senha',
        hintText: 'Digite sua senha',
        hintStyle: AppTheme.textStyles.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
