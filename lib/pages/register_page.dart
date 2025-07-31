import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  //email and password text controller
  final TextEditingController _emailControlller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //register method
  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();

    // if passwords match -> create the user
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailControlller.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!!!"),
        ),
      );
    }
    // if passwords don't match -> display an error
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
            "Let's creat an acount for you !!!",
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
            height: 10,
          ),
          //confirm password text field
          MyTextField(
            hintText: 'Confirm Password',
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(
            height: 25,
          ),
          //login button
          MyButton(
            text: 'Register',
            onTap: () => register(context),
          ),
          const SizedBox(
            height: 25,
          ),
          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login Now!",
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
