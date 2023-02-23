import 'package:flutter/material.dart';
import 'package:notes_app/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Add Notes',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(45),
        child: ListView(
          children: [
            Form(
                key: formState,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "title",
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple))),
                      cursorColor: Colors.purple,
                      controller: title,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "note",
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple))),
                      cursorColor: Colors.purple,
                      controller: note,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 10),
                      onPressed: () async {
                        int response = await sqlDb.insertData('''
                        INSERT INTO notes (note , title )
                        VALUES ("${note.text}","${title.text}")
                        ''');
                        if (response > 0) {
                          Navigator.of(context).pushNamed("Home");
                        }
                      },
                      color: Colors.purple,
                      child: const Text(
                        "Add Notes",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
