import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/core/constans/colors.dart';
import 'package:noteapp/data/local_data_source.dart';
import 'package:noteapp/model/notemodel.dart';
import 'package:noteapp/view/screens/Addnoteview.dart';
import 'package:noteapp/view/screens/EditNote.dart';
import 'package:noteapp/view/screens/NoteView.dart';
import 'package:noteapp/view/widget/Notelistitem.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noteapp/view/widget/searchBar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Notemodel> data = [];

  void deletemodel(Notemodel notemodel) async {
    if (await LocalDataSource.deleteNote(notemodel.id)) {
      getdata();
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('succces'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('failed'), backgroundColor: Colors.red),
      );
    }
  }

  void Edit(Notemodel note, String newtitle, String newcontnt) async {
    Notemodel newnote = Notemodel(
      id: note.id,
      title: newtitle,
      content: newcontnt,
      Date: note.Date,
      Time: note.Time,
    );
    if (await LocalDataSource.updateNote(newnote, note.id)) {
      getdata();

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('succces'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('failed'), backgroundColor: Colors.red),
      );
    }
  }

  getdata() async {
    data = await LocalDataSource.getNotes();
    setState(() {});
  }

  @override
  void initState() {
    // ✅ صحيح
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ), // الثلاث نقاط
            Text("NoteApp", style: TextStyle(fontSize: 20)), // التايتل بالوسط
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: searchBar(data: data),
                );
              },
              icon: Icon(Icons.search),
            ), // البحث
          ],
        ),
      ),
      body: data.isEmpty
          ? Center(
              child: LottieBuilder.asset(
                'assets/lottie/note.json',
                height: 100,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: data.isEmpty
                      ? Text('no notes')
                      : Text('${data.length} notes'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Notelistitem(
                              note: data[index],
                              onDelete: () {
                                deletemodel(data[index]);
                              },
                              onEdite: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (context) => EditNote(
                                    note: data[index],
                                    onPressed: (title, content) {
                                      Edit(data[index], title, content);
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      onRefresh: () {
                        return getdata();
                      },
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => Addnotenew(
              onPressed: () async {
                await getdata();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
