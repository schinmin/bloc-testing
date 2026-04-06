import 'package:bloc_testing/features/userlist/bloc/userlist_bloc.dart';
import 'package:bloc_testing/features/userlist/presentation/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    context.read<UserlistBloc>().add(FetchUserlist(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: BlocConsumer<UserlistBloc, UserlistState>(
        listener: (context, state) {
          if (state is UserlistLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Loading user list...')),
            );
          } else if (state is UserlistFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          }
        },
        builder: (context, state) {
          return state is UserlistSuccess
              ? ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetail(user: user),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(child: Icon(Icons.person)),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No users found'));
        },
      ),
    );
  }
}
