import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Function() onPressed;
  final Function(bool)? onHover;

  final String text;
  final Icon icon;
  final TextStyle? textStyle;
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.textStyle,
    this.onHover,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onHover: widget.onHover,
        onPressed: widget.onPressed,
        icon: Text(
          widget.text,
          style: widget.textStyle,
        ),
        label: widget.icon);
  }
}
