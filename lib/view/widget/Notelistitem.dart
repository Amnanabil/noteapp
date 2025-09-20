import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noteapp/core/constans/colors.dart';
import 'package:noteapp/model/notemodel.dart';
import 'package:noteapp/view/screens/NoteView.dart';

class Notelistitem extends StatelessWidget {
  const Notelistitem({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onEdite,
  });
  final Notemodel note;
  final Function onDelete;
  final Function onEdite;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onDelete();
            },
            icon: Icons.delete,
            backgroundColor: Colors.transparent,
            foregroundColor: Appcolors.primary,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onEdite();
            },
            icon: Icons.edit,
            backgroundColor: Colors.transparent,
            foregroundColor: Appcolors.primary,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Appcolors.secondry,
        ),

        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Noteview(note: note)),
            );
          },
          title: Text(note.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity),
                  Text(note.content, maxLines: 1),
                ],
              ),
              SizedBox(height: 10),
              Text(note.Date + " " + note.Time),
            ],
          ),
        ),
      ),
    );
  }
}
