import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  // bool showSpinner = false;
  bool checked = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(width: 5, color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: const Text("E-Hunger",
                    style: TextStyle(fontSize: 34.0, color: Colors.purple)),
              ),
              const SizedBox(height: 50),
              Container(
                  width: 500,
                  height: 450,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 215, 237, 255),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text("Login",
                          style: TextStyle(fontSize: 40, color: Colors.blue)),
                      const Text("Sign in to your account",
                          style: TextStyle(fontSize: 15)),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 191, 191, 191)),
                        decoration: InputDecoration(
                            hintText: "Email",
                            errorText:
                                _validateEmail ? 'Value can\'t be empty' : null,
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            prefixIcon: const Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(
                                  Icons.mail,
                                  color: Colors.grey,
                                )),
                            filled: true,
                            fillColor:
                                const Color.fromARGB(255, 218, 218, 218)),
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
                            errorText: _validatePassword
                                ? 'Value can\'t be empty'
                                : null,
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            prefixIcon: const Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(
                                  Icons.key,
                                  color: Colors.grey,
                                )),
                            filled: true,
                            fillColor:
                                const Color.fromARGB(255, 218, 218, 218)),
                        onChanged: (value) {
                          password = value;
                          //Do something with the user input.
                        },
                      ),
                      Container(
                        child: Row(
                          children: [
                            Checkbox(
                                value: checked,
                                onChanged: (bool? value) => {
                                      setState(() {
                                        checked = value!;
                                      })
                                    }),
                            const Text("Remember me"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                              padding:
                                  const EdgeInsets.fromLTRB(120, 10, 120, 10)),
                          child: const Text('Log In'),
                          onPressed: () async {
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Navigator.pushNamed(context, 'home_screen');
                              }
                            } catch (e) {
                              if (!_validateEmail && !_validatePassword) {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => const AlertDialog(
                                          content:
                                              Text("Invalid email or password"),
                                        ));
                              }
                            }
                            setState(() {
                              if (_email.text.isEmpty &&
                                  _password.text.isEmpty) {
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
                          }),
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.transparent),
                              elevation: MaterialStatePropertyAll<double>(0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          onPressed: () =>
                              Navigator.pushNamed(context, 'forgot_password'),
                          child: const Text("I forgot my password",
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Create a new account? "),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.transparent),
                                  elevation:
                                      const MaterialStatePropertyAll<double>(0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(0))),
                              onPressed: () => Navigator.pushNamed(
                                  context, 'registration_screen'),
                              child: const Text("Sign up here!",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline))),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
