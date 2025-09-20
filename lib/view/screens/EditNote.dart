import 'package:flutter/material.dart';
import 'package:noteapp/core/constans/colors.dart';
import 'package:noteapp/core/shared/Custumtextfomfeild.dart';
import 'package:noteapp/core/shared/custumgeneralbutton.dart';
import 'package:noteapp/model/notemodel.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key, required this.onPressed, required this.note});
  final Notemodel note;
  final Function onPressed;
  static GlobalKey<FormState> formkey = GlobalKey();

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title.text = widget.note.title;
    content.text = widget.note.content;
    super.initState();
  }

  Widget build(BuildContext context) {
    title.text = widget.note.title;
    content.text = widget.note.content;
    return Form(
      key: EditNote.formkey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'ُEdit Note',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: 20),

              // مربع نص صغير
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Custumtextfomfeild(
                      controller: title,
                      name: 'Title',
                      num: 1,
                    ),

                    SizedBox(height: 10),
                    Custumtextfomfeild(
                      controller: content,
                      name: 'content',
                      num: 5,
                    ),
                    SizedBox(height: 10),
                    custumGenralButton(
                      onPressed: () {
                        if (EditNote.formkey.currentState!.validate()) {}
                        widget.onPressed(title.text, content.text);
                        Navigator.pop(context);
                        title.clear();
                        content.clear();
                      },
                      name: 'Edit Note',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
