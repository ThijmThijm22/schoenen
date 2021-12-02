import 'package:flutter/material.dart';

// Services
import 'package:schoenen/services/globals.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:schoenen/providers/themeprov.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);

    return Scaffold(
      backgroundColor: themeProv.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Center(
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    NewInput(
                      placeholder: "Enter Email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 30),
                    NewInput(
                      placeholder: "Enter Password",
                      controller: passwordController,
                      obscure: true,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(themeProv.btnColor),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              )
                              .then(
                                  (_) => Navigator.pushNamed(context, '/home'));
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(themeProv.btnColor),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              )
                              .then(
                                  (_) => Navigator.pushNamed(context, '/home'));
                        },
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 200, child: Image.asset('assets/femrunner.png')),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NewInput extends StatelessWidget {
  late String placeholder;
  late TextEditingController controller;
  late bool obscure;
  NewInput({Key? key, this.placeholder = '', required this.controller, this.obscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: placeholder,
        focusColor: themeProv.btnColor,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
      ),
    );
  }
}
