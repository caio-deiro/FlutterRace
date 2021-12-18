import 'package:flutter/material.dart';
import 'package:meu_app/shared/theme/app_theme.dart';

class ChartHorizontal extends StatelessWidget {
  const ChartHorizontal({
    Key? key,
    required this.percent,
  }) : super(key: key);

  final double percent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Colors.red,
                Colors.green
              ], stops: [
                percent,
                0.0,
              ])),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (percent > 0 && percent <= 1)
                  Text(
                    "${(percent * 100).ceil()}%",
                    style: AppTheme.textStyles.chart,
                  ),
                if (percent >= 0 && percent <= 1)
                  Text(
                    "${((1 - percent) * 100).ceil()}%",
                    style: AppTheme.textStyles.chart,
                  )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          "Relação de compras caras e boas compras",
          style: AppTheme.textStyles.hint,
        ),
        SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppTheme.colors.badColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Ruim",
                  style: AppTheme.textStyles.hint,
                ),
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppTheme.colors.primary,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Bom",
                  style: AppTheme.textStyles.hint,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
