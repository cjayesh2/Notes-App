import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/note.dart';

class AddNewPage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewPage({Key? key, required this.isUpdate, this.note})
      : super(key: key);
  @override
  _AddNewPageState createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  FocusNode noteFocus = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  void addNewNote() {
    Note newnote = Note(
        id: const Uuid().v1(),
        userid: "Jayesh",
        title: titleController.text,
        content: contentController.text,
        dateadded: DateTime.now());

    Provider.of<NotesProvider>(context, listen: false).addNote(newnote);
    Navigator.of(context).pop();
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;

    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isUpdate) {
                  updateNote();
                } else {
                  addNewNote();
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                onSubmitted: (val) {
                  if (val != "") {
                    noteFocus.requestFocus();
                  }
                },
                autofocus: (widget.isUpdate == true) ? false : true,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Title")),
            Expanded(
              child: TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  maxLines: null,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Note")),
            ),
          ],
        ),
      )),
    );
  }
}
