import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//code for designing the UI of our text field where the user writes his email id or password

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _validateEmail = false;
  bool _validatePassword = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 0.7],
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Text("Sign Up",
                      style: TextStyle(fontSize: 34.0, color: Colors.purple)),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 191, 191, 191)),
                  decoration: InputDecoration(
                      hintText: "Email/Phone Number",
                      errorText:
                          _validateEmail ? 'Value can\'t be empty' : null,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      prefixIcon: const Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            Icons.mail,
                            color: Colors.grey,
                          )),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 218, 218, 218)),
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 191, 191, 191)),
                  decoration: InputDecoration(
                      hintText: "Password",
                      errorText:
                          _validatePassword ? 'Value can\'t be empty' : null,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      prefixIcon: const Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            Icons.key,
                            color: Colors.grey,
                          )),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 218, 218, 218)),
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    side: const BorderSide(width: 1, color: Colors.green),
                  ),
                  child: const Text('Register'),
                  onPressed: () async {
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, 'login_screen');
                      }
                    } catch (e) {
                      if (!_validateEmail && !_validatePassword) {
                        showDialog(
                            context: context,
                            builder: (ctx) => const AlertDialog(
                                  content:
                                      Text("Invalid form of email or password"),
                                ));
                      }
                    }
                    setState(() {
                      if (_email.text.isEmpty && _password.text.isEmpty) {
                        _validateEmail = true;
                        _validatePassword = true;
                      } else if (_email.text.isEmpty) {
                        _validateEmail = true;
                      } else if (_password.text.isEmpty) {
                        _validatePassword = true;
                      } else {
                        _validateEmail = false;
                        _validatePassword = false;
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ));
  }
}
