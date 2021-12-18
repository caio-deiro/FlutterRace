import 'package:flutter/material.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
import 'package:meu_app/shared/theme/app_theme.dart';

class InputEmail extends StatelessWidget {
  final String? Function(String?) validator;
  final String? hint;
  final Widget? label;
  final TextInputType? keyboard;
  final Function(String)? onChanged;
  final List<MaskInputFormatter>? inputFormatters;

  const InputEmail({
    Key? key,
    required this.validator,
    required this.hint,
    this.label,
    this.keyboard,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      keyboardType: keyboard,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        label: label,
        hintText: hint,
        hintStyle: AppTheme.textStyles.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
