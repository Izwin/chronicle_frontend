import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  const DefaultButton(
      {super.key,
      this.text,
      this.backgroundColor,
      this.textColor,
      this.padding,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.resolveWith(
              (state) {
                if (state.contains(WidgetState.disabled)) {
                  return backgroundColor?.withOpacity(0.5);
                } else {
                  return backgroundColor;
                }
              },
            ),
            foregroundColor: WidgetStateProperty.resolveWith((state) {
              if (state.contains(WidgetState.disabled)) {
                return textColor?.withOpacity(0.5);
              } else {
                return textColor;
              }
            }),
            padding: WidgetStatePropertyAll(padding)),
        child: Text(text ?? ''),
      ),
    );
  }
}
