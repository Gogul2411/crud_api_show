import 'package:crud_api_show/core/colors.dart';
import 'package:crud_api_show/homescreen/model/user_model.dart';
import 'package:crud_api_show/homescreen/viewmodel/home_view_model.dart';
import 'package:crud_api_show/homescreen/views/add_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<HomeViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Users List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: userProvider.users.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: userProvider.users.length,
                itemBuilder: (context, index) {
                  final user = userProvider.users[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 223, 223, 223),
                              spreadRadius: 1,
                              blurRadius: 1),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                name(user),
                                const SizedBox(
                                  height: 3,
                                ),
                                mobile(user),
                                const SizedBox(
                                  height: 3,
                                ),
                                email(user),
                                const SizedBox(
                                  height: 3,
                                ),
                                gender(user),
                              ],
                            ),
                            userProvider.users.length > 1
                                ? IconButton(
                                    icon: const Icon(
                                        Icons.delete), // Icon to display
                                    onPressed: () {
                                      Future.delayed(
                                        Duration.zero,
                                        () async {
                                          await Future.delayed(
                                            Duration.zero,
                                            () async {
                                              userProvider.itemId = user.id;
                                            },
                                          );
                                          await userProvider.deleteItemById();
                                          await userProvider.fetchUsers();
                                        },
                                      );
                                    },
                                    color: Colors.red, // Color of the icon
                                    iconSize: 30, // Size of the icon
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddCustomer();
              },
            ),
          );
        },
        label: const Text(
          'Add Customer',
          style: TextStyle(fontSize: 17),
        ),
        icon: const Icon(Icons.add_circle_outline, size: 30),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Row gender(UserModel user) {
    return Row(
      children: [
        const Text(
          'Gender : ',
          style: TextStyle(
              color: Colors.black45, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          user.gender,
          style: const TextStyle(color: Colors.black45, fontSize: 16),
        ),
      ],
    );
  }

  Row email(UserModel user) {
    return Row(
      children: [
        const Text(
          'Email : ',
          style: TextStyle(
              color: Colors.black45, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          user.email,
          style: const TextStyle(
            color: Colors.black45,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Row mobile(UserModel user) {
    return Row(
      children: [
        const Text(
          'Mobile : ',
          style: TextStyle(
              color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          user.mobile,
          style: const TextStyle(color: Colors.black54, fontSize: 16),
        ),
      ],
    );
  }

  Row name(UserModel user) {
    return Row(
      children: [
        const Text(
          'Name : ',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          user.name.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    );
  }
}
