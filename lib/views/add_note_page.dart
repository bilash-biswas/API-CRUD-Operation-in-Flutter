import 'package:flutter/material.dart';
import 'package:flutter_api_crud_mvvm/viewmodels/user_view_mode.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        actions: [
          IconButton(onPressed: () {
            final name = nameController.text;
            final email = emailController.text;
            if (name.isNotEmpty && email.isNotEmpty) {
              final userVM = Provider.of<UserViewModel>(context, listen: false);
              userVM.addUser(name, email);
              Navigator.pop(context);
            }
          }, icon: const Icon(Icons.save),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
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
          ],
        ),
      ),
    );
  }
}
