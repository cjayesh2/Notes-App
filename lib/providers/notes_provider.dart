import 'package:flutter/material.dart';
import 'package:notesapp/services/api_service.dart';

import '../models/note.dart';


class NotesProvider with ChangeNotifier{

  bool isLoading = true;

  NotesProvider(){
    fetchNotes();
  }

  void sortNote(){
    notes.sort((a,b)=> a.dateadded!.compareTo(b.dateadded!));
  }


List<Note> notes = [];

void addNote(Note note){
  notes.add(note);
  notifyListeners();
  ApiService.addNote(note);
}

void updateNote(Note note){
int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
notes[indexOfNote] = note;
notifyListeners();
ApiService.addNote(note);
}

void deleteNote(Note note){
  int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
  notes.removeAt(indexOfNote);
  sortNote();
  notifyListeners();
  ApiService.deleteNote(note);
}

void fetchNotes() async{
 notes = await ApiService.fetchNotes("Jayesh");
 isLoading = false;
 notifyListeners();
 
}


}