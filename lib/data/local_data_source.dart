import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noteapp/model/notemodel.dart';

class LocalDataSource {
  static SharedPreferences? sharedPreferences;

  // المفتاح المستخدم لتخزين البيانات
  static const String _cachedNoteKey = "Cashed_Note";

  /// تهيئة SharedPreferences (يجب استدعاؤها قبل أي عملية حفظ أو قراءة)
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// حفظ كل الملاحظات
  static Future<void> saveAllNotes(List<Notemodel> notes) async {
    final listToJson = notes.map((e) => e.toJson()).toList();
    final jsonNotes = jsonEncode(listToJson);
    await sharedPreferences!.setString(_cachedNoteKey, jsonNotes);
  }

  /// استرجاع كل الملاحظات
  static Future<List<Notemodel>> getNotes() async {
    final jsonData = sharedPreferences!.getString(_cachedNoteKey);
    if (jsonData == null) return [];
    final List decoded = jsonDecode(jsonData);
    return decoded.map<Notemodel>((e) => Notemodel.fromJson(e)).toList();
  }

  /// إضافة ملاحظة جديدة
  static Future<bool> addNote(Notemodel newNote) async {
    try {
      final notes = await getNotes();
      notes.add(newNote);
      await saveAllNotes(notes);
      return true;
    } catch (e) {
      print('Error adding note: $e');
      return false;
    }
  }

  /// حذف ملاحظة حسب المعرف
  static Future<bool> deleteNote(String id) async {
    try {
      final notes = await getNotes();
      notes.removeWhere((element) => element.id == id);
      await saveAllNotes(notes);
      return true;
    } catch (e) {
      print('Error deleting note: $e');
      return false;
    }
  }

  /// تعديل ملاحظة حسب المعرف
  static Future<bool> updateNote(Notemodel updatedNote, String id) async {
    try {
      final notes = await getNotes();
      final updatedList = notes
          .map<Notemodel>((note) => note.id == id ? updatedNote : note)
          .toList();
      await saveAllNotes(updatedList);
      return true;
    } catch (e) {
      print('Error updating note: $e');
      return false;
    }
  }
}
