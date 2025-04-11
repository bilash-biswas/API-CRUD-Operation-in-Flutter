import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_crud_mvvm/models/user_model.dart';
import 'package:flutter_api_crud_mvvm/viewmodels/user_view_mode.dart';
import 'package:provider/provider.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  final titleController = TextEditingController();
  final emailController = TextEditingController();
  late UserModel user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    titleController.text = user.name;
    emailController.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Note"),
          actions: [
            IconButton(
              onPressed: () {
                final title = titleController.text;
                final email = emailController.text;
                if (title.isNotEmpty && email.isNotEmpty) {
                  final userVM =
                      Provider.of<UserViewModel>(context, listen: false);
                  userVM.updateUser(user.id, title, email);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    labelText: "Enter Name", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    labelText: "Enter Email", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Created At : ${user.create_at}",
                    textAlign: TextAlign.end,
                  ))
            ],
          ),
        ));
  }
}
