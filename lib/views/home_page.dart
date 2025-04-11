import 'package:flutter/material.dart';
import 'package:flutter_api_crud_mvvm/routes/routes.dart';
import 'package:flutter_api_crud_mvvm/viewmodels/MyTheme.dart';
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
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<UserViewModel>(context, listen: false).getUsers());
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    searchController.dispose();
    Provider.of<UserViewModel>(context, listen: false).users.clear();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    final themeVM = Provider.of<MyTheme>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users CRUD with MVVM'),
        actions: [
          IconButton(
            onPressed: () {
              themeVM.toggleTheme();
            },
            icon:
                Icon(themeVM.isDarkTheme ? Icons.light_mode : Icons.dark_mode),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                  controller: searchController,
                  focusNode: _searchFocusNode,
                  cursorColor: Theme.of(context).primaryColor,
                  autofocus: false,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      labelText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  onChanged: (query) {
                    userVM.filterUsers(query);
                  }),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await userVM.getUsers();
                },
                child: userVM.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: userVM.users.length,
                          itemBuilder: (_, index) {
                            final user = userVM.users[index];
                            return Card(
                              elevation: 3,
                              color: Theme.of(context).cardColor,
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
                                                    title: const Text(
                                                        "Delete User"),
                                                    content: const Text(
                                                        "Are you sure you want to delete this user?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          userVM.deleteUser(
                                                              user.id);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Delete"),
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
            ),
          ],
        ),
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
