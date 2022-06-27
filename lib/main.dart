import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/Screens/api_view.dart';
import 'package:test_task/Screens/login_screen.dart';
import 'package:test_task/provider/app_state.dart';
import 'package:test_task/provider/auth_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MaterialApp(
        home: Consumer<AuthenticationProvider>(
            builder: (context, auth, child) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (auth.isLogedin == true) {
                   ApiView();
                }
              });
              return LoginPage();
            }),
      ),
    );
  }
}
