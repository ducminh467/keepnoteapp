import 'package:flutter/material.dart';
class RoundeButton extends StatelessWidget{
  RoundeButton({this.title, this.color, this.onPressed});
  final Color? color;
  final String? title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Material(
          elevation: 5.0,
          color: color,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: onPressed!,
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              title!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
    );
  }
}