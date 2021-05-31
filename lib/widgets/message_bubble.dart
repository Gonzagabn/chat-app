import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key? key;
  final String message;
  final bool belongsToMe;

  MessageBubble(this.message, this.belongsToMe, {this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Theme.of(context).accentTextTheme.headline1!.color,
            ),
          ),
        ),
      ],
    );
  }
}
