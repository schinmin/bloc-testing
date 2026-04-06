import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  final User user;
  const UserDetail({super.key, required this.user});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("UserDetail")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              ClipOval(
                child: CircleAvatar(
                  radius: 50,
                  child: const Icon(Icons.person),
                ),
              ),

              Card(
                child: Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Icon(Icons.person),
                        trailing: Text("email : ${widget.user.company}} "),
                      ),
                      ListTile(
                        title: const Icon(Icons.person),
                        trailing: Text("email : ${widget.user.email}} "),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
