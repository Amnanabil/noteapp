import 'dart:convert';

import 'package:noteapp/main.dart';
import 'package:noteapp/model/notemodel.dart';

class LocalDataSource {
  static String Cashed_Note = "";
  static Future<bool> addnote(Notemodel newNote) async {
    try {
      final notes = await getnotes();
      notes.add(newNote);
      saveallnotes(notes);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteNote(String id) async {
    try {
      List<Notemodel> notes = await getnotes();
      notes.removeWhere((element) => element.id == id);
      saveallnotes(notes);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatenote(Notemodel newNote, String id) async {
    try {
      List<Notemodel> notes = await getnotes();
      notes = notes.map<Notemodel>((e) => e.id == id ? newNote : e).toList();
      saveallnotes(notes);
      return true;
    } catch (e) {
      print('erroe $e');
      return false;
    }
  }

  static Future<List<Notemodel>> getnotes() {
    final JsonData = sharedprefernces!.getString(Cashed_Note);
    if (JsonData == null)
      return Future.value([]);
    else {
      List jsonTolist = jsonDecode(JsonData);
      return Future.value(
        jsonTolist
            .map<Notemodel>((jsonnote) => Notemodel.fromJson(jsonnote))
            .toList(),
      );
    }
  }

  static saveallnotes(List<Notemodel> notes) {
    final jsonNotes = jsonEncode(notes);
    sharedprefernces!.setString(Cashed_Note, jsonNotes);
  }
}
