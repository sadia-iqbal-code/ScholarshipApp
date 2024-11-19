import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholarshipapp/categories.dart';

class Sign extends StatefulWidget {
  @override
  SignState createState() => SignState();
}

class SignState extends State<Sign> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool isPassObscure = true;
  bool isConfirmObscure = true;
  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => category()));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('SignUp')),
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
                            onPressed: () {
                              setState(() {
                                isPassObscure = !isPassObscure;
                              });
                            },
                            icon: Icon(isPassObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder()),
                      obscureText: isPassObscure,
                      validator: (value) => value != null && value.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: confirmController,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmObscure = !isConfirmObscure;
                              });
                            },
                            icon: Icon(isConfirmObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder()),
                      obscureText: isConfirmObscure,
                      validator: (val) {
                        return ValidateConfirmPassword(
                            passwordController.text, confirmController.text);
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _signup,
                      child: Text('Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  String? ValidateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Password is required";
    }
    if (confirmPassword != password) {
      return "Password must be same as above password";
    }
    return null;
  }
}
