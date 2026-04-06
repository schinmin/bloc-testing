import 'package:bloc_testing/features/companylist/presentation/screen/companies_list.dart';
import 'package:bloc_testing/features/home/bloc/home_bloc.dart';
import 'package:bloc_testing/features/userlist/presentation/userlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchHomeData(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is HomeFailure) {
            return Center(child: Text(state.error));
          } else if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  ClipOval(
                    child: CircleAvatar(radius: 50, child: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome ${state.user.name}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(state.user.email),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        "Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(state.user.address),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        "Company",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(state.user.company),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Welcome to ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ClipOval(
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.network(
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, size: 50),
                        'https://avatars.githubusercontent.com/u/12345678?v=4',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state is HomeSuccess
                        ? 'Hello, ${state.user.name}!'
                        : 'Hello, Guest!',
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );

                // Handle home button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserList()),
                );
                // Handle profile button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.crop_original_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompaniesList()),
                );
                // Handle settings button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
