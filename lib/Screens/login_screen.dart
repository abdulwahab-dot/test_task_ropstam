import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/Utils/navigator.dart';
import 'package:test_task/Utils/snack_bar.dart';
import 'package:test_task/Widgets/buttons.dart';
import 'package:test_task/Widgets/test_field.dart';
import 'package:test_task/provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Login ')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 90),
              child: Column(
                children: [
                  Text(
                    'Welcome Back!!',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: Colors.purpleAccent),
                  ),
                  Text('Please LogIn To Continue',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.purpleAccent)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          customTextField(
                            title: 'Email',
                            controller: _email,
                            hint: 'Enter you valid email address',
                          ),
                          customTextField(
                            title: 'Password',
                            controller: _password,
                            hint: 'Enter your secured password',
                          ),

                          ///Button
                          Consumer<AuthenticationProvider>(
                              builder: (context, auth, child) {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              if (auth.resMessage != '') {
                                showMessage(
                                    message: auth.resMessage, context: context);

                                ///Clear the response message to avoid duplicate
                                auth.clear();
                              }
                            });
                            return customButton(
                              text: 'Login',
                              tap: () {
                                if (_email.text.isEmpty &&
                                    _password.text.isEmpty) {
                                  showMessage(
                                      message: "All fields are required",
                                      context: context);
                                } else {
                                  auth.loginUser(
                                      context: context,
                                      email: _email.text.toString().trim(),
                                      password:
                                          _password.text.toString().trim());
                                }
                              },
                              context: context,
                              status: auth.isLoading,
                            );
                          }),

                          const SizedBox(
                            height: 10,
                          ),

                          GestureDetector(
                            onTap: () {},
                            child: const Text('Don\'t Have An Account?'),
                          )
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
