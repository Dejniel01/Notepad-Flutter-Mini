import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/note_details/note_details.dart';

class NoteTile extends StatefulWidget {
  const NoteTile(
      {super.key,
      required this.note,
      required this.crossAxisCount,
      required this.isExpanded,
      required this.user});

  final bool isExpanded;
  final Note note;
  final User user;
  final int crossAxisCount;

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NoteDetails(user: widget.user, note: widget.note),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Colors.lightBlueAccent,
                  Colors.lightBlue,
                  Colors.lightBlueAccent,
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            width: MediaQuery.of(context).size.width / widget.crossAxisCount,
            height: widget.isExpanded
                ? MediaQuery.of(context).size.width /
                        widget.crossAxisCount *
                        4 /
                        3 +
                    16
                : MediaQuery.of(context).size.width /
                    widget.crossAxisCount *
                    2 /
                    3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.note.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.note.isPriority = !widget.note.isPriority;
                          });
                        },
                        child: widget.note.isPriority
                            ? const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            : const Icon(
                                Icons.star_border,
                                color: Colors.yellow,
                              ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.note.content,
                      maxLines: widget.isExpanded ? 11 : 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
