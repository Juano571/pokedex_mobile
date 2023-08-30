import 'package:flutter/material.dart';
import 'package:pokedex_mobile/main.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'pokemon-login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to Pokedex'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                size: 100,
                Icons.person,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, bottom: 20, top: 20),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                loginProvider.loginWithEmailPassword(
                    _emailController.text, _passwordController.text);
                if (loginProvider.user != null) {
                  Navigator.pushNamed(context, MainWidget.routeName);
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
