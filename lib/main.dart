import 'package:flutter/material.dart';
import 'package:flutter_api_crud_mvvm/routes/routes.dart';
import 'package:flutter_api_crud_mvvm/viewmodels/user_view_mode.dart';
import 'package:flutter_api_crud_mvvm/views/add_note_page.dart';
import 'package:flutter_api_crud_mvvm/views/home_page.dart';
import 'package:flutter_api_crud_mvvm/views/update_note_page.dart';
import 'package:provider/provider.dart';

import 'viewmodels/MyTheme.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => MyTheme()),
      ],
      child: Consumer<MyTheme>(
        builder: (context, themeVM, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter MVVM App",
          theme: themeVM.isDarkTheme
              ? ThemeData.dark().copyWith(
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: Colors.black,
                  cardColor: Colors.grey[900],
                  dividerColor: Colors.white54,
                  primaryColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.white),
                  textTheme: ThemeData.dark().textTheme.apply(
                        bodyColor: Colors.white,
                        displayColor: Colors.white,
                      ),
                )
              : ThemeData.light().copyWith(
                  brightness: Brightness.light,
                  scaffoldBackgroundColor: Colors.white,
                  cardColor: Colors.white,
                  dividerColor: Colors.grey,
                  primaryColor: Colors.blue,
                  iconTheme: const IconThemeData(color: Colors.black),
                  textTheme: ThemeData.light().textTheme.apply(
                        bodyColor: Colors.black,
                        displayColor: Colors.black,
                      ),
                ),
          themeMode: ThemeMode.system,
          home: const HomePage(),
          routes: {
            MyRoutes.homeRoute: (context) => const HomePage(),
            MyRoutes.addNoteRoute: (context) => const AddNotePage(),
            MyRoutes.updateNoteRoute: (context) => const UpdateNotePage(),
          },
        ),
      ),
    );
  }
}
