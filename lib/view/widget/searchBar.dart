import 'package:flutter/material.dart';
import 'package:noteapp/model/notemodel.dart';
import 'package:noteapp/view/screens/NoteView.dart';

class searchBar extends SearchDelegate {
  List<Notemodel>? data;
  List filternames = [];
  Notemodel? selected;
  searchBar({required this.data});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (selected == null) {
      return Center(child: Text('لم يتم اختيار ملاحظة'));
    }

    return ListTile(
      title: Text(selected!.title ?? ''),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Noteview(note: selected!)),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return ListView.builder(
        itemCount: data?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data![index].title ?? ''),
            onTap: () {
              selected = data![index];
              showResults(context); // يفتح buildResults
            },
          );
        },
      );
    } else {
      filternames = (data ?? [])
          .where(
            (s) =>
                (s.title ?? '').toLowerCase().contains(query.toLowerCase()) ||
                (s.content ?? '').toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      return ListView.builder(
        itemCount: filternames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filternames[index].title ?? ''),
            onTap: () {
              selected = filternames[index];
              showResults(context); // يفتح buildResults
            },
          );
        },
      );
    }
  }
}
