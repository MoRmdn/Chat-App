import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  String message;
  MessageBubble({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: const StadiumBorder(side: BorderSide.none)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(message),
        )
      ],
    );
  }
}
