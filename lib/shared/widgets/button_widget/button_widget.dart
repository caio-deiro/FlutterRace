import 'package:flutter/material.dart';
import 'package:meu_app/shared/theme/app_theme.dart';

class ButtonWidget extends StatelessWidget {
  final BorderSide? borderSide;
  final String text;
  final void Function()? onpressed;
  final Color primary;
  final TextStyle style;
  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onpressed,
      required this.primary,
      required this.style,
      this.borderSide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: style,
      ),
      style: ElevatedButton.styleFrom(
          side: borderSide,
          fixedSize: Size(350, 57),
          primary: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
