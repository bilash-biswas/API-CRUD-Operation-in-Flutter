import 'package:flutter/material.dart';
import 'package:flutter_api_crud_mvvm/routes/routes.dart';
import 'package:flutter_api_crud_mvvm/viewmodels/user_view_mode.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users CRUD with MVVM'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                controller: searchController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    labelText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onChanged: (query) {
                  userVM.filterUsers(query);
                }),
          ),
          Expanded(
            child: userVM.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: userVM.users.length,
                      itemBuilder: (_, index) {
                        final user = userVM.users[index];
                        return Card(
                          elevation: 4,
                          color: Colors.grey[200],
                          borderOnForeground: true,
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MyRoutes.updateNoteRoute,
                                  arguments: user);
                            },
                            title: Text(user.name),
                            subtitle: Text(user.email),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                                title:
                                                    const Text("Delete User"),
                                                content: const Text(
                                                    "Are you sure you want to delete this user?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      userVM
                                                          .deleteUser(user.id);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Delete"),
                                                  )
                                                ]));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.addNoteRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
