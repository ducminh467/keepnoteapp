// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? desc;

  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 24.0,
        ),
        margin: EdgeInsets.only(
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "Unnamed Task",
              style: TextStyle(
                color: Color(0xFFD95B07),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Text(
                desc ?? "No description added.",
                style: TextStyle(
                  color: Color(0xFF86829D),
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ));
  }
}

class TodoWidget extends StatelessWidget {
  String text;
  bool isDone;

  TodoWidget({this.text = 'Unnamed', this.isDone = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
                color: isDone ? Color(0xFFD95B07) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: isDone ? null : Border.all(color: Color(0xFF86829D))),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Image(
                image: AssetImage(
                    'lib/assets/images/check_icon.png',
                ),
              ),
            ),
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: isDone ? Color(0xFF512C15) : Color(0xFF86829D),
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}