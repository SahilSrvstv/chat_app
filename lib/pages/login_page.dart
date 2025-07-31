import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  //email and password text controller
  final TextEditingController _emailControlller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // tap to go on register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //login method
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
          _emailControlller.text, _passwordController.text);
    }

    // catch any error
    catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 50,
          ),
          //welcome back message
          Text(
            "Welcome Back !!!",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),
          //email text field
          MyTextField(
            hintText: 'Email',
            obscureText: false,
            controller: _emailControlller,
          ),
          const SizedBox(
            height: 10,
          ),
          //password text field
          MyTextField(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 25,
          ),
          //login button
          MyButton(
            text: 'Login',
            onTap: () => login(context),
          ),
          const SizedBox(
            height: 25,
          ),
          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register Now!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
