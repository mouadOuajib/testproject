import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  final Color? fillColor;
  final Color? textColor;
  final String? text;
  final double? height;
  final double? width;
  final bool hasBorder;

  const DefaultContainer(
      {super.key,
      this.fillColor,
      this.hasBorder = false,
      this.height,
      this.text,
      this.textColor,
      this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      height: height ?? 30,
      width: width,
      decoration: BoxDecoration(
          color: fillColor ?? theme.primary,
          borderRadius: BorderRadius.circular(12),
          border: hasBorder ? Border.all(width: 1, color: Colors.black) : null),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text ?? "",
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
