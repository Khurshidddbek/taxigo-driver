import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaxiButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;
  final TextStyle style;

  const TaxiButton({
    required this.title,
    required this.color,
    required this.onPressed,
    this.style = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: color,
      borderRadius: BorderRadius.circular(24),
      onPressed: () => onPressed(),
      child: SizedBox(
        height: 25,
        child: Center(
          child: Text(
            title,
            style: style,
          ),
        ),
      ),
    );
  }
}
