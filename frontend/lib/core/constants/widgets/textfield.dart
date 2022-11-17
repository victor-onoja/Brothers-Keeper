import 'package:brothers_keeper/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String text;
  const AppTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: text,
        labelStyle: Theme.of(context).textTheme.subtitle1,
        floatingLabelStyle: Theme.of(context).textTheme.subtitle1,
        fillColor: AppColors.green.shade50,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
