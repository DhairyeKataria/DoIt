import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ColoredButton({
    required this.text,
    required this.color,
    required this.elevate,
    required this.onTap,
  });

  final String text;
  final MaterialColor color;
  final bool elevate;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.shade100,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: color.shade300,
          ),
          boxShadow: [
            if (elevate)
              BoxShadow(
                color: color.shade800,
                offset: const Offset(1.0, 1.0), //(x,y)
                blurRadius: 2.0,
              ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22.0,
            color: color.shade900,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
