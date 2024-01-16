import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommnetCard extends StatefulWidget {
  final snap;
  const CommnetCard({super.key, required this.snap});

  @override
  State<CommnetCard> createState() => _CommnetCardState();
}

class _CommnetCardState extends State<CommnetCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.snap['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "  ${widget.snap['text']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Spacer(),
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   child: const Icon(
          //     Icons.favorite_border,
          //     size: 16,
          //   ),
          // )
        ],
      ),
    );
  }
}
