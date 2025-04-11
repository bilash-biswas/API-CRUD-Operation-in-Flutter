import 'package:flutter/material.dart';
import 'package:flutter_api_crud_mvvm/routes/routes.dart';
import 'package:flutter_api_crud_mvvm/viewmodels/user_view_mode.dart';
import 'package:flutter_api_crud_mvvm/views/add_note_page.dart';
import 'package:flutter_api_crud_mvvm/views/home_page.dart';
import 'package:flutter_api_crud_mvvm/views/update_note_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (_) => UserViewModel()..getUsers(),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter MVVM App",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.addNoteRoute: (context) => const AddNotePage(),
        MyRoutes.updateNoteRoute: (context) => const UpdateNotePage(),
      },
    );
  }
}




