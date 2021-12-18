import 'package:flutter/material.dart';
import 'package:meu_app/modules/login/login_page.dart';
import 'package:meu_app/modules/signup/repositories/signup_repository.dart';
import 'package:meu_app/modules/signup/repositories/signup_repository_impl.dart';
import 'package:meu_app/modules/signup/signup_controler.dart';
import 'package:meu_app/shared/services/app_database.dart';
import 'package:meu_app/shared/theme/app_theme.dart';
import 'package:meu_app/shared/widgets/button_widget/button_widget.dart';
import 'package:meu_app/shared/widgets/input_email/input_email.dart';
import 'package:meu_app/shared/widgets/input_password/input_password.dart';
import 'package:validatorless/validatorless.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

late final SignupControler signUpController;
final _scaffoldKey = GlobalKey<ScaffoldState>();

bool isLoading = false;

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    signUpController =
        SignupControler(SignupRepositoryImpl(AppDatabase.instance));
    signUpController.state.when(
        success: (value) => Navigator.pop(context),
        orElse: () {},
        error: (message, _) =>
            scaffoldKey.currentState!.showBottomSheet((context) => BottomSheet(
                onClosing: () {},
                builder: (context) => Text(
                      message,
                      style: AppTheme.textStyles.hint,
                    ))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: AppTheme.colors.background,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 57, right: 52, left: 52, bottom: 301),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 38,
                ),
                Text(
                  'Criando uma conta',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Mantenha seus gastos em dia',
                  style: AppTheme.textStyles.hint,
                ),
                SizedBox(
                  height: 38,
                ),
                Text(
                  'Nome',
                  style: AppTheme.textStyles.label,
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                    key: signUpController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputEmail(
                          onChanged: (value) {
                            signUpController.onChange(nome: value);
                          },
                          hint: 'Seu nome',
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.min(
                                2, 'Minimo de 2 letras para o nome'),
                          ]),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          'E-mail',
                          style: AppTheme.textStyles.label,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputEmail(
                            onChanged: (value) {
                              signUpController.onChange(email: value);
                            },
                            hint: 'Coloque aqui o seu email',
                            validator: Validatorless.multiple([
                              Validatorless.required('Campo obrigatório!'),
                              Validatorless.email('email inválido!')
                            ])),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          'Senha',
                          style: AppTheme.textStyles.label,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputPassword(
                          onChanged: (value) {
                            signUpController.onChange(password: value);
                          },
                          hintText: 'Ensira sua senha',
                          validator: Validatorless.multiple([
                            Validatorless.multiple([
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.min(6, 'Minimo de 6 caracteres!'),
                            ])
                          ]),
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                AnimatedBuilder(
                    animation: signUpController,
                    builder: (_, __) => signUpController.state.when(
                        loading: () =>
                            Center(child: CircularProgressIndicator()),
                        orElse: () => Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: ButtonWidget(
                                    text: 'Criar Conta',
                                    onpressed: () {
                                      signUpController.create();
                                    },
                                    primary: AppTheme.colors.primary,
                                    style: AppTheme
                                        .textStyles.buttonBackgroundColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Já tem uma conta? Faça Login!',
                                      style: AppTheme.textStyles.hint,
                                    ),
                                  ),
                                ),
                              ],
                            )))
              ],
            ),
          ),
        ));
  }
}
