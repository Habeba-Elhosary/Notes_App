import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/sqldb.dart';

import 'editnotes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SqlDb sqlDb = SqlDb();
  List notes = [];
  bool isLoading = true;

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Notes App',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addNotes");
        },
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: isLoading == true
          ? const Center(child: Text("Loading..."))
          : Container(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListView.builder(
                      itemCount: notes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                            child: ListTile(
                                title: Text("${notes[i]['title']}"),
                                subtitle: Text("${notes[i]['note']}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => EditNotes(
                                                      note: notes[i]['note'],
                                                      title: notes[i]['title'],
                                                      id: notes[i]['id'],
                                                    )));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.purple,
                                        size: 22,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        int response =
                                            await sqlDb.deleteData('''
                                DELETE FROM notes WHERE id =${notes[i]['id']}
                                ''');
                                        if (response > 0) {
                                          notes.removeWhere((element) =>
                                              element['id'] == notes[i]['id']);
                                          setState(() {});
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.purple,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                )));
                      })
                ],
              ),
            ),
    );
  }
}
