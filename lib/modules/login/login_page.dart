import 'package:flutter/material.dart';
import 'package:meu_app/modules/login/login_controler.dart';
import 'package:meu_app/modules/login/repositories/login_repository.dart';
import 'package:meu_app/modules/login/repositories/login_repository_impl.dart';
import 'package:meu_app/shared/services/app_database.dart';
import 'package:meu_app/shared/theme/app_theme.dart';
import 'package:meu_app/shared/utills/app_state.dart';
import 'package:meu_app/shared/widgets/button_widget/button_widget.dart';
import 'package:meu_app/shared/widgets/input_email/input_email.dart';
import 'package:meu_app/shared/widgets/input_password/input_password.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();
late final LoginControler controler;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    controler = LoginControler(LoginRepositoryImpl(AppDatabase.instance));
    controler.addListener(() {
      controler.state.when(
        success: (value) =>
            Navigator.pushNamed(context, '/home', arguments: value),
        error: (message, _) =>
            scaffoldKey.currentState!.showBottomSheet((context) => BottomSheet(
                onClosing: () {},
                builder: (context) => Text(
                      message,
                      style: AppTheme.textStyles.hint,
                    ))),
        orElse: () {},
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppTheme.colors.background,
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 35, bottom: 159, left: 26, right: 29),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      width: 200,
                    ),
                    SizedBox(
                      height: 41,
                    ),
                    Form(
                        key: controler.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('E-mail').label,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputEmail(
                              onChanged: (value) {
                                controler.onChange(email: value);
                              },
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório!'),
                                Validatorless.email('email inválido!')
                              ]),
                              hint: 'Digite seu Email',
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('Senha').label,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputPassword(
                              onChanged: (value) {
                                controler.onChange(password: value);
                              },
                              validator: Validatorless.multiple([
                                Validatorless.multiple([
                                  Validatorless.required('Campo obrigatório'),
                                  Validatorless.min(
                                      6, 'Minimo de 6 caracteres!'),
                                ])
                              ]),
                              hintText: 'Insira sua senha',
                            )
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedBuilder(
                        animation: controler,
                        builder: (_, __) => controler.state.when(
                            loading: () => CircularProgressIndicator(),
                            orElse: () => Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ButtonWidget(
                                        primary: AppTheme.colors.primary,
                                        style: AppTheme
                                            .textStyles.buttonBackgroundColor,
                                        text: 'Entrar',
                                        onpressed: () {
                                          controler.login();
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 19),
                                        child: ButtonWidget(
                                          text: 'Criar uma conta',
                                          onpressed: () {
                                            Navigator.pushNamed(
                                                context, '/signup');
                                          },
                                          primary: AppTheme.colors.background,
                                          style: AppTheme
                                              .textStyles.buttonBoldTextColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<bool> onWillPop() async {
    final pop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Tem certeza'),
              content: Text('Quer sair do app?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('não')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Sim')),
              ],
            ));
    return pop ?? false;
  }
}
