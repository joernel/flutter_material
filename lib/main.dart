import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      home: const HomePage(),
    );
  }
}

Route<dynamic>? _getRoute(RouteSettings settings) {
  if (settings.name != '/login') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => const LoginPage(title: 'Flutter Material 1'),
    fullscreenDialog: true,
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const SizedBox(height: 80.0),
            Column(
              children: [Image.asset('assets/diamond.png'), Text('LOGIN')],
            ),
            const SizedBox(height: 80.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: false,
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: false,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();         },
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            )
          ],
        )));
  }
}
