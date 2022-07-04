import 'package:flutter/material.dart';
import 'package:notesapp/pages/homepage.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NotesProvider(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          home: HomePage(),
        ));
  }
}
