import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/pages/add_new_node.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: notesProvider.notes.length>0 ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: notesProvider.notes.length,
            itemBuilder: (context, index) {
              Note currentNote = notesProvider.notes[index];
              return GestureDetector(
                    onTap: (){
                      // update
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context)=>  AddNewPage(isUpdate: true,note: currentNote,)));
                    },
                    onLongPress: (){
                      // delete
                      notesProvider.deleteNote(currentNote);
                    },
                    child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color:Colors.grey,width:2)
                    ),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     Text(currentNote.title!,style: const TextStyle(fontSize:20,fontWeight:FontWeight.w600),maxLines: 1,overflow: TextOverflow.ellipsis,),
                     const SizedBox(height:7),
                     Text(currentNote.content!,maxLines: 5,overflow: TextOverflow.ellipsis,)


                    ]),
                    
                    
                    ),
              );
            }): const Center(child: Text("No Notes yet")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddNewPage(isUpdate: false,),
            )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
