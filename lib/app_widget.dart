import 'package:flutter/material.dart';
import 'package:meu_app/modules/feed/feed_page.dart';
import 'package:meu_app/modules/login/login_page.dart';
import 'package:meu_app/modules/profile/profile_page.dart';
import 'package:meu_app/modules/signup/signup_page.dart';
import 'package:meu_app/modules/splash/splash_page.dart';
import 'package:meu_app/shared/models/user_model.dart';

import 'modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter race',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/splash',
      routes: {
        '/home': (context) => HomePage(pages: [
              FeedPage(),
              ProfilePage(),
            ], user: ModalRoute.of(context)!.settings.arguments as UserModel),
        '/splash': (context) => const SplashPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
