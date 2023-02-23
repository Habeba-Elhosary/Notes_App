import 'package:flutter/material.dart';
import 'package:notes_app/sqldb.dart';

class EditNotes extends StatefulWidget {
  final note ;
  final title ;
  final id ;
  const EditNotes({Key? key, this.note, this.title, this.id}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    note.text =widget.note ;
    title.text =widget.title ;
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
              'Edit Notes',
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
                        int response = await sqlDb.updateData('''
                        UPDATE notes set note = "${note.text}",
                        title = "${title.text}"
                        WHERE id = ${widget.id}
                        ''');
                        if (response > 0) {
                          Navigator.of(context).pushNamed("Home");
                        }
                      },
                      color: Colors.purple,
                      child: const Text(
                        "Edit Notes",
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
