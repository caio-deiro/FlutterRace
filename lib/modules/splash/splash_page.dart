import 'package:flutter/material.dart';
import 'package:meu_app/modules/login/login_page.dart';
import 'package:meu_app/shared/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4))
        .then((value) => Navigator.pushNamed(context, '/login'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
