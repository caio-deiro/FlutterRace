import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
import 'package:meu_app/modules/create/create_controller.dart';
import 'package:meu_app/modules/create/repositories/create_repository_impl.dart';
import 'package:meu_app/shared/services/app_database.dart';

import 'package:meu_app/shared/theme/app_theme.dart';
import 'package:meu_app/shared/widgets/button_widget/button_widget.dart';
import 'package:meu_app/shared/widgets/input_email/input_email.dart';

import 'package:validatorless/validatorless.dart';

class CreateBottomsheet extends StatefulWidget {
  const CreateBottomsheet({Key? key}) : super(key: key);

  @override
  State<CreateBottomsheet> createState() => _CreateBottomsheetState();
}

class _CreateBottomsheetState extends State<CreateBottomsheet> {
  late final CreateController controller;

  MaskInputFormatter dataFormatter = MaskInputFormatter(mask: '##/##/####');

  @override
  void initState() {
    controller = CreateController(
        repository: CreateRepositoryImpl(database: AppDatabase.instance));
    controller.addListener(() {
      controller.state.when(
          success: (_) {
            Navigator.pop(context);
          },
          orElse: () {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            InputEmail(
                label: Text("Produto"),
                hint: "Digite um nome",
                onChanged: (value) => controller.onChange(name: value),
                validator: Validatorless.multiple(
                    [Validatorless.required('Digite algum nome')])),
            SizedBox(
              height: 8,
            ),
            InputEmail(
              label: Text("Preço"),
              hint: "Digite o valor",
              onChanged: (value) => controller.onChange(price: value),
              keyboard: TextInputType.number,
              validator: Validatorless.multiple([
                Validatorless.required('Digite um valor'),
                Validatorless.number('Digite apenas numeros'),
              ]),
            ),
            SizedBox(
              height: 8,
            ),
            InputEmail(
                keyboard: TextInputType.datetime,
                onChanged: (value) => controller.onChange(date: value),
                label: Text("Data da compra"),
                inputFormatters: [dataFormatter],
                validator: Validatorless.multiple([
                  Validatorless.required('Digite alguma data'),
                ]),
                hint: "Digite dd/mm/aa"),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedBuilder(
                animation: controller,
                builder: (_, __) => controller.state.when(
                    loading: () => CircularProgressIndicator(),
                    error: (message, _) => Text(message),
                    orElse: () => ButtonWidget(
                        primary: AppTheme.colors.primary,
                        style: AppTheme.textStyles.buttonBoldTextColor,
                        text: 'Adicionar',
                        onpressed: () {
                          controller.create();
                        })))
          ],
        ),
      ),
    );
  }
}
