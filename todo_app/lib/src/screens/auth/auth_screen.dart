import 'package:flutter/material.dart';
import 'package:todo_app/src/controllers/auth_controller.dart';
import 'package:todo_app/src/screens/todo/todo_screen.dart';

class LinkingToAuth extends StatelessWidget {
  LinkingToAuth({Key? key}) : super(key: key);
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _authController,
        builder: (context, Widget? w) {
          if (_authController.currentUser == null) {
            return AuthScreen(_authController);
          } else {
            return TodoScreen(_authController);
          }
        });
  }
}

class AuthScreen extends StatefulWidget {
  final AuthController auth;
  const AuthScreen(
    this.auth, {
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unCon = TextEditingController(),
      _passCon = TextEditingController();
  String prompts = '';
  AuthController get _auth => widget.auth;

  @override
  void initState() {
    prompts = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        //safearea secures the whole body to stay within the safe area (not to lapas nav items)
        child: Center(
          child: SingleChildScrollView(
            //tips for singlechildscrollview
            //used to not let thing overflow when dealing with keyboard
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                onChanged: () {
                  _formKey.currentState?.validate();
                  if (mounted) {
                    setState(() {});
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: prompts.isNotEmpty
                            ? Text(
                                'MESSAGE ENCOUNTERED:\n$prompts',
                                textAlign: TextAlign.center,
                              )
                            : null),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Username'),
                      controller: _unCon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      controller: _passCon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed:
                                  (_formKey.currentState?.validate() ?? false)
                                      ? () {
                                          String result = _auth.register(
                                              _unCon.text, _passCon.text);
                                          setState(() {
                                            prompts = result;
                                          });
                                        }
                                      : null,
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  primary: (_formKey.currentState?.validate() ??
                                          false)
                                      ? Colors.orange
                                      : Colors.grey),
                              child: const Text('Register'),
                            ),
                            ElevatedButton(
                              onPressed:
                                  (_formKey.currentState?.validate() ?? false)
                                      ? () {
                                          bool result = _auth.login(
                                              _unCon.text, _passCon.text);
                                          if (!result) {
                                            setState(() {
                                              prompts =
                                                  'Error logging in, username or password may be incorrect or the user has not been registered yet.';
                                            });
                                          }
                                        }
                                      : null,
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  primary: (_formKey.currentState?.validate() ??
                                          false)
                                      ? Colors.orange
                                      : Colors.grey),
                              child: const Text('Log in'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
