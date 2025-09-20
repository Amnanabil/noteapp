import 'package:flutter/foundation.dart';

class Notemodel {
  final String id;
  final String title;
  final String content;
  final String Date;
  final String Time;
  Notemodel({
    required this.id,
    required this.title,
    required this.content,
    required this.Date,
    required this.Time,
  });
  factory Notemodel.fromJson(json) {
    return Notemodel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      Date: json['Date'],
      Time: json['Time'],
    );
  }
  toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'Date': Date,
      'Time': Time,
    };
  }
}
