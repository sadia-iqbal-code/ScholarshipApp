import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholarshipapp/categories.dart';

import 'package:scholarshipapp/newSignup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPassObscure = true;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return category();
        }));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Center(
          child: Container(
            width: 700, // Adjust width as needed
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder()),
                      validator: (value) => value != null && value.isEmpty
                          ? 'Please enter an email'
                          : null,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(isPassObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isPassObscure = !isPassObscure;
                              });
                            },
                          ),
                          border: OutlineInputBorder()),
                      obscureText: isPassObscure,
                      validator: (value) => value != null && value.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Login'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Sign()));
                        },
                        child: Text('Don\'t have an account? Sign up'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
