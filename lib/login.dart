import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/mainscreen.dart';
import 'package:parking/registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginForm({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Check if there is a saved email and set it as the initial value
    getSavedEmail().then((savedEmail) {
      if (savedEmail != null) {
        setState(() {
          _emailController.text = savedEmail;
        });
      }
    });
  }

  Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  Future<void> loginUser(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://192.168.56.133:8000/api/login');

    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // Login successful
      final responseData = json.decode(response.body);
      final authToken = responseData['access_token'];
      debugPrint('Login successful. Auth token: $authToken');
      saveEmail(email);
      Get.snackbar(
        "Success",
        "Logged in successfully",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    } else {
      // Login failed
      final responseData = json.decode(response.body);
      final errorMessage = responseData['message'];
      Get.snackbar(
        "Login Failed",
        errorMessage,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      debugPrint('Login failed: $errorMessage');
    }
  }

  void _submitForm() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      loginUser(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 500,
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                obscureText: !_obscurePassword,
                decoration:  InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Builder(
                    builder: (context) {
                      return IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      );
                    }
                  ),
                
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
              const SizedBox(height: 24),
              _isLoading
                  ? const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Welcome to the Ardhi Parking Management'),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Login'),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const RegistrationPage()),
                    ),
                  );
                },
                child: const Text('Register if you don\'t have an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Parking Login')),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: LoginForm(),
      ),
    );
  }
}
