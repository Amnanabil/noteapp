import 'package:flutter/material.dart';
import 'package:noteapp/core/constans/colors.dart';
import 'package:noteapp/core/shared/Custumtextfomfeild.dart';
import 'package:noteapp/core/shared/custumgeneralbutton.dart';
import 'package:noteapp/data/local_data_source.dart';
import 'package:noteapp/model/notemodel.dart';

class Addnotenew extends StatelessWidget {
  const Addnotenew({super.key, required this.onPressed});
 final Future<void> Function()
  onPressed; // ✅ دالة بدون معاملات وتعيد Future<void>

  static TextEditingController title = TextEditingController();
  static TextEditingController content = TextEditingController();
  static GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'New Note',
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
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          Notemodel note = Notemodel(
                            id: DateTime.now().toString(),
                            title: title.text,
                            content: content.text,
                            Date:
                                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                            Time:
                                '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
                          );
                          if (await LocalDataSource.addNote(note)) {
                            title.clear();
                            content.clear();
                            await onPressed();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('succces'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('failed'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      name: 'Add Note',
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
