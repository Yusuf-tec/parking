// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parking/mainscreen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  

  Future<void> registerUser(String username, String email, String password) async {
  final url = Uri.parse('http://192.168.56.133:8000/api/register');

  final response = await http.post(url, body: {
    'username': username,
    'email': email,
    'password': password,
  });

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final authToken = responseData['access_token'];
    // Registration successful
   debugPrint('Registration successful. Auth token: $authToken');
      Get.snackbar("Success", "Registered in successfull",
      snackPosition: SnackPosition.TOP,colorText: Colors.white, backgroundColor: Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
     
    // Handle success case, such as navigating to the next screen
  } else {
    // Registration failed
    final responseData = json.decode(response.body);
    final errorMessage = responseData['message'];
    debugPrint('Registration failed: $errorMessage');
    // Handle error case, such as displaying an error message to the user
  }
}

  void _submitForm() {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    
    if (_formKey.currentState!.validate()) {
      registerUser(name, email, password);
      // Form is valid, perform registration logic here
      // You can access the entered email and password using _email and _password variables
      debugPrint('Email: $_email');
      debugPrint('Password: $_password');
      debugPrint('Name: $_name');
 
      // Navigate to the home screen after successful registration
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Registration Page')),
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          width: 300,
          
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          
        ),
      ),
    );
  }
}
