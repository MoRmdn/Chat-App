import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageBubble extends StatelessWidget {
  String message;
  String userName;
  bool isME;
  String imageURL;

  MessageBubble({
    Key? key,
    required this.message,
    required this.isME,
    required this.userName,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isME ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 5,
        ),
        if (!isME)
          CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imageURL,
                fit: BoxFit.fitWidth,
              ),
            ),
            backgroundColor: Colors.grey,
          ),
        Container(
          width: 150,
          decoration: BoxDecoration(
              color: isME
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomLeft: isME
                      ? const Radius.circular(15)
                      : const Radius.circular(0),
                  bottomRight: !isME
                      ? const Radius.circular(15)
                      : const Radius.circular(0))),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment:
                isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        if (isME)
          CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imageURL,
                fit: BoxFit.fitWidth,
              ),
            ),
            backgroundColor: Colors.grey,
          ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }
}
